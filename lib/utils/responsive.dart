import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  
  static bool isMobile(BuildContext context) => width(context) < 650;
  static bool isTablet(BuildContext context) => width(context) >= 650 && width(context) < 1100;
  static bool isDesktop(BuildContext context) => width(context) >= 1100;
  
  // Responsive font sizes
  static double fontSize(BuildContext context, double size) {
    if (isMobile(context)) {
      return size * 0.9;
    } else if (isTablet(context)) {
      return size;
    } else {
      return size * 1.1;
    }
  }
  
  // Responsive padding
  static EdgeInsets padding(BuildContext context, {
    double mobile = 16.0,
    double tablet = 24.0,
    double desktop = 32.0,
  }) {
    if (isMobile(context)) {
      return EdgeInsets.all(mobile);
    } else if (isTablet(context)) {
      return EdgeInsets.all(tablet);
    } else {
      return EdgeInsets.all(desktop);
    }
  }
  
  // Responsive spacing
  static double spacing(BuildContext context, {
    double mobile = 8.0,
    double tablet = 12.0,
    double desktop = 16.0,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }
  
  // Responsive grid count
  static int gridCount(BuildContext context, {
    int mobile = 2,
    int tablet = 3,
    int desktop = 4,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }
  
  // Safe area padding
  static EdgeInsets safeAreaPadding(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return EdgeInsets.only(
      top: padding.top,
      bottom: padding.bottom + 16,
      left: 16,
      right: 16,
    );
  }
}