import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import '../providers/theme_provider.dart';
import '../models/user_data.dart';
import '../utils/animations.dart';
import '../utils/responsive.dart';
import '../widgets/custom_widgets.dart';
import 'login_screen.dart';
import 'ai_chatbot_screen.dart';

class EnhancedSettingsScreen extends StatefulWidget {
  const EnhancedSettingsScreen({super.key});

  @override
  State<EnhancedSettingsScreen> createState() => _EnhancedSettingsScreenState();
}

class _EnhancedSettingsScreenState extends State<EnhancedSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: AppAnimations.fadeInLeft(
          const Text(
            'Settings',
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
              colors: [Colors.purple.shade600, Colors.indigo.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          AppAnimations.bounceIn(
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {
                _showHelpDialog(context);
              },
            ),
            duration: const Duration(milliseconds: 800),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            // Animated User Profile Section
            AppAnimations.slideInDown(
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade600, Colors.indigo.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AppAnimations.scaleIn(
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.grey.shade100],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: Text(
                            UserData.internName.split(' ').map((name) => name[0]).join(),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple.shade600,
                            ),
                          ),
                        ),
                      ),
                      duration: const Duration(milliseconds: 800),
                    ),
                    const SizedBox(height: 16),
                    AppAnimations.fadeInUp(
                      Text(
                        UserData.internName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                      duration: const Duration(milliseconds: 600),
                    ),
                    const SizedBox(height: 8),
                    AppAnimations.fadeInUp(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Fundraising Intern',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      duration: const Duration(milliseconds: 700),
                    ),
                    const SizedBox(height: 16),
                    AppAnimations.fadeInUp(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatChip(
                            '₹${UserData.totalDonations.toStringAsFixed(0)}',
                            'Raised',
                            Icons.currency_rupee,
                          ),
                          _buildStatChip(
                            '${UserData.referralsCount}',
                            'Referrals',
                            Icons.people,
                          ),
                          _buildStatChip(
                            '#2',
                            'Rank',
                            Icons.emoji_events,
                          ),
                        ],
                      ),
                      duration: const Duration(milliseconds: 800),
                    ),
                  ],
                ),
              ),
              duration: const Duration(milliseconds: 500),
            ),
            
            const SizedBox(height: 24),
            
            // Animated Settings Sections
            AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    // Account Settings
                    _buildSettingsSection(
                      'Account Settings',
                      Icons.person,
                      Colors.blue,
                      [
                        _buildSettingsTile(
                          'Edit Profile',
                          'Update your personal information',
                          Icons.edit,
                          () => _showEditProfileDialog(context),
                        ),
                        _buildSettingsTile(
                          'Change Password',
                          'Update your account password',
                          Icons.lock,
                          () => _showChangePasswordDialog(context),
                        ),
                        _buildSettingsTile(
                          'Privacy Settings',
                          'Manage your privacy preferences',
                          Icons.privacy_tip,
                          () => _showPrivacyDialog(context),
                        ),
                      ],
                    ),
                    
                    // App Preferences
                    _buildSettingsSection(
                      'App Preferences',
                      Icons.settings,
                      Colors.green,
                      [
                        _buildSwitchTile(
                          'Push Notifications',
                          'Receive updates and alerts',
                          Icons.notifications,
                          _notificationsEnabled,
                          (value) => setState(() => _notificationsEnabled = value),
                        ),
                        _buildSwitchTile(
                          'Sound Effects',
                          'Play sounds for interactions',
                          Icons.volume_up,
                          _soundEnabled,
                          (value) => setState(() => _soundEnabled = value),
                        ),
                        _buildSwitchTile(
                          'Dark Mode',
                          'Use dark theme',
                          Icons.dark_mode,
                          _darkModeEnabled,
                          (value) {
                            setState(() => _darkModeEnabled = value);
                            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                          },
                        ),
                        _buildSwitchTile(
                          'Biometric Login',
                          'Use fingerprint or face ID',
                          Icons.fingerprint,
                          _biometricEnabled,
                          (value) => setState(() => _biometricEnabled = value),
                        ),
                      ],
                    ),
                    
                    // Support & Help
                    _buildSettingsSection(
                      'Support & Help',
                      Icons.help,
                      Colors.orange,
                      [
                        _buildSettingsTile(
                          'AI Assistant',
                          'Get help from our AI chatbot',
                          Icons.smart_toy,
                          () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                duration: const Duration(milliseconds: 400),
                                child: const AIChatbotScreen(),
                              ),
                            );
                          },
                        ),
                        _buildSettingsTile(
                          'FAQ',
                          'Frequently asked questions',
                          Icons.quiz,
                          () => _showFAQDialog(context),
                        ),
                        _buildSettingsTile(
                          'Contact Support',
                          'Get in touch with our team',
                          Icons.support_agent,
                          () => _showContactDialog(context),
                        ),
                        _buildSettingsTile(
                          'Rate App',
                          'Share your feedback',
                          Icons.star_rate,
                          () => _showRatingDialog(context),
                        ),
                      ],
                    ),
                    
                    // About
                    _buildSettingsSection(
                      'About',
                      Icons.info,
                      Colors.purple,
                      [
                        _buildSettingsTile(
                          'App Version',
                          'Version 1.0.0',
                          Icons.info_outline,
                          null,
                        ),
                        _buildSettingsTile(
                          'Terms of Service',
                          'Read our terms and conditions',
                          Icons.description,
                          () => _showTermsDialog(context),
                        ),
                        _buildSettingsTile(
                          'Privacy Policy',
                          'How we handle your data',
                          Icons.policy,
                          () => _showPrivacyPolicyDialog(context),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Logout Button
                    AppAnimations.scaleIn(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomWidgets.animatedButton(
                          text: 'Logout',
                          onPressed: () => _showLogoutDialog(context),
                          backgroundColor: Colors.red.shade600,
                          textColor: Colors.white,
                          icon: Icons.logout,
                          width: double.infinity,
                        ),
                      ),
                      duration: const Duration(milliseconds: 1000),
                    ),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.spacing(context),
        vertical: Responsive.spacing(context, mobile: 8, tablet: 12, desktop: 16),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: CustomWidgets.glassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
        padding: const EdgeInsets.all(20),
      ),
    );
  }

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback? onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      constraints: const BoxConstraints(
        maxHeight: 80,
        minHeight: 60,
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          subtitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      constraints: const BoxConstraints(
        maxHeight: 80,
        minHeight: 60,
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          subtitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.purple.shade600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAnimations.scaleIn(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
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
                  Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 600),
                      child: const LoginScreen(),
                    ),
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
          ),
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppAnimations.scaleIn(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Help & Support'),
          content: const Text('Need help? Contact our support team or check out the FAQ section.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppAnimations.scaleIn(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Edit Profile'),
          content: const Text('Profile editing feature coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppAnimations.scaleIn(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Change Password'),
          content: const Text('Password change feature coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppAnimations.scaleIn(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Privacy Settings'),
          content: const Text('Privacy settings will be available in the next update.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showFAQDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppAnimations.scaleIn(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('FAQ'),
          content: const Text('Frequently Asked Questions section coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppAnimations.scaleIn(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Contact Support'),
          content: const Text('Email: support@fundraising.com\nPhone: +91 9876543210'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppAnimations.scaleIn(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Rate Our App'),
          content: const Text('Thank you for using our app! Please rate us on the app store.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Later'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Rate Now'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppAnimations.scaleIn(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Terms of Service'),
          content: const Text('Terms of Service document will be displayed here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppAnimations.scaleIn(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Privacy Policy'),
          content: const Text('Privacy Policy document will be displayed here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
