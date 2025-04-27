import 'package:flutter/material.dart';

import '../../utils/build_context_ext.dart';
import '../../utils/debouncer.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    this.initialValue,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.leading,
    this.backgroundColor,
    this.activeBorderColor,
    this.inActiveBorderColor,
    this.buttonColor,
    this.buttonText,
    this.submitWithEnterEnabled = true,
    this.onChange,
    this.onSubmitted,
  });

  final String? initialValue;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? activeBorderColor;
  final Color? inActiveBorderColor;
  final Color? buttonColor;
  final String? buttonText;
  final bool submitWithEnterEnabled;
  final void Function(String)? onChange;
  final void Function(String)? onSubmitted;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _controller = TextEditingController();
  final _debouncer = Debouncer(const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    const transparentColor = WidgetStatePropertyAll(Colors.transparent);
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            controller: _controller,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            constraints: const BoxConstraints(
              minHeight: 48,
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            ),
            hintText: widget.hintText,
            textStyle: WidgetStatePropertyAll(
              widget.textStyle ??
                  context.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.normal),
            ),
            side: WidgetStatePropertyAll(
              BorderSide(
                width: _controller.text.isEmpty ? 1 : 2,
                color: _controller.text.isEmpty
                    ? (widget.inActiveBorderColor ?? Colors.white)
                    : (widget.activeBorderColor ??
                        context.colorScheme.onPrimary),
              ),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            hintStyle: WidgetStatePropertyAll(
              widget.hintStyle ?? context.textTheme.titleLarge,
            ),
            leading: widget.leading,
            trailing: _controller.text.isNotEmpty
                ? [_buildClearButton(context)]
                : null,
            backgroundColor: WidgetStatePropertyAll(
              widget.backgroundColor ?? context.colorScheme.primaryContainer,
            ),
            shadowColor: transparentColor,
            surfaceTintColor: transparentColor,
            overlayColor: transparentColor,
            onChanged: (_) {
              setState(() {
                _debouncer.cancel();
                _debouncer.run(() => widget.onChange?.call(_controller.text));
              });
            },
            onSubmitted: (_) => widget.submitWithEnterEnabled
                ? widget.onSubmitted?.call(_controller.text)
                : null,
          ),
        ),
        if (widget.onSubmitted != null) ...[
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => widget.onSubmitted?.call(_controller.text),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 20),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor:
                  widget.buttonColor ?? context.colorScheme.primary,
            ),
            child: Text(
              widget.buttonText ?? 'Search',
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Helpers
  GestureDetector _buildClearButton(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.close,
        color: context.colorScheme.surface,
      ),
      onTap: () {
        setState(() {
          _controller.clear();
          _dispatchCallback();
        });
      },
    );
  }

  void _dispatchCallback() {
    if (widget.onSubmitted != null) {
      widget.onSubmitted?.call(_controller.text);
    } else {
      widget.onChange?.call(_controller.text);
    }
  }
  // - Helpers
}
