import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppAnimations {
  // Duration constants
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration verySlow = Duration(milliseconds: 800);

  // Curve constants
  static const Curve bounceInCurve = Curves.bounceIn;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve elasticIn = Curves.elasticIn;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;

  // Fade animations
  static Widget fadeIn(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .fadeIn(duration: duration ?? medium, curve: curve ?? easeInOut);
  }

  static Widget fadeInUp(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .fadeIn(duration: duration ?? medium, curve: curve ?? easeInOut)
        .slideY(begin: 0.3, end: 0, duration: duration ?? medium, curve: curve ?? easeInOut);
  }

  static Widget fadeInDown(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .fadeIn(duration: duration ?? medium, curve: curve ?? easeInOut)
        .slideY(begin: -0.3, end: 0, duration: duration ?? medium, curve: curve ?? easeInOut);
  }

  static Widget fadeInLeft(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .fadeIn(duration: duration ?? medium, curve: curve ?? easeInOut)
        .slideX(begin: -0.3, end: 0, duration: duration ?? medium, curve: curve ?? easeInOut);
  }

  static Widget fadeInRight(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .fadeIn(duration: duration ?? medium, curve: curve ?? easeInOut)
        .slideX(begin: 0.3, end: 0, duration: duration ?? medium, curve: curve ?? easeInOut);
  }

  // Scale animations
  static Widget scaleIn(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0), 
               duration: duration ?? medium, curve: curve ?? elasticOut);
  }

  static Widget bounceIn(Widget child, {Duration? duration}) {
    return child
        .animate()
        .scale(begin: const Offset(0.3, 0.3), end: const Offset(1.0, 1.0), 
               duration: duration ?? slow, curve: Curves.bounceOut);
  }

  // Slide animations
  static Widget slideInUp(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .slideY(begin: 1.0, end: 0, duration: duration ?? medium, curve: curve ?? fastOutSlowIn);
  }

  static Widget slideInDown(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .slideY(begin: -1.0, end: 0, duration: duration ?? medium, curve: curve ?? fastOutSlowIn);
  }

  static Widget slideInLeft(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .slideX(begin: -1.0, end: 0, duration: duration ?? medium, curve: curve ?? fastOutSlowIn);
  }

  static Widget slideInRight(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .slideX(begin: 1.0, end: 0, duration: duration ?? medium, curve: curve ?? fastOutSlowIn);
  }

  // Rotation animations
  static Widget rotateIn(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .rotate(begin: -0.5, end: 0, duration: duration ?? medium, curve: curve ?? easeInOut);
  }

  // Shimmer effect
  static Widget shimmer(Widget child, {Duration? duration}) {
    return child
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: duration ?? const Duration(milliseconds: 1500));
  }

  // Pulse effect
  static Widget pulse(Widget child, {Duration? duration}) {
    return child
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.05, 1.05), 
               duration: duration ?? const Duration(milliseconds: 1000));
  }

  // Shake effect
  static Widget shake(Widget child, {Duration? duration}) {
    return child
        .animate()
        .shake(duration: duration ?? const Duration(milliseconds: 500));
  }

  // Flip effect
  static Widget flipIn(Widget child, {Duration? duration, Curve? curve}) {
    return child
        .animate()
        .flipH(begin: -0.5, end: 0, duration: duration ?? medium, curve: curve ?? easeInOut);
  }

  // Staggered list animation
  static Widget staggeredList(List<Widget> children, {Duration? duration, Duration? delay}) {
    return Column(
      children: children.asMap().entries.map((entry) {
        int index = entry.key;
        Widget child = entry.value;
        return child
            .animate()
            .fadeIn(
              duration: duration ?? medium,
              delay: Duration(milliseconds: (delay?.inMilliseconds ?? 100) * index),
            )
            .slideY(
              begin: 0.3,
              end: 0,
              duration: duration ?? medium,
              delay: Duration(milliseconds: (delay?.inMilliseconds ?? 100) * index),
            );
      }).toList(),
    );
  }

  // Custom hero animation
  static Widget heroAnimation(Widget child, String tag) {
    return Hero(
      tag: tag,
      child: child,
    );
  }

  // Morphing container
  static Widget morphingContainer({
    required Widget child,
    required Duration duration,
    Color? color,
    BorderRadius? borderRadius,
    BoxShadow? boxShadow,
  }) {
    return AnimatedContainer(
      duration: duration,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: boxShadow != null ? [boxShadow] : null,
      ),
      child: child,
    );
  }

  // Typing animation
  static Widget typeWriter(String text, {Duration? duration, TextStyle? style}) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: style,
          speed: duration ?? const Duration(milliseconds: 100),
        ),
      ],
      totalRepeatCount: 1,
    );
  }

  // Loading animations
  static Widget loadingDots({Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: color ?? Colors.blue,
            shape: BoxShape.circle,
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1.2, 1.2),
              duration: const Duration(milliseconds: 600),
              delay: Duration(milliseconds: index * 200),
            );
      }),
    );
  }

  // Page transition animations
  static PageRouteBuilder createRoute(Widget page, {String? transitionType}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case 'slide':
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          case 'fade':
            return FadeTransition(opacity: animation, child: child);
          case 'scale':
            return ScaleTransition(scale: animation, child: child);
          case 'rotation':
            return RotationTransition(turns: animation, child: child);
          default:
            return FadeTransition(opacity: animation, child: child);
        }
      },
    );
  }
}

