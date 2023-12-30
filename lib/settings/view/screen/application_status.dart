import 'package:flutter/material.dart';
import 'package:polymarq/utils/color.dart';


class ApplicationStatusScreen extends StatelessWidget {
  const ApplicationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back),),
        title:   const Text(
          'Application Status',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20, color: AppColor.black,),
        ),
        centerTitle: true,
      ),
      body: const Column(),
    );
  }
}
