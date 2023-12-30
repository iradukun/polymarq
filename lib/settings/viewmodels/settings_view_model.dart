// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polymarq/providers/api_response.dart';
import 'package:polymarq/providers/location/location_service.dart';
import 'package:polymarq/providers/storage.dart';
import 'package:polymarq/settings/model/user_model.dart';
import 'package:polymarq/settings/repository/settings_repository.dart';
import 'package:polymarq/settings/repository/settings_repository_impl.dart';

final settingsViewModelProvider =
    Provider((ref) => SettingsViewModel(ref.watch(settingsRepositoryProvider)));

class SettingsViewModel {
  SettingsViewModel(this._settingsRepository) {
    final user = MyPref.user;
    if (user != null) {
      firstNameController.text = user.firstName ?? '';
      lastNameController.text = user.lastName ?? '';

      if (MyPref.profilePicture.isNotEmpty) {
        urlImageController.text = MyPref.profilePicture;
      } else {
        //get the current picture just in case the user has updated the picture on another device
        updateProfilePicture(sendEmptyData: true);
      }
    }
  }
  final SettingsRepository _settingsRepository;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController urlImageController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController lgaController = TextEditingController();
  File? selectedImage;

  LocationService locationService = LocationService();

  Future<ApiResponse> updateProfile() async {
    final body = {
      'user': jsonEncode({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
      }),
      'services': servicesController.text,
      'country': countryController.text,
      'city': cityController.text,
      'local_government_area': lgaController.text,
    };
    final formData = FormData.fromMap(body);
    final response = await _settingsRepository.updateProfile(formData);
    if (response.isSuccessful) {
      final data = response.data;
      print('fname:: ${formData.fields}');
      print('fname:: ${data['user']['firstName'] as String?}');
      final user = MyPref.user?.copyWith(
        firstName: data['user']['firstName'] as String?,
        lastName: data['user']['lastName'] as String?,
      );
      if (user != null) {
        MyPref.user = user;
      }
    }
    return response;
  }

  Future<ApiResponse> updateProfilePicture({bool sendEmptyData = false}) async {
    assert(
      sendEmptyData || selectedImage != null,
      'Image must be selected Or sendEmptyData must be true',
    );
    final formData = FormData.fromMap({
      'profile_picture': sendEmptyData
          ? MultipartFile.fromBytes([])
          : await MultipartFile.fromFile(selectedImage!.path),
    });
    final response = await _settingsRepository.updateProfilePicture(formData);
    if (response.isSuccessful) {
      // pickImage();
      final data = response.data;
      if (data['profilePicture'] != null) {
        urlImageController.text = data['profilePicture'] as String;
        MyPref.profilePicture = data['profilePicture'] as String;
        selectedImage = null;
      }
      return response;
    }
    return response;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
    }
  }
}

final getUserProvider = FutureProvider.autoDispose((ref) async {
  final res = await ref.watch(settingsRepositoryProvider).getProfile();
  debugPrint('data ${res.data}');
  final rawData = Map<String, dynamic>.from(res.data as Map);
  debugPrint('allraw $rawData');

  final user = UserModel.fromJson(rawData);

  debugPrint('alldata $user');
  return user;
});
