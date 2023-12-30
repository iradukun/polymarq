import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class CustomAuthTextField extends StatelessWidget {
  const CustomAuthTextField({
    required this.hintText,
    super.key,
    this.prefixImage,
    this.suffixImage,
    this.obscureText = false,
    this.autoValidateMode,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  final String hintText;
  final String? prefixImage;
  final bool obscureText;
  final Widget? suffixImage;
  final TextInputType keyboardType;
  final AutovalidateMode? autoValidateMode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(prefixImage ?? ''),
        XMargin(context.width * 15 / 413),
        Flexible(
          child: TextFormField(
            controller: controller,
            validator: validator,
            autovalidateMode: autoValidateMode,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColor.whiteGrey,
                fontSize: context.height * 14 / 891,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.whiteGrey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.whiteGrey),
              ),
              suffixIcon: suffixImage,
            ),
          ),
        ),
      ],
    );
  }
}
