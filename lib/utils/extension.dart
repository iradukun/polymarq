import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => size.height;
  double get width => size.width;
}

extension StringExtension on String{
  bool get isEmail => RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(this);
  String get capitalizeFirst => '${this[0].toUpperCase()}${substring(1)}';

  String get phoneNumber {
    if (length == 11) {
      // Full 11 digits without '+234'
      return '+234${substring(1)}';
    } else if (length == 10) {
      // 10 digits without '+234', add '+234'
      return '+234$this';
    } else if (length == 13 && startsWith('+234')) {
      // Full 13 digits with '+234'
      return this;
    } else if (length == 12 && startsWith('234')) {
      // 12 digits with '234', add '+'
      return '+$this';
    } else {
      // Return as is for other cases
      return this;
    }
  }

  bool get isValidPhoneNumber {
    if (length < 10) {
      return false; // Less than 10 digits is invalid
    } else if (length > 11) {
      if (!startsWith('+234') && !startsWith('234')) {
        return false; // More than 11 digits without a valid prefix is invalid
      }
    }
    return true; // Valid phone number in all other cases
  }
}
extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> removeNullValues() {
    return Map<K, V>.fromEntries(entries.where((e) => e.value != null));
  }
}