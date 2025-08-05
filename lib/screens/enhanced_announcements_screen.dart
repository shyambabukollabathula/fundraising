import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/user_data.dart';
import '../utils/animations.dart';
import '../widgets/custom_widgets.dart';

class EnhancedAnnouncementsScreen extends StatelessWidget {
  const EnhancedAnnouncementsScreen({super.key});

  // Mock announcements data
  static const List<Map<String, dynamic>> announcements = [
    {
      'id': 1,
      'title': '🎉 New Milestone Reached!',
      'content': 'Amazing news! Our fundraising team has collectively raised over ₹1,00,000 this month. Thank you to all our dedicated interns for making this possible!',
      'date': '2024-01-15',
      'type': 'celebration',
      'isImportant': true,
    },
    {
      'id': 2,
      'title': '📈 Weekly Challenge: Double Referrals',
      'content': 'This week\'s challenge is to double your referral count! The top 3 performers will receive special recognition and bonus rewards. Challenge ends this Friday.',
      'date': '2024-01-12',
      'type': 'challenge',
      'isImportant': false,
    },
    {
      'id': 3,
      'title': '🏆 Leaderboard Update',
      'content': 'Congratulations to Sarah Chen for maintaining the #1 position for the third consecutive week! Keep up the excellent work everyone.',
      'date': '2024-01-10',
      'type': 'update',
      'isImportant': false,
    },
    {
      'id': 4,
      'title': '💡 New Feature: Referral Tracking',
      'content': 'We\'ve added a new feature to help you track your referrals more effectively. Check out the updated dashboard to see detailed analytics of your referral performance.',
      'date': '2024-01-08',
      'type': 'feature',
      'isImportant': false,
    },
    {
      'id': 5,
      'title': '📅 Monthly Team Meeting',
      'content': 'Don\'t forget about our monthly team meeting this Thursday at 3 PM. We\'ll be discussing new strategies and recognizing top performers. Meeting link will be shared via email.',
      'date': '2024-01-05',
      'type': 'meeting',
      'isImportant': true,
    },
    {
      'id': 6,
      'title': '🎯 Q1 Goals Announced',
      'content': 'Our Q1 fundraising goal is ₹5,00,000! With everyone\'s continued effort, we\'re confident we can achieve this target. Let\'s make it happen together!',
      'date': '2024-01-01',
      'type': 'goal',
      'isImportant': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: AppAnimations.fadeInLeft(
          const Text(
            'Announcements',
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
              colors: [Colors.orange.shade600, Colors.red.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          AppAnimations.fadeInRight(
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
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
          AppAnimations.bounceIn(
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                _showFilterDialog(context);
              },
            ),
            duration: const Duration(milliseconds: 1000),
          ),
        ],
      ),
      body: Column(
        children: [
          // Animated Header
          AppAnimations.slideInDown(
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade600, Colors.red.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.3),
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
                        Icons.campaign,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    duration: const Duration(milliseconds: 800),
                  ),
                  const SizedBox(height: 16),
                  AppAnimations.fadeInUp(
                    const Text(
                      'Stay Updated',
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
                      'Latest news and updates from the team',
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
          
          // Animated Announcements List
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  final announcement = announcements[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _buildAnimatedAnnouncementCard(
                          announcement, 
                          index, 
                          context,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedAnnouncementCard(
    Map<String, dynamic> announcement, 
    int index, 
    BuildContext context,
  ) {
    final isImportant = announcement['isImportant'] as bool;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: CustomWidgets.hoverCard(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isImportant
                ? Border.all(color: Colors.orange.shade400, width: 2)
                : null,
            gradient: isImportant
                ? LinearGradient(
                    colors: [
                      Colors.orange.shade50,
                      Colors.red.shade50,
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    // Animated Type Icon
                    AppAnimations.bounceIn(
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getTypeColor(announcement['type']),
                              _getTypeColor(announcement['type']).withValues(alpha: 0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: _getTypeColor(announcement['type']).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          _getTypeIcon(announcement['type']),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      duration: Duration(milliseconds: 600 + (index * 100)),
                    ),
                    const SizedBox(width: 16),
                    
                    // Title and Important Badge
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  announcement['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              if (isImportant)
                                AppAnimations.pulse(
                                  CustomWidgets.animatedBadge(
                                    text: 'IMPORTANT',
                                    backgroundColor: Colors.orange.shade600,
                                    icon: Icons.priority_high,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8, 
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _formatDate(announcement['date']),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Content
                Text(
                  announcement['content'],
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: CustomWidgets.animatedButton(
                        text: 'Share',
                        onPressed: () {
                          _shareAnnouncement(context, announcement);
                        },
                        backgroundColor: Colors.grey.shade600,
                        textColor: Colors.white,
                        icon: Icons.share,
                        height: 36,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomWidgets.animatedButton(
                        text: 'View Details',
                        onPressed: () {
                          _showAnnouncementDetails(context, announcement);
                        },
                        backgroundColor: _getTypeColor(announcement['type']),
                        textColor: Colors.white,
                        icon: Icons.visibility,
                        height: 36,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        elevation: isImportant ? 12 : 6,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'celebration':
        return Colors.green;
      case 'challenge':
        return Colors.orange;
      case 'update':
        return Colors.blue;
      case 'feature':
        return Colors.purple;
      case 'meeting':
        return Colors.red;
      case 'goal':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'celebration':
        return Icons.celebration;
      case 'challenge':
        return Icons.emoji_events;
      case 'update':
        return Icons.update;
      case 'feature':
        return Icons.new_releases;
      case 'meeting':
        return Icons.meeting_room;
      case 'goal':
        return Icons.flag;
      default:
        return Icons.announcement;
    }
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAnimations.scaleIn(
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.orange.shade50, Colors.red.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter Announcements',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomWidgets.animatedListTile(
                    title: 'All Announcements',
                    leadingIcon: Icons.all_inclusive,
                    onTap: () => Navigator.pop(context),
                    index: 0,
                  ),
                  CustomWidgets.animatedListTile(
                    title: 'Important Only',
                    leadingIcon: Icons.priority_high,
                    onTap: () => Navigator.pop(context),
                    index: 1,
                  ),
                  CustomWidgets.animatedListTile(
                    title: 'This Week',
                    leadingIcon: Icons.today,
                    onTap: () => Navigator.pop(context),
                    index: 2,
                  ),
                ],
              ),
            ),
          ),
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }

  void _showAnnouncementDetails(BuildContext context, Map<String, dynamic> announcement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAnimations.scaleIn(
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _getTypeColor(announcement['type']).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getTypeIcon(announcement['type']),
                          color: _getTypeColor(announcement['type']),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          announcement['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Posted on ${_formatDate(announcement['date'])}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    announcement['content'],
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomWidgets.animatedButton(
                        text: 'Close',
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: Colors.grey.shade600,
                        textColor: Colors.white,
                        width: 100,
                        height: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }

  void _shareAnnouncement(BuildContext context, Map<String, dynamic> announcement) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.share, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Shared: ${announcement['title']}'),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
