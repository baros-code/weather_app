import 'package:flutter/material.dart';

import '../../../../core/presentation/widget_ext.dart';

import '../../utils/build_context_ext.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.child,
    this.width,
    this.height,
    this.constraints,
    this.enableShadows = true,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.shadowColor,
    this.showBorder = false,
    this.shape,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final bool enableShadows;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? shadowColor;
  final bool showBorder;
  final ShapeBorder? shape;
  final EdgeInsets padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        constraints: constraints,
        padding: padding,
        decoration: _buildDecoration(context),
        child: child,
      ).bordered(
        isEnabled: showBorder,
        borderColor: borderColor ?? context.theme.shadowColor,
        radius: borderRadius ?? BorderRadius.circular(16),
      ),
    );
  }

  // Helpers
  Decoration _buildDecoration(BuildContext context) {
    return shape != null
        ? ShapeDecoration(
            shape: shape!,
            color: backgroundColor ?? context.theme.scaffoldBackgroundColor,
            shadows: _buildShadows(context),
          )
        : BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            color: backgroundColor ?? context.theme.scaffoldBackgroundColor,
            boxShadow: _buildShadows(context),
          );
  }

  List<BoxShadow>? _buildShadows(BuildContext context) {
    return enableShadows
        ? [
            BoxShadow(
              color: shadowColor ??
                  context.theme.shadowColor.withValues(alpha: 0.2),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
            BoxShadow(
              color: shadowColor ??
                  context.theme.shadowColor.withValues(alpha: 0.2),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ]
        : null;
  }
  // - Helpers
}
