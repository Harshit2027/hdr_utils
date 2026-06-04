import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extensions/context_extensions.dart';

class HdrTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final String? labelText;
  final TextStyle? labelStyle;
  final InputDecoration? decoration;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool readOnly;
  final bool enable;
  final VoidCallback? onTap;
  final String? obscuringCharacter;
  final int? maxLength;
  final int? maxLine;
  final int? minLine;
  final Color? fillColor;
  final bool filled;
  final bool? autofocus;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final Widget? prefixIcon;
  final Widget? suffix;
  final EdgeInsetsGeometry? contentPadding;
  final String hintText;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final TextAlign? textAlign;
  final String? counterText;
  final TextCapitalization textCapitalization;
  final TextStyle? hintStyle;
  final void Function(PointerDownEvent)? onTapOutside;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;

  const HdrTextField({
    super.key,
    required this.controller,
    this.validator,
    this.textInputAction,
    this.labelText,
    this.labelStyle,
    this.decoration,
    this.suffix,
    this.onFieldSubmitted,
    this.autofillHints,
    this.keyboardType,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.obscuringCharacter,
    this.maxLength,
    this.maxLine = 1,
    this.minLine,
    this.onChanged,
    this.enable = true,
    this.fillColor,
    this.filled = true,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    required this.hintText,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.textAlign,
    this.enabledBorder,
    this.disabledBorder,
    this.focusBorder,
    this.errorBorder,
    this.counterText,
    this.textCapitalization = TextCapitalization.words,
    this.hintStyle,
    this.autofocus,
    this.onTapOutside,
    this.focusNode,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultEnabledBorder =
        enabledBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white24 : Colors.black12,
            width: 1.0,
          ),
        );

    final defaultFocusBorder =
        focusBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        );

    final defaultDisabledBorder =
        disabledBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark
                ? Colors.white10
                : Colors.black.withValues(alpha: 0.04),
            width: 1.0,
          ),
        );

    final defaultErrorBorder =
        errorBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 1.0),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style:
                labelStyle ??
                context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          maxLength: maxLength,
          maxLines: maxLine,
          minLines: minLine,
          enabled: enable,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          autofocus: autofocus ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: autofillHints != null ? {...autofillHints!} : null,
          inputFormatters: inputFormatters,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction ?? TextInputAction.next,
          obscuringCharacter: obscuringCharacter ?? "•",
          onFieldSubmitted: onFieldSubmitted,
          readOnly: readOnly,
          onTapOutside: onTapOutside ?? (event) => context.hideKeyboard(),
          onTap: onTap,
          textAlign: textAlign ?? TextAlign.start,
          onChanged: onChanged,
          textCapitalization: textCapitalization,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          decoration:
              decoration ??
              InputDecoration(
                enabledBorder: defaultEnabledBorder,
                focusedErrorBorder: defaultFocusBorder,
                focusedBorder: defaultFocusBorder,
                border: defaultEnabledBorder,
                errorBorder: defaultErrorBorder,
                disabledBorder: defaultDisabledBorder,
                counterText: counterText,
                suffix: suffix,
                hintText: hintText,
                hintStyle:
                    hintStyle ??
                    context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.6,
                      ),
                    ),
                suffixIcon: suffixIcon,
                suffixIconConstraints: suffixIconConstraints,
                prefixIcon: prefixIcon,
                prefixIconConstraints: prefixIconConstraints,
                filled: filled,
                contentPadding:
                    contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                fillColor:
                    fillColor ??
                    (isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.02)),
              ),
        ),
      ],
    );
  }
}
