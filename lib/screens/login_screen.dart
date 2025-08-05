import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../models/user_data.dart';
import '../utils/animations.dart';
import '../widgets/custom_widgets.dart';
import 'main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
      // Clear form fields when switching modes
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate authentication delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          
          // Show appropriate welcome message
          String message = _isLogin 
              ? 'Welcome back, ${UserData.internName}! 🎉'
              : 'Account created successfully! Welcome, ${_nameController.text.split(' ')[0]}! 🎉';
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          
          // Navigate to main app with page transition
          Navigator.of(context).pushReplacement(
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              duration: const Duration(milliseconds: 600),
              child: const MainNavigation(),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade600,
              Colors.purple.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 16.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 32.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                // Animated Logo/Header
                const SizedBox(height: 40),
                AppAnimations.bounceIn(
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.volunteer_activism,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  duration: const Duration(milliseconds: 800),
                ),
                const SizedBox(height: 24),
                
                // Animated Title
                AppAnimations.fadeInDown(
                  Text(
                    'Fundraising Portal',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(milliseconds: 600),
                ),
                const SizedBox(height: 8),
                AppAnimations.fadeInUp(
                  Text(
                    _isLogin ? 'Welcome back!' : 'Join our mission',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(milliseconds: 700),
                ),
                const SizedBox(height: 32),

                // Animated Form Card
                AppAnimations.scaleIn(
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Name Field (only for signup)
                          if (!_isLogin) ...[
                            AppAnimations.fadeInLeft(
                              _buildAnimatedTextField(
                                controller: _nameController,
                                labelText: 'Full Name',
                                prefixIcon: Icons.person,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (!_isLogin) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your full name';
                                    }
                                    if (value.trim().split(' ').length < 2) {
                                      return 'Please enter your first and last name';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              duration: const Duration(milliseconds: 500),
                            ),
                            const SizedBox(height: 12),
                          ],

                          // Email Field
                          AppAnimations.fadeInRight(
                            _buildAnimatedTextField(
                              controller: _emailController,
                              labelText: 'Email',
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            duration: const Duration(milliseconds: 600),
                          ),
                          const SizedBox(height: 12),

                          // Phone Field (only for signup)
                          if (!_isLogin) ...[
                            AppAnimations.fadeInLeft(
                              _buildAnimatedTextField(
                                controller: _phoneController,
                                labelText: 'Phone Number',
                                prefixIcon: Icons.phone,
                                keyboardType: TextInputType.phone,
                                hintText: '+91 9876543210',
                                validator: (value) {
                                  if (!_isLogin) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    String cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
                                    if (cleanPhone.length < 10) {
                                      return 'Please enter a valid phone number';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              duration: const Duration(milliseconds: 700),
                            ),
                            const SizedBox(height: 12),
                          ],

                          // Password Field
                          AppAnimations.fadeInRight(
                            _buildAnimatedTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              prefixIcon: Icons.lock,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                if (!_isLogin && value.length < 8) {
                                  return 'Password must be at least 8 characters for signup';
                                }
                                return null;
                              },
                            ),
                            duration: const Duration(milliseconds: 800),
                          ),
                          const SizedBox(height: 12),

                          // Confirm Password Field (only for signup)
                          if (!_isLogin) ...[
                            AppAnimations.fadeInLeft(
                              _buildAnimatedTextField(
                                controller: _confirmPasswordController,
                                labelText: 'Confirm Password',
                                prefixIcon: Icons.lock_outline,
                                obscureText: true,
                                validator: (value) {
                                  if (!_isLogin) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              duration: const Duration(milliseconds: 900),
                            ),
                            const SizedBox(height: 20),
                          ] else ...[
                            const SizedBox(height: 8),
                          ],

                          // Animated Submit Button
                          AppAnimations.scaleIn(
                            CustomWidgets.animatedButton(
                              text: _isLogin ? 'Login' : 'Sign Up',
                              onPressed: _submitForm,
                              backgroundColor: Colors.white,
                              textColor: Colors.blue.shade600,
                              isLoading: _isLoading,
                              icon: _isLogin ? Icons.login : Icons.person_add,
                            ),
                            duration: const Duration(milliseconds: 1000),
                          ),
                        ],
                      ),
                    ),
                  ),
                  duration: const Duration(milliseconds: 800),
                ),
                const SizedBox(height: 16),

                // Animated Toggle Auth Mode Button
                AppAnimations.fadeIn(
                  TextButton(
                    onPressed: _toggleAuthMode,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                    ),
                    child: Text(
                      _isLogin
                          ? "Don't have an account? Sign Up"
                          : "Already have an account? Login",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  duration: const Duration(milliseconds: 1200),
                ),
                const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    bool obscureText = false,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.blue.shade600,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          labelStyle: TextStyle(color: Colors.grey.shade700),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
