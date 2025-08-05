import 'package:flutter/material.dart';
import 'responsive.dart';

class LayoutUtils {
  // Safe container that prevents overflow
  static Widget safeContainer({
    required BuildContext context,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
    Decoration? decoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? Responsive.padding(context),
      margin: margin,
      color: color,
      decoration: decoration,
      constraints: constraints ?? BoxConstraints(
        maxWidth: Responsive.width(context),
        maxHeight: Responsive.height(context),
      ),
      child: child,
    );
  }

  // Safe column that prevents overflow
  static Widget safeColumn({
    required BuildContext context,
    required List<Widget> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    bool scrollable = false,
    EdgeInsets? padding,
  }) {
    final column = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );

    if (scrollable) {
      return SingleChildScrollView(
        padding: padding ?? Responsive.safeAreaPadding(context),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Responsive.height(context) - 200,
          ),
          child: column,
        ),
      );
    }

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: column,
    );
  }

  // Safe row that prevents overflow
  static Widget safeRow({
    required BuildContext context,
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
        // Wrap each child in Flexible to prevent overflow
        if (child is Expanded || child is Flexible) {
          return child;
        }
        return Flexible(child: child);
      }).toList(),
    );
  }

  // Safe text that handles overflow
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
      maxLines: maxLines ?? 3,
      overflow: overflow ?? TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }

  // Safe grid view
  static Widget safeGridView({
    required BuildContext context,
    required List<Widget> children,
    int? crossAxisCount,
    double? childAspectRatio,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    EdgeInsets? padding,
    bool shrinkWrap = true,
    ScrollPhysics? physics,
  }) {
    return GridView.count(
      shrinkWrap: shrinkWrap,
      physics: physics ?? const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount ?? Responsive.gridCount(context),
      childAspectRatio: childAspectRatio ?? (Responsive.isMobile(context) ? 0.9 : 1.0),
      crossAxisSpacing: crossAxisSpacing ?? Responsive.spacing(context),
      mainAxisSpacing: mainAxisSpacing ?? Responsive.spacing(context),
      padding: padding ?? Responsive.safeAreaPadding(context),
      children: children,
    );
  }

  // Safe list view
  static Widget safeListView({
    required BuildContext context,
    required List<Widget> children,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
  }) {
    return ListView(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding ?? Responsive.safeAreaPadding(context),
      children: children,
    );
  }

  // Safe scaffold body
  static Widget safeScaffoldBody({
    required BuildContext context,
    required Widget child,
    bool resizeToAvoidBottomInset = true,
    bool addSafeArea = true,
  }) {
    Widget body = child;

    if (addSafeArea) {
      body = SafeArea(child: body);
    }

    return body;
  }

  // Responsive card
  static Widget responsiveCard({
    required BuildContext context,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? elevation,
    BorderRadius? borderRadius,
    Color? color,
  }) {
    return Card(
      elevation: elevation ?? 4,
      color: color,
      margin: margin ?? EdgeInsets.all(Responsive.spacing(context)),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: Padding(
        padding: padding ?? Responsive.padding(context),
        child: child,
      ),
    );
  }
}