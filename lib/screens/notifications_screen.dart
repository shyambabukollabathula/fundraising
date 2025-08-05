import 'package:flutter/material.dart';
import '../models/user_data.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'title': 'New Achievement Unlocked! 🏆',
      'message': 'Congratulations! You\'ve unlocked the "Team Player" achievement for reaching 10 referrals.',
      'time': '2 hours ago',
      'isRead': false,
      'type': 'achievement',
    },
    {
      'id': 2,
      'title': 'Weekly Challenge Update 📈',
      'message': 'You\'re currently in 2nd place for this week\'s referral challenge. Keep it up!',
      'time': '5 hours ago',
      'isRead': false,
      'type': 'challenge',
    },
    {
      'id': 3,
      'title': 'New Announcement Posted 📢',
      'message': 'Check out the latest team announcement about Q1 goals.',
      'time': '1 day ago',
      'isRead': true,
      'type': 'announcement',
    },
    {
      'id': 4,
      'title': 'Donation Milestone Reached! 💰',
      'message': 'Amazing! You\'ve raised over ₹15,000. You\'re making a real difference!',
      'time': '2 days ago',
      'isRead': true,
      'type': 'milestone',
    },
    {
      'id': 5,
      'title': 'Welcome to the Team! 👋',
      'message': 'Welcome ${UserData.internName}! We\'re excited to have you on board.',
      'time': '1 week ago',
      'isRead': true,
      'type': 'welcome',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Notifications',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Mark all as read
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('All notifications marked as read'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('Mark all read'),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Notifications List
          Expanded(
            child: notifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No notifications yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Card(
                          elevation: notification['isRead'] ? 1 : 4,
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getNotificationColor(notification['type']).withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getNotificationIcon(notification['type']),
                                color: _getNotificationColor(notification['type']),
                                size: 20,
                              ),
                            ),
                            title: Text(
                              notification['title'],
                              style: TextStyle(
                                fontWeight: notification['isRead'] 
                                    ? FontWeight.normal 
                                    : FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  notification['message'],
                                  style: TextStyle(
                                    color: notification['isRead']
                                        ? Colors.grey.shade600
                                        : Colors.grey.shade800,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notification['time'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            trailing: !notification['isRead']
                                ? Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : null,
                            onTap: () {
                              _showNotificationDetails(context, notification);
                            },
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

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'achievement':
        return Colors.amber;
      case 'challenge':
        return Colors.orange;
      case 'announcement':
        return Colors.blue;
      case 'milestone':
        return Colors.green;
      case 'welcome':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'achievement':
        return Icons.emoji_events;
      case 'challenge':
        return Icons.trending_up;
      case 'announcement':
        return Icons.campaign;
      case 'milestone':
        return Icons.flag;
      case 'welcome':
        return Icons.waving_hand;
      default:
        return Icons.notifications;
    }
  }

  void _showNotificationDetails(BuildContext context, Map<String, dynamic> notification) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(notification['title']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                notification['time'],
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              Text(notification['message']),
            ],
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
}
