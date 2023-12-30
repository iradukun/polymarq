import 'package:flutter/material.dart';

class AppColor {
  static const black = Color(0XFF000000);
  static const white = Color(0XFFFFFFFF);
  static const whiteGrey = Color(0xFFC9CBD2);
  static const iris = Color(0xFF6C63FF);
  static const blackGrey = Color(0xFF8C8CA1);
  static const lightGrey = Color(0xFFE2E9FF);
  static const lightBlue = Color(0xFFFAFCFE);
  static const accent = Color(0xFFECF1F4);
  static const iris100 = Color(0xFFF8F8FF);
  static const blue = Color(0xFFACE3EB);
  static const peach = Color(0xFFF3D9DA);
  static const black100 = Color(0xFF4A4A68);
  static const black200 = Color(0xFFD9D9D9);
  static const teal = Color(0xFF82FF80);
  static const lightGreen = Color(0xFFE5F5EC);
  static const yellow = Color(0xFFEFCF28);
  static const vigo = Color(0xFFD67EFF);
  static const red = Color(0xFFE73D3D);
  static const virgo = Color(0xFFE1B0FF);
  static const lightVirgo = Color(0x7FE1B0FF);
  static const lightfadeCyan = Color(0x4CACE3EA);
  static const lightIris = Color(0xFFF9FCFD);
  static Color gray50087 = fromHex('#87979592');
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
