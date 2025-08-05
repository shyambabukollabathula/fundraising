import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/user_data.dart';
import '../utils/animations.dart';
import '../widgets/custom_widgets.dart';
import 'dashboard_screen.dart';
import 'leaderboard_screen.dart';
import 'enhanced_announcements_screen.dart';
import 'enhanced_settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> 
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _hasShownWelcome = false;
  late PageController _pageController;
  late AnimationController _fabAnimationController;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const LeaderboardScreen(),
    const EnhancedAnnouncementsScreen(),
    const EnhancedSettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Show welcome dialog after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasShownWelcome) {
        _showWelcomeDialog();
        _hasShownWelcome = true;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppAnimations.scaleIn(
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 16,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.purple.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppAnimations.bounceIn(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.waving_hand,
                          color: Colors.amber,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    duration: const Duration(milliseconds: 800),
                  ),
                  const SizedBox(height: 20),
                  
                  AppAnimations.scaleIn(
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade400, Colors.purple.shade400],
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: Text(
                          UserData.internName.split(' ').map((name) => name[0]).join(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    duration: const Duration(milliseconds: 600),
                  ),
                  const SizedBox(height: 20),
                  
                  AppAnimations.fadeInUp(
                    Text(
                      'Hello ${UserData.internName}!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    duration: const Duration(milliseconds: 700),
                  ),
                  const SizedBox(height: 12),
                  
                  AppAnimations.fadeInUp(
                    Text(
                      'Welcome to your Fundraising Portal! You\'re all set to track your progress, compete with peers, and make a difference.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    duration: const Duration(milliseconds: 800),
                  ),
                  const SizedBox(height: 20),
                  
                  AppAnimations.scaleIn(
                    CustomWidgets.glassCard(
                      child: Column(
                        children: [
                          Text(
                            'Your Current Stats:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatColumn(
                                '₹${UserData.totalDonations.toStringAsFixed(0)}',
                                'Raised',
                                Icons.currency_rupee,
                                Colors.green,
                              ),
                              _buildStatColumn(
                                '${UserData.referralsCount}',
                                'Referrals',
                                Icons.people,
                                Colors.orange,
                              ),
                              _buildStatColumn(
                                '#2',
                                'Rank',
                                Icons.emoji_events,
                                Colors.amber,
                              ),
                            ],
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                    ),
                    duration: const Duration(milliseconds: 900),
                  ),
                  const SizedBox(height: 24),
                  
                  AppAnimations.scaleIn(
                    CustomWidgets.animatedButton(
                      text: 'Let\'s Go!',
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: Colors.blue.shade600,
                      textColor: Colors.white,
                      icon: Icons.rocket_launch,
                      width: double.infinity,
                    ),
                    duration: const Duration(milliseconds: 1000),
                  ),
                ],
              ),
            ),
          ),
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }

  Widget _buildStatColumn(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _screens.map((screen) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 80,
            ),
            child: screen,
          );
        }).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.blue.shade600,
          unselectedItemColor: Colors.grey.shade500,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
          items: [
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(Icons.dashboard_outlined, Icons.dashboard, 0),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(Icons.leaderboard_outlined, Icons.leaderboard, 1),
              label: 'Leaderboard',
            ),
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(Icons.announcement_outlined, Icons.announcement, 2),
              label: 'Announcements',
            ),
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(Icons.settings_outlined, Icons.settings, 3),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon(IconData outlinedIcon, IconData filledIcon, int index) {
    bool isSelected = _currentIndex == index;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade600.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        isSelected ? filledIcon : outlinedIcon,
        size: isSelected ? 26 : 24,
      ),
    ).animate().scale(
      duration: const Duration(milliseconds: 200),
      begin: const Offset(0.9, 0.9),
      end: const Offset(1.0, 1.0),
    );
  }
}
