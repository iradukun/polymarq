// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  final dynamic Function() onTap;
  final Color? color;
  final double? width;

  const CustomButton({
    required this.buttonText,
    required this.onTap,
    super.key,
    this.color,
    this.width,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 50 / AppConstants.designHeight,
      width: widget.width ?? double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: context.height * 50 / AppConstants.designHeight,
            width: widget.width ?? double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: widget.color ?? AppColor.iris,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await widget.onTap();
                setState(() {
                  loading = false;
                });
              },
              child: Text(
                loading ? '' : widget.buttonText,
                style: TextStyle(
                  fontSize: context.height * 18 / 891,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          if (loading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(
                  color: AppColor.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
