import 'package:flutter/material.dart';

class OverflowPrevention {
  // Global overflow prevention wrapper
  static Widget safeWidget({
    required Widget child,
    EdgeInsets? padding,
    BoxConstraints? constraints,
  }) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        return ConstrainedBox(
          constraints: constraints ?? BoxConstraints(
            maxWidth: boxConstraints.maxWidth,
            maxHeight: boxConstraints.maxHeight,
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        );
      },
    );
  }

  // Safe text widget that never overflows
  static Widget safeText(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines ?? 2,
      overflow: overflow ?? TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }

  // Safe container that prevents overflow
  static Widget safeContainer({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BoxDecoration? decoration,
    Color? color,
    double? width,
    double? height,
    BoxConstraints? constraints,
  }) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        return Container(
          width: width,
          height: height,
          padding: padding,
          margin: margin,
          decoration: decoration,
          color: color,
          constraints: constraints ?? BoxConstraints(
            maxWidth: boxConstraints.maxWidth,
            maxHeight: boxConstraints.maxHeight,
          ),
          child: child,
        );
      },
    );
  }

  // Safe row that prevents horizontal overflow
  static Widget safeRow({
    required List<Widget> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children.map((child) {
        if (child is Expanded || child is Flexible) {
          return child;
        }
        return Flexible(child: child);
      }).toList(),
    );
  }

  // Safe column that prevents vertical overflow
  static Widget safeColumn({
    required List<Widget> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    bool scrollable = false,
  }) {
    final column = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );

    if (scrollable) {
      return SingleChildScrollView(child: column);
    }

    return column;
  }

  // Safe list tile that prevents overflow
  static Widget safeListTile({
    Widget? leading,
    required Widget title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    EdgeInsets? contentPadding,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 80,
        minHeight: 60,
      ),
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        contentPadding: contentPadding,
      ),
    );
  }

  // Safe grid view that prevents overflow
  static Widget safeGridView({
    required List<Widget> children,
    int crossAxisCount = 2,
    double childAspectRatio = 1.0,
    double crossAxisSpacing = 8.0,
    double mainAxisSpacing = 8.0,
    EdgeInsets? padding,
    bool shrinkWrap = true,
    ScrollPhysics? physics,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: constraints.maxHeight * 0.8,
          ),
          child: GridView.count(
            shrinkWrap: shrinkWrap,
            physics: physics ?? const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            padding: padding ?? const EdgeInsets.all(8.0),
            children: children,
          ),
        );
      },
    );
  }

  // Debug function to check for potential overflow issues
  static void checkForOverflow(BuildContext context, String screenName) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    
    debugPrint('=== OVERFLOW CHECK: $screenName ===');
    debugPrint('Screen Size: ${size.width} x ${size.height}');
    debugPrint('Safe Area Padding: ${padding.toString()}');
    debugPrint('Available Height: ${size.height - padding.top - padding.bottom}');
    debugPrint('Available Width: ${size.width - padding.left - padding.right}');
    debugPrint('=====================================');
  }
}