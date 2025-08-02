import 'package:flutter/material.dart';
import '../models/user_data.dart';

class AIChatbotScreen extends StatefulWidget {
  const AIChatbotScreen({super.key});

  @override
  State<AIChatbotScreen> createState() => _AIChatbotScreenState();
}

class _AIChatbotScreenState extends State<AIChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _messages.add(
      ChatMessage(
        text: 'Hello ${UserData.internName}! 👋\n\nI\'m your AI assistant. I can help you with:\n• Fundraising tips and strategies\n• Understanding your dashboard\n• Referral program questions\n• General support\n\nHow can I assist you today?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text.trim();
    setState(() {
      _messages.add(
        ChatMessage(
          text: userMessage,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _generateAIResponse(userMessage),
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      _scrollToBottom();
    });
  }

  String _generateAIResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    if (message.contains('referral') || message.contains('refer')) {
      return 'Great question about referrals! 🎯\n\nYour referral code is "${UserData.referralCode}". Here are some tips:\n\n• Share your code on social media\n• Explain the cause to friends and family\n• Use personal stories to connect\n• Follow up with potential donors\n\nYou currently have ${UserData.referralsCount} referrals. Keep it up!';
    } else if (message.contains('donation') || message.contains('fundrais')) {
      return 'Excellent! Let me help with fundraising strategies 💰\n\nYou\'ve raised ₹${UserData.totalDonations.toStringAsFixed(0)} so far - amazing work!\n\nTips to increase donations:\n• Set clear, achievable goals\n• Share regular updates\n• Thank donors personally\n• Use compelling storytelling\n• Leverage social proof\n\nWould you like specific advice on any of these areas?';
    } else if (message.contains('leaderboard') || message.contains('ranking')) {
      return 'You\'re doing fantastic on the leaderboard! 🏆\n\nCurrently, you\'re ranked #2 with:\n• ₹${UserData.totalDonations.toStringAsFixed(0)} raised\n• ${UserData.referralsCount} referrals\n\nTo climb higher:\n• Focus on consistent daily outreach\n• Engage with your network regularly\n• Share success stories\n• Collaborate with other interns\n\nYou\'re so close to #1!';
    } else if (message.contains('reward') || message.contains('achievement')) {
      return 'Rewards are a great motivator! 🎁\n\nYou\'ve unlocked:\n✅ Rising Star - First ₹1,000 raised\n✅ Team Player - 10 referrals made\n\nStill working on:\n🔒 Fundraiser Pro - Raise ₹25,000\n🔒 Community Hero - 50 referrals\n\nYou\'re 62% of the way to Fundraiser Pro! Keep pushing forward!';
    } else if (message.contains('help') || message.contains('support')) {
      return 'I\'m here to help! 🤝\n\nI can assist with:\n• Fundraising strategies and tips\n• Understanding your dashboard metrics\n• Referral program guidance\n• Leaderboard and competition info\n• Reward system explanations\n• General platform questions\n\nJust ask me anything specific, or say "tips" for general fundraising advice!';
    } else if (message.contains('tip') || message.contains('advice')) {
      return 'Here are my top fundraising tips for you! 💡\n\n1. **Personal Connection**: Share why this cause matters to you\n2. **Regular Updates**: Keep supporters engaged with progress\n3. **Thank Everyone**: Gratitude builds lasting relationships\n4. **Use Multiple Channels**: Social media, email, phone calls\n5. **Set Mini-Goals**: Celebrate small wins along the way\n6. **Follow Up**: Don\'t be afraid to follow up politely\n7. **Share Stories**: Impact stories are powerful motivators\n\nWhich tip would you like me to elaborate on?';
    } else if (message.contains('dashboard') || message.contains('stats')) {
      return 'Let me explain your dashboard! 📊\n\nYour current stats:\n• **Total Raised**: ₹${UserData.totalDonations.toStringAsFixed(0)}\n• **Referrals**: ${UserData.referralsCount} people\n• **Referral Code**: ${UserData.referralCode}\n• **Rank**: #2 on leaderboard\n\nYour dashboard updates in real-time and shows:\n- Progress toward goals\n- Unlocked achievements\n- Referral tracking\n- Performance metrics\n\nIs there a specific metric you\'d like to understand better?';
    } else {
      return 'Thanks for your message! 🤖\n\nI\'m here to help with your fundraising journey. You can ask me about:\n\n• Fundraising strategies\n• Your dashboard and stats\n• Referral program\n• Leaderboard rankings\n• Rewards and achievements\n• General support\n\nTry asking something like "How can I get more referrals?" or "What are some fundraising tips?"';
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.smart_toy,
                color: Colors.blue.shade600,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Assistant',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Online',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _messages.clear();
                _messages.add(
                  ChatMessage(
                    text: 'Hello ${UserData.internName}! 👋\n\nI\'m your AI assistant. How can I help you today?',
                    isUser: false,
                    timestamp: DateTime.now(),
                  ),
                );
              });
            },
            tooltip: 'Clear chat',
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          
          // Input Area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.smart_toy,
                color: Colors.blue.shade600,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser 
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16).copyWith(
                  bottomLeft: message.isUser 
                      ? const Radius.circular(16)
                      : const Radius.circular(4),
                  bottomRight: message.isUser 
                      ? const Radius.circular(4)
                      : const Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: message.isUser 
                          ? Colors.white70 
                          : Colors.grey.shade600,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              child: Text(
                UserData.internName.split(' ').map((name) => name[0]).join(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}