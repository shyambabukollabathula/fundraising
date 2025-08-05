import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../utils/animations.dart';

class CustomWidgets {
  // Animated Button with multiple effects
  static Widget animatedButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    double? width,
    double? height,
    BorderRadius? borderRadius,
    bool isLoading = false,
    String animationType = 'scale',
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTapDown: (_) => setState(() {}),
          onTapUp: (_) => setState(() {}),
          onTapCancel: () => setState(() {}),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: width ?? double.infinity,
            height: height ?? 50,
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.blue,
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: (backgroundColor ?? Colors.blue).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isLoading ? null : onPressed,
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoading)
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              textColor ?? Colors.white,
                            ),
                          ),
                        )
                      else ...[
                        if (icon != null) ...[
                          Icon(
                            icon,
                            color: textColor ?? Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          text,
                          style: TextStyle(
                            color: textColor ?? Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ).animate().scale(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  // Glassmorphism Card
  static Widget glassCard({
    required Widget child,
    double? width,
    double? height,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    double blur = 10,
    double opacity = 0.1,
  }) {
    return GlassmorphicContainer(
      width: width ?? 200,
      height: height ?? 100,
      borderRadius: 20,
      blur: blur,
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: opacity),
          Colors.white.withValues(alpha: opacity * 0.5),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.5),
          Colors.white.withValues(alpha: 0.2),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  // Animated Counter
  static Widget animatedCounter({
    required int value,
    TextStyle? textStyle,
    Duration? duration,
    String prefix = '',
    String suffix = '',
  }) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: duration ?? const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, child) {
        return Text(
          '$prefix${animatedValue.toString()}$suffix',
          style: textStyle ?? const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  // Shimmer Loading Card
  static Widget shimmerCard({
    double? width,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Animated Progress Bar
  static Widget animatedProgressBar({
    required double progress,
    Color? backgroundColor,
    Color? progressColor,
    double height = 8,
    BorderRadius? borderRadius,
    Duration? duration,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedContainer(
                duration: duration ?? const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                height: height,
                decoration: BoxDecoration(
                  color: progressColor ?? Colors.blue,
                  borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: (progressColor ?? Colors.blue).withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Floating Action Button with Animation
  static Widget animatedFAB({
    required VoidCallback onPressed,
    required IconData icon,
    Color? backgroundColor,
    Color? iconColor,
    String? tooltip,
    bool isExtended = false,
    String? label,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      tooltip: tooltip,
      child: Icon(
        icon,
        color: iconColor ?? Colors.white,
      ),
    ).animate().scale(
      duration: const Duration(milliseconds: 200),
      curve: Curves.elasticOut,
    ).then().shake(
      duration: const Duration(milliseconds: 300),
    );
  }

  // Animated List Tile
  static Widget animatedListTile({
    required String title,
    String? subtitle,
    IconData? leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onTap,
    Color? backgroundColor,
    int index = 0,
  }) {
    return AppAnimations.fadeInUp(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: leadingIcon != null
              ? Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    leadingIcon,
                    color: Colors.blue,
                  ),
                )
              : null,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                )
              : null,
          trailing: trailingIcon != null
              ? Icon(
                  trailingIcon,
                  color: Colors.grey[400],
                )
              : null,
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      duration: Duration(milliseconds: 300 + (index * 100)),
    );
  }

  // Animated Card with Hover Effect
  static Widget hoverCard({
    required Widget child,
    VoidCallback? onTap,
    double elevation = 4,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    EdgeInsets? padding,
  }) {
    return Card(
      elevation: elevation,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }

  // Animated Badge
  static Widget animatedBadge({
    required String text,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (backgroundColor ?? Colors.blue).withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: textColor ?? Colors.white,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ).animate().scale(
      duration: const Duration(milliseconds: 300),
      curve: Curves.elasticOut,
    );
  }

  // Animated Search Bar
  static Widget animatedSearchBar({
    required TextEditingController controller,
    required Function(String) onChanged,
    String hintText = 'Search...',
    IconData prefixIcon = Icons.search,
    VoidCallback? onClear,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon, color: Colors.grey[600]),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: onClear ?? () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 300));
  }

  // Animated Stat Card
  static Widget statCard({
    required String title,
    required String value,
    required IconData icon,
    Color? color,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return AppAnimations.scaleIn(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (color ?? Colors.blue).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color ?? Colors.blue,
                    size: 24,
                  ),
                ),
                const Spacer(),
                if (onTap != null)
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: onTap,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
