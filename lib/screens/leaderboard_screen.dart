import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/user_data.dart';
import '../utils/animations.dart';
import '../utils/responsive.dart';
import '../widgets/custom_widgets.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  // Mock leaderboard data
  static const List<Map<String, dynamic>> leaderboardData = [
    {
      'name': 'Sarah Chen',
      'amount': 28500.0,
      'referrals': 45,
      'rank': 1,
    },
    {
      'name': UserData.internName,
      'amount': UserData.totalDonations,
      'referrals': UserData.referralsCount,
      'rank': 2,
    },
    {
      'name': 'Michael Rodriguez',
      'amount': 12300.0,
      'referrals': 18,
      'rank': 3,
    },
    {
      'name': 'Emily Davis',
      'amount': 9800.0,
      'referrals': 15,
      'rank': 4,
    },
    {
      'name': 'David Kim',
      'amount': 7200.0,
      'referrals': 12,
      'rank': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: AppAnimations.fadeInLeft(
          const Text(
            'Leaderboard',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: const Duration(milliseconds: 600),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade600, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          AppAnimations.fadeInRight(
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: CustomWidgets.animatedBadge(
                  text: 'Hi, ${UserData.internName.split(' ')[0]}!',
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  textColor: Colors.white,
                ),
              ),
            ),
            duration: const Duration(milliseconds: 800),
          ),
        ],
      ),
      body: Column(
        children: [
          // Animated Header with trophy
          AppAnimations.slideInDown(
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade600, Colors.purple.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  AppAnimations.bounceIn(
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.emoji_events,
                        size: 48,
                        color: Colors.amber.shade300,
                      ),
                    ),
                    duration: const Duration(milliseconds: 800),
                  ),
                  const SizedBox(height: 16),
                  AppAnimations.fadeInUp(
                    const Text(
                      'Top Fundraisers',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    duration: const Duration(milliseconds: 600),
                  ),
                  const SizedBox(height: 8),
                  AppAnimations.fadeInUp(
                    const Text(
                      'See how you rank against other interns',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    duration: const Duration(milliseconds: 700),
                  ),
                ],
              ),
            ),
            duration: const Duration(milliseconds: 500),
          ),
          
          // Animated Leaderboard List
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                padding: Responsive.safeAreaPadding(context),
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  final user = leaderboardData[index];
                  final isCurrentUser = user['name'] == UserData.internName;
                  
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _buildAnimatedLeaderboardCard(
                          user, 
                          isCurrentUser, 
                          index,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Animated Bottom info
          AppAnimations.slideInUp(
            Container(
              padding: const EdgeInsets.all(16.0),
              child: CustomWidgets.glassCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.blue.shade600,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Rankings update every hour. Keep fundraising to climb higher!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
              ),
            ),
            duration: const Duration(milliseconds: 800),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedLeaderboardCard(
    Map<String, dynamic> user, 
    bool isCurrentUser, 
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: CustomWidgets.hoverCard(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isCurrentUser
                ? Border.all(
                    color: Colors.blue.shade600, 
                    width: 2,
                  )
                : null,
            gradient: isCurrentUser
                ? LinearGradient(
                    colors: [
                      Colors.blue.shade50,
                      Colors.blue.shade100,
                      Colors.purple.shade50,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [Colors.white, Colors.grey.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Animated Rank Badge
                AppAnimations.bounceIn(
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getRankColor(user['rank']),
                          _getRankColor(user['rank']).withValues(alpha: 0.8),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _getRankColor(user['rank']).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: user['rank'] <= 3
                          ? Icon(
                              _getRankIcon(user['rank']),
                              color: Colors.white,
                              size: 24,
                            )
                          : Text(
                              '${user['rank']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),
                  duration: Duration(milliseconds: 600 + (index * 100)),
                ),
                const SizedBox(width: 16),
                
                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isCurrentUser
                                    ? Colors.blue.shade800
                                    : Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          if (isCurrentUser)
                            AppAnimations.pulse(
                              CustomWidgets.animatedBadge(
                                text: 'YOU',
                                backgroundColor: Colors.blue.shade600,
                                icon: Icons.person,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8, 
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 16,
                                  color: Colors.green.shade700,
                                ),
                                const SizedBox(width: 2),
                                CustomWidgets.animatedCounter(
                                  value: user['amount'].toInt(),
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade700,
                                  ),
                                  duration: Duration(
                                    milliseconds: 1000 + (index * 200),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8, 
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 16,
                                  color: Colors.orange.shade700,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${user['referrals']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Animated Progress indicator for top 3
                if (user['rank'] <= 3)
                  AppAnimations.slideInRight(
                    Container(
                      width: 6,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _getRankColor(user['rank']),
                            _getRankColor(user['rank']).withValues(alpha: 0.6),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    duration: Duration(milliseconds: 800 + (index * 100)),
                  ),
              ],
            ),
          ),
        ),
        elevation: isCurrentUser ? 12 : 6,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber.shade600; // Gold
      case 2:
        return Colors.grey.shade500; // Silver
      case 3:
        return Colors.brown.shade400; // Bronze
      default:
        return Colors.blue.shade600;
    }
  }

  IconData _getRankIcon(int rank) {
    switch (rank) {
      case 1:
        return Icons.emoji_events; // Trophy
      case 2:
        return Icons.military_tech; // Medal
      case 3:
        return Icons.workspace_premium; // Award
      default:
        return Icons.star;
    }
  }
}
