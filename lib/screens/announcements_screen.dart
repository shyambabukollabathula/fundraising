import 'package:flutter/material.dart';
import '../models/user_data.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

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
        title: const Text(
          'Announcements',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              child: Text(
                'Hi, ${UserData.internName}!',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.campaign,
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Stay Updated',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Latest news and updates from the team',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Announcements List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Card(
                    elevation: announcement['isImportant'] ? 8 : 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: announcement['isImportant']
                            ? Border.all(color: Colors.orange.shade400, width: 2)
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row
                            Row(
                              children: [
                                // Type Icon
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
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (announcement['isImportant'])
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.orange.shade400,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: const Text(
                                                'IMPORTANT',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatDate(announcement['date']),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            
                            // Content
                            Text(
                              announcement['content'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            
                            // Action Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    _showAnnouncementDetails(context, announcement);
                                  },
                                  icon: const Icon(Icons.visibility, size: 16),
                                  label: const Text('View Details'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.blue.shade600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextButton.icon(
                                  onPressed: () {
                                    _shareAnnouncement(context, announcement);
                                  },
                                  icon: const Icon(Icons.share, size: 16),
                                  label: const Text('Share'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
        return AlertDialog(
          title: const Text('Filter Announcements'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.all_inclusive),
                title: const Text('All Announcements'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.priority_high, color: Colors.orange.shade400),
                title: const Text('Important Only'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.today),
                title: const Text('This Week'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAnnouncementDetails(BuildContext context, Map<String, dynamic> announcement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(announcement['title']),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Posted on ${_formatDate(announcement['date'])}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Text(announcement['content']),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _shareAnnouncement(BuildContext context, Map<String, dynamic> announcement) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Shared: ${announcement['title']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