// Custom animated text widget
class AnimatedTextKit extends StatefulWidget {
  final List<AnimatedText> animatedTexts;
  final int totalRepeatCount;
  final Duration pause;
  final VoidCallback? onTap;
  final VoidCallback? onNext;
  final VoidCallback? onNextBeforePause;
  final VoidCallback? onFinished;
  final bool isRepeatingAnimation;
  final bool repeatForever;
  final bool displayFullTextOnTap;
  final bool stopPauseOnTap;

  const AnimatedTextKit({
    super.key,
    required this.animatedTexts,
    this.totalRepeatCount = 3,
    this.pause = const Duration(milliseconds: 1000),
    this.onTap,
    this.onNext,
    this.onNextBeforePause,
    this.onFinished,
    this.isRepeatingAnimation = true,
    this.repeatForever = false,
    this.displayFullTextOnTap = false,
    this.stopPauseOnTap = false,
  });

  @override
  State<AnimatedTextKit> createState() => _AnimatedTextKitState();
}

class _AnimatedTextKitState extends State<AnimatedTextKit>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int _currentIndex = 0;
  int _repeatCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animatedTexts[_currentIndex].duration,
      vsync: this,
    );
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward().then((_) {
      if (widget.isRepeatingAnimation) {
        Future.delayed(widget.pause, () {
          if (mounted) {
            _nextAnimation();
          }
        });
      }
    });
  }

  void _nextAnimation() {
    if (_currentIndex < widget.animatedTexts.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _repeatCount++;
      if (widget.repeatForever || _repeatCount < widget.totalRepeatCount) {
        setState(() {
          _currentIndex = 0;
        });
      } else {
        widget.onFinished?.call();
        return;
      }
    }

    _controller.duration = widget.animatedTexts[_currentIndex].duration;
    _controller.reset();
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: widget.animatedTexts[_currentIndex].animatedBuilder(context, _controller),
    );
  }
}

abstract class AnimatedText {
  final String text;
  final TextStyle? textStyle;
  final Duration duration;

  AnimatedText({
    required this.text,
    this.textStyle,
    this.duration = const Duration(milliseconds: 2000),
  });

  Widget animatedBuilder(BuildContext context, AnimationController controller);
}

class TypewriterAnimatedText extends AnimatedText {
  final Duration speed;

  TypewriterAnimatedText(
    String text, {
    super.textStyle,
    this.speed = const Duration(milliseconds: 100),
  }) : super(text: text, duration: speed * text.length);

  @override
  Widget animatedBuilder(BuildContext context, AnimationController controller) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final int endIndex = (text.length * controller.value).round();
        return Text(
          text.substring(0, endIndex),
          style: textStyle,
        );
      },
    );
  }
}
