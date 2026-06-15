import 'package:flutter/material.dart';
import '../../../core/theme/theme_manager.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _selectedPlan = 'premium_monthly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SumadColors.backgroundDark,
      appBar: AppBar(title: const Text('Choose Your Plan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Unlock Premium Features', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Ad-free streaming in 4K quality', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 15)),
            const SizedBox(height: 32),

            // Free Plan
            _buildPlanCard(
              'Free',
              '\$0',
              'Basic access',
              ['480p quality', 'Ads supported', '1 device', 'No downloads'],
              Colors.grey,
              _selectedPlan == 'free',
              () => setState(() => _selectedPlan = 'free'),
            ),
            const SizedBox(height: 16),

            // Premium Monthly
            _buildPlanCard(
              'Premium Monthly',
              '\$9.99',
              '/month',
              ['4K Ultra HD quality', 'No ads', '4 devices', '25 downloads', 'Watch offline'],
              SumadColors.primary,
              _selectedPlan == 'premium_monthly',
              () => setState(() => _selectedPlan = 'premium_monthly'),
              isPopular: true,
            ),
            const SizedBox(height: 16),

            // Premium Yearly
            _buildPlanCard(
              'Premium Yearly',
              '\$89.99',
              '/year (save 25%)',
              ['All Premium features', '6 devices', 'Unlimited downloads', 'Early access', 'Priority support'],
              SumadColors.premium,
              _selectedPlan == 'premium_yearly',
              () => setState(() => _selectedPlan = 'premium_yearly'),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity, height: 54,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(_selectedPlan == 'free' ? 'Continue with Free' : 'Start Premium', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Cancel anytime. No questions asked.', style: TextStyle(color: Colors.white38, fontSize: 12)),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(String name, String price, String period, List<String> features, Color color, bool selected, VoidCallback onTap, {bool isPopular = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: selected
              ? LinearGradient(colors: [color.withOpacity(0.15), color.withOpacity(0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight)
              : null,
          color: selected ? null : SumadColors.cardDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? color : Colors.white10,
            width: selected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    if (isPopular) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: SumadColors.primary, borderRadius: BorderRadius.circular(6)),
                        child: const Text('POPULAR', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(price, style: TextStyle(color: color, fontSize: 36, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(period, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13))),
                  ],
                ),
                const SizedBox(height: 16),
                ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: color, size: 18),
                      const SizedBox(width: 10),
                      Text(f, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14)),
                    ],
                  ),
                )),
              ],
            ),
            if (selected)
              Positioned(
                top: 0, right: 0,
                child: Icon(Icons.check_circle, color: color, size: 24),
              ),
          ],
        ),
      ),
    );
  }
}