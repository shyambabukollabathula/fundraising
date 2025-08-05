import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../models/user_data.dart';
import 'login_screen.dart';
import 'ai_chatbot_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Profile Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      UserData.internName.split(' ').map((name) => name[0]).join(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    UserData.internName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    UserData.email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Joined ${UserData.joinDate}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Settings Sections
            _buildSettingsSection(
              context,
              'Preferences',
              [
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return _buildSettingsTile(
                      context,
                      'Dark Mode',
                      'Switch between light and dark theme',
                      Icons.dark_mode,
                      trailing: Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          themeProvider.toggleTheme();
                        },
                      ),
                    );
                  },
                ),
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return _buildSettingsTile(
                      context,
                      'Notifications',
                      'Enable or disable push notifications',
                      Icons.notifications,
                      trailing: Switch(
                        value: themeProvider.notificationsEnabled,
                        onChanged: (value) {
                          themeProvider.toggleNotifications();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                value 
                                    ? 'Notifications enabled' 
                                    : 'Notifications disabled',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return _buildSettingsTile(
                      context,
                      'Sound',
                      'Enable or disable app sounds',
                      Icons.volume_up,
                      trailing: Switch(
                        value: themeProvider.soundEnabled,
                        onChanged: (value) {
                          themeProvider.toggleSound();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                value 
                                    ? 'Sound enabled' 
                                    : 'Sound disabled',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            
            _buildSettingsSection(
              context,
              'Support & Help',
              [
                _buildSettingsTile(
                  context,
                  'AI Chatbot',
                  'Get instant help from our AI assistant',
                  Icons.smart_toy,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AIChatbotScreen(),
                      ),
                    );
                  },
                ),
                _buildSettingsTile(
                  context,
                  'Support Center',
                  'Contact our support team',
                  Icons.support_agent,
                  onTap: () {
                    _showSupportDialog(context);
                  },
                ),
                _buildSettingsTile(
                  context,
                  'FAQ',
                  'Frequently asked questions',
                  Icons.help_outline,
                  onTap: () {
                    _showFAQDialog(context);
                  },
                ),
                _buildSettingsTile(
                  context,
                  'About',
                  'App version and information',
                  Icons.info_outline,
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
              ],
            ),
            
            _buildSettingsSection(
              context,
              'Account',
              [
                _buildSettingsTile(
                  context,
                  'Edit Profile',
                  'Update your personal information',
                  Icons.edit,
                  onTap: () {
                    _showEditProfileDialog(context);
                  },
                ),
                _buildSettingsTile(
                  context,
                  'Privacy Policy',
                  'Read our privacy policy',
                  Icons.privacy_tip,
                  onTap: () {
                    _showPrivacyPolicyDialog(context);
                  },
                ),
                _buildSettingsTile(
                  context,
                  'Terms of Service',
                  'Read our terms of service',
                  Icons.description,
                  onTap: () {
                    _showTermsDialog(context);
                  },
                ),
              ],
            ),
            
            // Logout Section
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: children),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon, {
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Support Center'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Need help? Contact our support team:'),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.email, size: 16),
                  SizedBox(width: 8),
                  Text('support@fundraising.com'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, size: 16),
                  SizedBox(width: 8),
                  Text('+91 9876543210'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16),
                  SizedBox(width: 8),
                  Text('Mon-Fri, 9 AM - 6 PM'),
                ],
              ),
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

  void _showFAQDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Frequently Asked Questions'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Q: How do I track my referrals?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('A: Check your dashboard for real-time referral tracking.'),
                SizedBox(height: 12),
                Text(
                  'Q: When are rewards distributed?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('A: Rewards are distributed monthly based on performance.'),
                SizedBox(height: 12),
                Text(
                  'Q: How can I improve my ranking?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('A: Focus on increasing donations and referrals consistently.'),
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

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Fundraising Portal',
      applicationVersion: '1.0.0',
      applicationIcon: Icon(
        Icons.volunteer_activism,
        size: 48,
        color: Theme.of(context).primaryColor,
      ),
      children: const [
        Text('A comprehensive platform for fundraising interns to track their progress, compete with peers, and stay updated with the latest announcements.'),
      ],
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: const Text('Profile editing feature will be available in the next update.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const SingleChildScrollView(
            child: Text(
              'We respect your privacy and are committed to protecting your personal data. This privacy policy explains how we collect, use, and protect your information when you use our fundraising portal.\n\n'
              '1. Information Collection: We collect information you provide directly to us.\n'
              '2. Information Use: We use your information to provide and improve our services.\n'
              '3. Information Sharing: We do not sell or share your personal information with third parties.\n'
              '4. Data Security: We implement appropriate security measures to protect your data.\n\n'
              'For the complete privacy policy, please visit our website.',
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

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms of Service'),
          content: const SingleChildScrollView(
            child: Text(
              'By using our fundraising portal, you agree to these terms:\n\n'
              '1. Acceptable Use: Use the platform only for legitimate fundraising activities.\n'
              '2. Account Responsibility: You are responsible for maintaining account security.\n'
              '3. Content Guidelines: All content must be appropriate and truthful.\n'
              '4. Termination: We reserve the right to terminate accounts for violations.\n\n'
              'For complete terms of service, please visit our website.',
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
}
