import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/theme_manager.dart';
import '../../../core/config/app_config.dart';
import '../../widgets/admin/stats_card_widget.dart';
import '../../widgets/admin/recent_uploads_widget.dart';

class AdminDashboard extends ConsumerStatefulWidget {
  static const String routeName = '/admin';
  const AdminDashboard({super.key});

  @override
  ConsumerState<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends ConsumerState<AdminDashboard> {
  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.dashboard, 'label': 'Dashboard', 'route': null},
    {'icon': Icons.movie, 'label': 'Movies', 'route': '/admin/movies'},
    {'icon': Icons.tv, 'label': 'Series', 'route': '/admin/series'},
    {'icon': Icons.live_tv, 'label': 'Live TV', 'route': '/admin/live_tv'},
    {'icon': Icons.category, 'label': 'Categories', 'route': '/admin/categories'},
    {'icon': Icons.people, 'label': 'Users', 'route': '/admin/users'},
    {'icon': Icons.subscriptions, 'label': 'Subscriptions', 'route': '/admin/subscriptions'},
    {'icon': Icons.analytics, 'label': 'Analytics', 'route': '/admin/analytics'},
    {'icon': Icons.account_balance_wallet, 'label': 'Revenue', 'route': '/admin/revenue'},
    {'icon': Icons.notifications, 'label': 'Notifications', 'route': '/admin/notifications'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SumadColors.backgroundDark,
      body: SafeArea(
        child: Row(
          children: [
            // Sidebar
            _buildSidebar(),
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Admin Dashboard', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('Manage your streaming platform', style: TextStyle(color: Colors.white.withOpacity(0.5))),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: SumadColors.cardDark,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.cloud_sync, color: Colors.green, size: 18),
                                  SizedBox(width: 8),
                                  Text('Live', style: TextStyle(color: Colors.green, fontSize: 13)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            CircleAvatar(
                              backgroundColor: SumadColors.primary,
                              child: const Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Stats Cards
                    Row(
                      children: [
                        Expanded(child: StatsCardWidget(title: 'Total Users', value: '12,458', change: '+12%', icon: Icons.people, color: Colors.blue)),
                        const SizedBox(width: 16),
                        Expanded(child: StatsCardWidget(title: 'Total Movies', value: '856', change: '+8%', icon: Icons.movie, color: SumadColors.primary)),
                        const SizedBox(width: 16),
                        Expanded(child: StatsCardWidget(title: 'Premium Users', value: '3,247', change: '+23%', icon: Icons.star, color: SumadColors.premium)),
                        const SizedBox(width: 16),
                        Expanded(child: StatsCardWidget(title: 'Revenue', value: '\$48,290', change: '+15%', icon: Icons.trending_up, color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Charts Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Revenue Chart
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: SumadColors.cardDark,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Revenue Overview', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 24),
                                SizedBox(
                                  height: 200,
                                  child: LineChart(
                                    LineChartData(
                                      gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (value) => FlLine(color: Colors.white10, strokeWidth: 1)),
                                      titlesData: FlTitlesData(show: true, bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => Text('${value.toInt()}', style: const TextStyle(color: Colors.white38, fontSize: 10)), reservedSize: 22)), leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => Text('\$${value.toInt()}', style: const TextStyle(color: Colors.white38, fontSize: 10)), reservedSize: 40))),
                                      borderData: FlBorderData(show: false),
                                      lineBarsData: [
                                        LineChartBarData(spots: [FlSpot(0, 1000), FlSpot(1, 2500), FlSpot(2, 1800), FlSpot(3, 3800), FlSpot(4, 3200), FlSpot(5, 4800), FlSpot(6, 4200)], isCurved: true, color: SumadColors.primary, barWidth: 3, dotData: FlDotData(show: false), belowBarData: BarAreaData(show: true, color: SumadColors.primary.withOpacity(0.1))),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Recent Activity
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: SumadColors.cardDark,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Recent Uploads', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 16),
                                ...List.generate(5, (i) => RecentUploadsWidget(
                                  title: 'Movie Title ${i + 1}',
                                  date: '${i + 1} min ago',
                                  type: i % 2 == 0 ? 'Movie' : 'Episode',
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Quick Actions
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: SumadColors.cardDark,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Quick Actions', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12, runSpacing: 12,
                            children: [
                              _quickAction(Icons.upload_file, 'Upload Movie', () => Navigator.pushNamed(context, '/admin/upload_movie')),
                              _quickAction(Icons.upload_file, 'Upload Series', () => Navigator.pushNamed(context, '/admin/upload_series')),
                              _quickAction(Icons.live_tv, 'Add Channel', () => Navigator.pushNamed(context, '/admin/add_channel')),
                              _quickAction(Icons.campaign, 'Send Notification', () => Navigator.pushNamed(context, '/admin/notifications')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 240,
      color: SumadColors.surfaceDark,
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
            ),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SumadColors.primaryGradient,
                  ),
                  child: const Center(child: Text('S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
                ),
                const SizedBox(width: 12),
                const Text('SUMAD Admin', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Nav Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _navItems.length,
              itemBuilder: (_, i) {
                final item = _navItems[i];
                return ListTile(
                  leading: Icon(item['icon'] as IconData, color: i == 0 ? SumadColors.primary : Colors.white54, size: 22),
                  title: Text(item['label'] as String, style: TextStyle(color: i == 0 ? SumadColors.primary : Colors.white54, fontSize: 14, fontWeight: i == 0 ? FontWeight.w600 : FontWeight.w400)),
                  selected: i == 0,
                  selectedTileColor: SumadColors.primary.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onTap: () {
                    if (item['route'] != null) Navigator.pushNamed(context, item['route'] as String);
                  },
                );
              },
            ),
          ),
          // Logout
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                icon: const Icon(Icons.logout, size: 18),
                label: const Text('Logout'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white54,
                  side: BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: SumadColors.cardLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: SumadColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}