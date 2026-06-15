import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../config/app_config.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream of auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  User? get currentUser => _auth.currentUser;

  // Email & Password Sign Up
  Future<UserModel?> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      User? user = result.user;
      if (user == null) return null;

      // Send email verification
      await user.sendEmailVerification();

      // Create user profile in Firestore
      UserModel userModel = UserModel(
        uid: user.uid,
        email: email,
        displayName: displayName,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection(AppConfig.usersCollection)
          .doc(user.uid)
          .set(userModel.toMap());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Email & Password Sign In
  Future<UserModel?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      User? user = result.user;
      if (user == null) return null;

      // Update last active
      await _firestore
          .collection(AppConfig.usersCollection)
          .doc(user.uid)
          .update({'lastActive': DateTime.now()});

      return await _getUserData(user.uid);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Google Sign In
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      if (user == null) return null;

      // Check if user exists
      DocumentSnapshot doc = await _firestore
          .collection(AppConfig.usersCollection)
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        UserModel userModel = UserModel(
          uid: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? googleUser.displayName,
          photoUrl: user.photoURL ?? googleUser.photoUrl,
          isEmailVerified: true,
        );
        await _firestore
            .collection(AppConfig.usersCollection)
            .doc(user.uid)
            .set(userModel.toMap());
      }

      return await _getUserData(user.uid);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Forgot Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Get User Data
  Future<UserModel?> _getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection(AppConfig.usersCollection)
          .doc(uid)
          .get();
      
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, uid);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Update User Profile
  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    String? bio,
  }) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception('No user logged in');

    Map<String, dynamic> updates = {};
    if (displayName != null) updates['displayName'] = displayName;
    if (photoUrl != null) updates['photoUrl'] = photoUrl;
    if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;
    if (bio != null) updates['bio'] = bio;

    await _firestore
        .collection(AppConfig.usersCollection)
        .doc(user.uid)
        .update(updates);
  }

  // Refresh Email Verification
  Future<void> sendVerificationEmail() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // Check Email Verification
  Future<bool> isEmailVerified() async {
    await _auth.currentUser?.reload();
    return _auth.currentUser?.emailVerified ?? false;
  }

  // Handle Auth Exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'An account with this email already exists';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'operation-not-allowed':
        return 'This sign-in method is not available';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method';
      default:
        return 'An error occurred. Please try again';
    }
  }
}