import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizmo/Models/employee_model.dart';
import 'package:vizmo/Screens/employee_detail_page/controller/employee_detail_controller.dart';

class EmployeeDetailPage extends GetView<EmployeeDetailController> {
  const EmployeeDetailPage({Key? key, required this.employee})
      : super(key: key);
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    Get.put(EmployeeDetailController(employee: employee));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Details"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Expansion Tile to show the emp image, emp name, emp email
          Card(
            child: ExpansionTile(
              title: Text(
                employee.name!,
                style: const TextStyle(fontSize: 18),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(employee.avatar!),
                radius: 25,
              ),
              subtitle: Text(employee.email!),
              children: [
                detailTile(
                    icon: Icons.numbers,
                    title: "Employee Id",
                    subtitle: employee.id!),
                detailTile(
                    icon: Icons.phone,
                    title: "Phone Number",
                    subtitle: employee.phone!),
                detailTile(
                    icon: Icons.work_outline_outlined,
                    title: "Departments",
                    subtitle: employee.department.toString()),
                detailTile(
                    icon: Icons.calendar_month,
                    title: "Birthday",
                    subtitle: employee.birthday!),
                detailTile(
                    icon: Icons.location_on,
                    title: "Country",
                    subtitle: employee.country!),
                detailTile(
                    icon: Icons.timelapse,
                    title: "Created At",
                    subtitle: employee.createdAt!),
              ],
            ),
          ),
          // Checkin details of emp
          GetBuilder<EmployeeDetailController>(
            builder: (controller) => Expanded(
              child: Column(
                children: controller.checkinList
                    .map(
                      (checkin) => ExpansionTile(
                        title: Text("Checkin Id : ${checkin.id!}"),
                        subtitle: Text("location : ${checkin.location!}"),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        childrenPadding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        children: [
                          Text(
                            "Checkin Time : " +
                                DateTime.parse(checkin.checkin!).toString(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Purpose : ${checkin.purpose!}")
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget detailTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
        ],
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
