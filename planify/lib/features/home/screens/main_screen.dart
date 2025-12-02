import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:planify/core/constants/app_assets.dart';
import 'package:planify/core/constants/app_colors.dart';
import 'package:planify/features/calendar/screens/calendar_screen.dart';
import 'package:planify/features/home/screens/home_screen.dart';
import 'package:planify/features/notifications/screens/notifications_screen.dart';
import 'package:planify/features/settings/screens/settings_screen.dart';

// Simple model representing a bottom navigation item.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    CalendarScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCentralAction() {
    // Central CTA behaviour — open quick action or create screen
    showModalBottomSheet(
      context: context,
      builder: (_) =>
          SizedBox(height: 200, child: Center(child: Text('Central action'))),
    );
  }

  Widget _buildTabItem({
    IconData? icon,
    String? svgPath,
    required String label,
    required int index,
    bool showDot = false,
  }) {
    final selected = _selectedIndex == index;
    final color = selected ? Theme.of(context).primaryColor : Colors.grey[600];

    return Expanded(
      child: InkWell(
        onTap: () => _onTabSelected(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display SVG if path provided, otherwise use Icon
              if (svgPath != null)
                SvgPicture.asset(
                  svgPath,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
                )
              else if (icon != null)
                Icon(icon, color: color),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(color: color, fontSize: 12)),
              // Show dot only on the selected tab
              if (selected) ...[
                const SizedBox(height: 4),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Ionicons.menu_outline),
        ),
        title: const Text(
          'Planify',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight
                .w500, // correspond typiquement à Poppins-Medium/Bold selon votre pubspec
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Ionicons.stats_chart_outline),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          IndexedStack(index: _selectedIndex, children: _pages),

          // Floating bottom navigation bar with central FAB
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                // height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Navigation items
                    Row(
                      children: [
                        _buildTabItem(
                          svgPath: AppAssets.iconHome,
                          label: 'Accueil',
                          index: 0,
                        ),
                        _buildTabItem(
                          svgPath: AppAssets.iconCalendar,
                          label: 'Calendrier',
                          index: 1,
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ), // space for central button
                        _buildTabItem(
                          svgPath: AppAssets.iconNotifications,
                          label: 'Notifications',
                          index: 2,
                        ),
                        _buildTabItem(
                          svgPath: AppAssets.iconSettings,
                          label: 'Parametres',
                          index: 3,
                          showDot: true,
                        ),
                      ],
                    ),

                    // Central floating action button
                    Positioned(
                      top: -20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: FloatingActionButton(
                            onPressed: _onCentralAction,
                            backgroundColor: AppColors.primary,
                            elevation: 0,
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
