import 'package:flutter/material.dart';

import '../../utils/build_context_ext.dart';
import 'custom_card.dart';

class ToastCard extends StatelessWidget {
  const ToastCard(
    this.text, {
    super.key,
    this.linkColor,
    this.onLinkPress,
  });

  final String text;
  final Color? linkColor;
  final VoidCallback? onLinkPress;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      borderRadius: BorderRadius.circular(16),
      backgroundColor: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Text(
        text,
        style: context.textTheme.bodyMedium!.apply(
          color: Theme.of(context).primaryColorLight,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
