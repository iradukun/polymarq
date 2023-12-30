import 'package:flutter/material.dart';
import 'package:polymarq/utils/color.dart';

class ExperienceModel {

  ExperienceModel({
    required this.color,
    required this.duration,
    required this.date,
    required this.status,
    required this.companyName,
    required this.image,
  });
  final String companyName;
  final String image;
  final String duration;
  final String date;
  final String status;
  final Color color;
}

List<ExperienceModel> experience = [
  ExperienceModel(
      duration: 'Review',
      color: AppColor.yellow,
      date: '10 July - Now',
      status: 'Pending',
      companyName: 'Victor Ush',
      image: 'assets/images/user.png',
  ),
  ExperienceModel(
      duration: 'Review',
      date: '10 July - Now',
      status: 'Not Verified',
      companyName: 'CarMart.ng',
      image: 'assets/images/cart_mart.png',
      color: AppColor.whiteGrey,
  ),
  ExperienceModel(
      duration: 'Review',
      date: '10 July - Now',
      status: 'Verified',
      companyName: 'St. Nicholas Hospital',
      image: 'assets/images/hospital.png',
      color: AppColor.iris,
  ),
];
