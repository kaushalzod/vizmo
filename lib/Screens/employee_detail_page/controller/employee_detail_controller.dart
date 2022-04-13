import 'package:get/get.dart';
import 'package:vizmo/Models/checkin_model.dart';
import 'package:vizmo/Models/employee_model.dart';
import 'package:vizmo/Shared/provider/employe_list_provider.dart';

class EmployeeDetailController extends GetxController {
  EmployeeDetailController({required this.employee});
  final Employee employee;
  final provider = EmployeeListProvider();
  List<Checkin> checkinList = List<Checkin>.empty(growable: true);

  @override
  void onInit() {
    getCheckinList();
    super.onInit();
  }

// This function will be used to fetch the checkin details of employee
  getCheckinList() async {
    var data = await provider.getAllCheckins(empId: employee.id!);
    checkinList = List<Checkin>.from(
      data.map(
        (value) => Checkin.fromMap(value),
      ),
    );
    update();
  }
}
