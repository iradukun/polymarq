import 'package:flutter/material.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/extension.dart';

class CustomTextFieild extends StatelessWidget {
  const CustomTextFieild({
    required this.suffixImage,
    this.textName,
    super.key,
    this.color,
    this.height,
    this.obscureText = false,
    this.maxLines,
    this.keyboardType = TextInputType.text,
    this.autoValidateMode,
    this.controller,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.borderColor,
  });

  final String? textName;
  final Widget suffixImage;
  final double? height;
  final int? maxLines;
  final Color? color;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final AutovalidateMode? autoValidateMode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        maxLines: maxLines ?? 1,
        controller: controller,
        validator: validator,
        autovalidateMode: autoValidateMode,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onTap: onTap,
        readOnly: readOnly,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: context.height * 15 / 891,
            horizontal: context.width * 10 / 413,
          ),
          hintText: textName,
          hintStyle: TextStyle(
            color: color ?? AppColor.whiteGrey,
            fontSize: context.height * 13 / 891,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor ?? AppColor.lightGrey,
              width: context.width * 2 / 413,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor ?? AppColor.lightGrey,
              width: context.width * 2 / 413,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor ?? AppColor.lightGrey,
              width: context.width * 2 / 413,
            ),
          ),
          suffixIcon: suffixImage,
        ),
      ),
    );
  }
}
