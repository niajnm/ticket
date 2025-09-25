import 'package:flutter/material.dart';

class ModernSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback? onClear;
  final String hintText;
  final bool showClearButton;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? hintTextColor;
  final double? borderRadius;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const ModernSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
    this.hintText = 'Search',
    this.showClearButton = true,
    this.margin,
    this.backgroundColor,
    this.iconColor,
    this.hintTextColor,
    this.borderRadius = 25.0,
    this.textStyle,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBackgroundColor =
        backgroundColor ?? const Color.fromARGB(134, 188, 186, 186);
    final defaultIconColor = iconColor ?? Colors.grey[500];
    final defaultHintTextColor = hintTextColor ?? Colors.grey[500];

    return Container(
      margin: margin ?? const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: defaultBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
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
          hintStyle:
              hintStyle ??
              TextStyle(
                color: defaultHintTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Icon(Icons.search, color: defaultIconColor, size: 22),
          ),
          suffixIcon: showClearButton && controller.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(Icons.clear, color: defaultIconColor, size: 20),
                    onPressed:
                        onClear ??
                        () {
                          controller.clear();
                          onChanged('');
                        },
                  ),
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 0,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 45,
            minHeight: 22,
          ),
        ),
        style: textStyle ?? const TextStyle(fontSize: 16),
      ),
    );
  }
}
