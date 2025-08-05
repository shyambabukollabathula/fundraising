import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import '../models/user_data.dart';
import '../services/sound_service.dart';
import '../utils/animations.dart';
import '../utils/responsive.dart';
import '../utils/layout_utils.dart';
import '../widgets/custom_widgets.dart';
import 'notifications_screen.dart';
import 'ai_chatbot_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _copyReferralCode(BuildContext context) {
    SoundService.playSuccessSound();
    Clipboard.setData(const ClipboardData(text: UserData.referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Referral code copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    SoundService.playNotificationSound();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const NotificationsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: AppAnimations.fadeInLeft(
          const Text(
            'Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: const Duration(milliseconds: 600),
        ),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade600, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          AppAnimations.bounceIn(
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () => _showNotifications(context),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: AppAnimations.pulse(
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: const Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 800),
          ),
        ],
      ),
      body: AnimationLimiter(
        child: SingleChildScrollView(
          padding: Responsive.safeAreaPadding(context),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 200,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                // Welcome Card
                CustomWidgets.hoverCard(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade600,
                          Colors.blue.shade400,
                          Colors.purple.shade400,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppAnimations.fadeInUp(
                          const Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          duration: const Duration(milliseconds: 400),
                        ),
                        AppAnimations.fadeInUp(
                          Text(
                            UserData.internName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          duration: const Duration(milliseconds: 600),
                        ),
                        const SizedBox(height: 8),
                        AppAnimations.fadeInUp(
                          const Text(
                            'Keep up the great work! 🎉',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          duration: const Duration(milliseconds: 800),
                        ),
                      ],
                    ),
                  ),
                  elevation: 8,
                  borderRadius: BorderRadius.circular(16),
                ),
                const SizedBox(height: 20),

                // Stats Cards
                Row(
                  children: [
                    Expanded(
                      child: CustomWidgets.statCard(
                        title: 'Total Raised',
                        value: '₹${UserData.totalDonations.toStringAsFixed(0)}',
                        icon: Icons.currency_rupee,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomWidgets.statCard(
                        title: 'Referrals',
                        value: '${UserData.referralsCount}',
                        icon: Icons.people,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Referral Code Card
                CustomWidgets.glassCard(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      AppAnimations.fadeInLeft(
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.share,
                                color: Colors.blue.shade600,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Your Referral Code',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 500),
                      ),
                      const SizedBox(height: 16),
                      AppAnimations.scaleIn(
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue.shade50, Colors.purple.shade50],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  UserData.referralCode,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                    color: Colors.blue.shade700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade600,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  onPressed: () => _copyReferralCode(context),
                                  icon: const Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                  ),
                                  tooltip: 'Copy code',
                                ),
                              ),
                            ],
                          ),
                        ),
                        duration: const Duration(milliseconds: 700),
                      ),
                      const SizedBox(height: 12),
                      AppAnimations.fadeInUp(
                        Text(
                          'Share this code with friends to earn rewards!',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        duration: const Duration(milliseconds: 900),
                      ),
                    ],
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                ),
                const SizedBox(height: 24),

                // Rewards Section
                AppAnimations.fadeInLeft(
                  Text(
                    'Rewards & Achievements',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  duration: const Duration(milliseconds: 600),
                ),
                const SizedBox(height: 16),
                
                // Rewards Grid
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  child: LayoutUtils.safeGridView(
                    context: context,
                    crossAxisCount: Responsive.gridCount(context, mobile: 2, tablet: 3, desktop: 4),
                    childAspectRatio: Responsive.isMobile(context) ? 0.8 : 0.9,
                    padding: EdgeInsets.zero,
                    children: [
                    _buildAnimatedRewardCard(
                      'Rising Star',
                      'First ₹1,000 raised',
                      Icons.star,
                      Colors.amber,
                      isUnlocked: true,
                      index: 0,
                    ),
                    _buildAnimatedRewardCard(
                      'Team Player',
                      '10 referrals made',
                      Icons.group,
                      Colors.blue,
                      isUnlocked: true,
                      index: 1,
                    ),
                    _buildAnimatedRewardCard(
                      'Fundraiser Pro',
                      'Raise ₹25,000',
                      Icons.trending_up,
                      Colors.green,
                      isUnlocked: false,
                      index: 2,
                    ),
                    _buildAnimatedRewardCard(
                      'Community Hero',
                      '50 referrals made',
                      Icons.emoji_events,
                      Colors.purple,
                      isUnlocked: false,
                      index: 3,
                    ),
                  ],
                  ),
                ),
              ],
            ),
            ),
          ),
        ),
      ),
      floatingActionButton: CustomWidgets.animatedFAB(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: const Duration(milliseconds: 400),
              child: const AIChatbotScreen(),
            ),
          );
        },
        icon: Icons.smart_toy,
        backgroundColor: Colors.blue.shade600,
        tooltip: 'AI Help',
      ),
    );
  }

  Widget _buildAnimatedRewardCard(
    String title,
    String description,
    IconData icon,
    Color color,
    {required bool isUnlocked, required int index}
  ) {
    return AppAnimations.scaleIn(
      CustomWidgets.hoverCard(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: isUnlocked 
                ? LinearGradient(
                    colors: [Colors.white, color.withValues(alpha: 0.05)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [Colors.grey.shade100, Colors.grey.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            border: Border.all(
              color: isUnlocked ? color.withValues(alpha: 0.3) : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isUnlocked ? color.withValues(alpha: 0.1) : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: isUnlocked ? color : Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isUnlocked ? Colors.black87 : Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: isUnlocked ? Colors.grey.shade600 : Colors.grey.shade400,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              if (isUnlocked)
                CustomWidgets.animatedBadge(
                  text: 'UNLOCKED',
                  backgroundColor: Colors.green,
                  icon: Icons.check_circle,
                )
              else
                CustomWidgets.animatedBadge(
                  text: 'LOCKED',
                  backgroundColor: Colors.grey,
                  icon: Icons.lock,
                ),
            ],
          ),
        ),
        elevation: isUnlocked ? 6 : 2,
        borderRadius: BorderRadius.circular(16),
      ),
      duration: Duration(milliseconds: 600 + (index * 100)),
    );
  }
}
