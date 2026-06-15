import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:volume_control/volume_control.dart';
import '../../../core/theme/theme_manager.dart';
import '../../../core/config/app_config.dart';
import '../../widgets/player/player_controls_widget.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  static const String routeName = '/video_player';
  final String videoUrl;
  final String title;
  final Map<String, String>? qualityUrls;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.title,
    this.qualityUrls,
  });

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  String _currentQuality = '720p';
  double _playbackSpeed = 1.0;
  double _brightness = 0.5;
  double _volume = 1.0;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    await _videoController.initialize();
    
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      allowPlaybackSpeedChanging: true,
      allowMuting: true,
      showControls: false,
      placeholder: Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text('Error loading video', style: TextStyle(color: Colors.white.withOpacity(0.7))),
            ],
          ),
        );
      },
    );

    setState(() => _isInitialized = true);
  }

  void _changeQuality(String quality) {
    // In a real app, switch to the appropriate quality URL
    setState(() => _currentQuality = quality);
  }

  void _changeSpeed(double speed) {
    _videoController.setPlaybackSpeed(speed);
    setState(() => _playbackSpeed = speed);
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _isInitialized && _chewieController != null
            ? GestureDetector(
                onTap: () => setState(() => _showControls = !_showControls),
                child: Stack(
                  children: [
                    // Video Player
                    Chewie(controller: _chewieController!),
                    
                    // Custom Controls Overlay
                    if (_showControls)
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black87,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black87,
                            ],
                            stops: [0.0, 0.2, 0.8, 1.0],
                          ),
                        ),
                        child: Column(
                          children: [
                            // Top Bar
                            _buildTopBar(),
                            const Spacer(),
                            // Center Controls
                            _buildCenterControls(),
                            // Bottom Bar
                            _buildBottomBar(),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator(color: SumadColors.primary)),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Cast button
          IconButton(
            icon: const Icon(Icons.cast, color: Colors.white, size: 24),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCenterControls() {
    final isPlaying = _videoController.value.isPlaying;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Rewind 10s
        IconButton(
          icon: const Icon(Icons.replay_10, color: Colors.white, size: 40),
          onPressed: () {
            final pos = _videoController.value.position;
            _videoController.seekTo(Duration(seconds: pos.inSeconds - 10));
          },
        ),
        const SizedBox(width: 24),
        // Play/Pause
        Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: SumadColors.primary.withOpacity(0.9),
          ),
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white, size: 36,
            ),
            onPressed: () {
              isPlaying ? _videoController.pause() : _videoController.play();
              setState(() {});
            },
          ),
        ),
        const SizedBox(width: 24),
        // Forward 10s
        IconButton(
          icon: const Icon(Icons.forward_10, color: Colors.white, size: 40),
          onPressed: () {
            final pos = _videoController.value.position;
            _videoController.seekTo(Duration(seconds: pos.inSeconds + 10));
          },
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    final position = _videoController.value.position;
    final duration = _videoController.value.duration;
    final isPlaying = _videoController.value.isPlaying;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          // Progress Bar
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: SumadColors.primary,
              inactiveTrackColor: Colors.white24,
              thumbColor: SumadColors.primary,
            ),
            child: Slider(
              value: position.inMilliseconds.toDouble().clamp(0, duration.inMilliseconds.toDouble()),
              max: duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                _videoController.seekTo(Duration(milliseconds: value.toInt()));
              },
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                '-${(duration.inMinutes - position.inMinutes).toString().padLeft(2, '0')}:${((duration.inSeconds - position.inSeconds) % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Control Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Quality
              _buildControlButton(
                Icons.hd,
                _currentQuality,
                () => _showQualitySelector(),
              ),
              // Speed
              _buildControlButton(
                Icons.speed,
                '${_playbackSpeed}x',
                () => _showSpeedSelector(),
              ),
              // Subtitles
              _buildControlButton(
                Icons.subtitles,
                'CC',
                () {},
              ),
              // Download
              _buildControlButton(
                Icons.download_outlined,
                '',
                () {},
              ),
              // PiP
              _buildControlButton(
                Icons.picture_in_picture_alt,
                '',
                () {},
              ),
              // Fullscreen
              _buildControlButton(
                Icons.fullscreen,
                '',
                () {
                  _chewieController?.enterFullScreen();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
          ],
        ],
      ),
    );
  }

  void _showQualitySelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: SumadColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Video Quality', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...AppConfig.videoQualities.map((quality) => RadioListTile<String>(
                  title: Text(quality, style: const TextStyle(color: Colors.white)),
                  activeColor: SumadColors.primary,
                  value: quality,
                  groupValue: _currentQuality,
                  onChanged: (value) {
                    if (value != null) {
                      _changeQuality(value);
                      Navigator.pop(context);
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _showSpeedSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: SumadColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Playback Speed', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...AppConfig.playbackSpeeds.map((speed) => RadioListTile<double>(
                  title: Text('${speed}x', style: const TextStyle(color: Colors.white)),
                  activeColor: SumadColors.primary,
                  value: speed,
                  groupValue: _playbackSpeed,
                  onChanged: (value) {
                    if (value != null) {
                      _changeSpeed(value);
                      Navigator.pop(context);
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}