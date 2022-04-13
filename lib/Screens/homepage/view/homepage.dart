import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizmo/Screens/employee_list_page/view/employee_list_page.dart';
import 'package:vizmo/Screens/homepage/controller/homepage_controller.dart';
import 'package:vizmo/Screens/profilepage/view/profilepage.dart';

class HomePage extends GetView<HomepageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Homepage Controller Dependency Injection
    Get.put(HomepageController());
    return Scaffold(
      //Bottom Navigation Bar with Home and Person Page
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Employee List",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          currentIndex: controller.getCurrentIndex,
          onTap: (value) {
            controller.setCurrentIndex(value);
          },
        ),
      ),
      //Display Employee list or Profile page depending upon current Index
      body: Obx(
        () => controller.getCurrentIndex == 0
            ? const EmployeeListPage()
            : const ProfilePage(),
      ),
    );
  }
}
