import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polymarq/technicians/home_screen/view/screens/notification_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/search_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/technician_dashboard_screen.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<Widget> pages = [
    const TechnicianDashboard(),
   const SearchScreen(),
    const NotificatonsScreen(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
          body: Stack(
        children: [
          Positioned.fill(
            child: pages[_selectedIndex],
          ),
          Align(
            alignment: const Alignment(0, 0.95),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: SizedBox(
                  height: context.height * 72 / AppConstants.designHeight,
                  width: MediaQuery.sizeOf(context).width * 0.70,
                  child: BottomNavigationBar(
                      unselectedItemColor: AppColor.white,
                      selectedItemColor: AppColor.white,
                      selectedLabelStyle:
                          const TextStyle(color: AppColor.white, fontSize: 11),
                      unselectedLabelStyle:
                          const TextStyle(color: AppColor.white, fontSize: 8),
                      backgroundColor: AppColor.iris,
                      type: BottomNavigationBarType.fixed,
                      onTap: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      currentIndex: _selectedIndex,
                      items: [
                        BottomNavigationBarItem(
                          activeIcon:
                              SvgPicture.asset(
                            'assets/icons/selected_home.svg',
                            height: context.height * 27 /  AppConstants.designHeight,
                          ),
                          icon: SvgPicture.asset(
                            'assets/icons/unselected_home.svg',
                            height: context.height * 27 /  AppConstants.designHeight,
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                            activeIcon:
                                SvgPicture.asset(
                              'assets/icons/selected_job.svg',
                              height: context.height * 27 /  AppConstants.designHeight,
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/unselected_job.svg',
                              height: context.height * 27 /  AppConstants.designHeight,
                            ),
                            label: 'Jobs',),
                        BottomNavigationBarItem(
                            activeIcon: SvgPicture.asset(
                              'assets/icons/selected_notify.svg',
                              height: context.height * 27 /  AppConstants.designHeight,
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/unselected_notification.svg',
                              height: context.height * 27 /  AppConstants.designHeight,
                            ),
                            label: 'Notification',),
                      ],),),
            ),
          ),


          ],
        ),
      ),
    );
  }
}
