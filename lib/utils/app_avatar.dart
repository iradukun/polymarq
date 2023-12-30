import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:polymarq/utils/color.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imgUrl = '',
    this.radius = 55,
    this.backgroundColor = AppColor.white,
    this.bytes,
    this.isContact = false,
    this.contactName = '',
    this.imageFile,
  });

  final String imgUrl;
  final double radius;
  final Color backgroundColor;
  final Uint8List? bytes;
  final File? imageFile;
  final bool isContact;
  final String contactName;

  @override
  Widget build(BuildContext context) {
    if (bytes != null) {
      return Container(
        decoration: BoxDecoration(
          color: AppColor.blue,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius * 2),
          child: Image.memory(
            bytes!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 25,
              );
            },
          ),
        ),
      );
    }
    if (imageFile != null) {
      return Container(
        decoration: BoxDecoration(
          color: AppColor.blue,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius * 2),
          child: Image.file(
            imageFile!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 25,
              );
            },
          ),
        ),
      );
    }
    if (imgUrl == 'null' || imgUrl.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: AppColor.blue,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: SizedBox.expand(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius * 2),
            child: Builder(
              builder: (context) {
                return const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 25,
                );
              },
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: AppColor.blue,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: SizedBox.expand(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 25,
              );
            },
            placeholder: (context, url) {
              return const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 25,
              );
            },
            width: radius * 2,
          ),
        ),
      ),
    );
  }
}
