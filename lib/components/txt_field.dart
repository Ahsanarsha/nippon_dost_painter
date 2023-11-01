import 'package:flutter/material.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    Key? key,
    this.elevation,
    this.shadowColor,
    this.paddingHorizontal,
    this.paddingVertical,
    this.enabled,
    this.txtStyle,
    this.etController,
    this.autofocus,
    this.txtInputType,
    this.txtInputAction,
    this.txtAlign,
    this.maxLength,
    this.hintTxt,
    this.errorTxt,
    this.suffixIcon,
    this.icon,
    this.borderRadius,
    this.borderColor,
    this.borderStyle,
    this.borderWidth,
    this.errorColor,
    this.efontSize,
  }) : super(key: key);

  final double? elevation;
  final Color? shadowColor;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final bool? enabled;
  final TextStyle? txtStyle;
  final TextEditingController? etController;
  final bool? autofocus;
  final TextInputType? txtInputType;
  final TextInputAction? txtInputAction;
  final TextAlign? txtAlign;
  final int? maxLength;
  final String? hintTxt;
  final String? errorTxt;
  final Widget? suffixIcon;
  final String? icon;
  final double? borderRadius;
  final Color? borderColor;
  final BorderStyle? borderStyle;
  final double? borderWidth;
  final Color? errorColor;
  final double? efontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation ?? 10,
      shadowColor: shadowColor ?? Colors.grey,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 2)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal ?? 0,
          vertical: paddingVertical ?? 0,
        ),
        child: TextField(
          enabled: enabled,
          style: txtStyle ?? TextStyle(fontSize: 16),
          controller: etController,
          autofocus: autofocus ?? false,
          keyboardType: txtInputType ?? TextInputType.text,
          textInputAction: txtInputAction ?? TextInputAction.done,
          textAlign: txtAlign ?? TextAlign.center,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: errorTxt,
            errorText: errorTxt,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 2)),
              borderSide: BorderSide(
                color: borderColor ?? Colors.grey.shade100,
                style: borderStyle ?? BorderStyle.solid,
                width: borderWidth ?? 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 2)),
              borderSide: BorderSide(
                color: borderColor ?? Colors.grey.shade100,
                style: borderStyle ?? BorderStyle.solid,
                width: borderWidth ?? 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 2)),
              borderSide: BorderSide(
                color: borderColor ?? Colors.grey.shade100,
                style: borderStyle ?? BorderStyle.solid,
                width: borderWidth ?? 1,
              ),
            ),
            errorStyle: TextStyle(
              color: errorColor ?? Colors.red,
              fontSize: efontSize ?? 14,
            ),
          ),
        ),
      ),
    );
  }
}
