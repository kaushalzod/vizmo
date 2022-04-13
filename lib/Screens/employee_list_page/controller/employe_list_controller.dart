import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizmo/Models/employee_model.dart';
import 'package:vizmo/Screens/employee_detail_page/view/employee_detail_page.dart';
import 'package:vizmo/Shared/provider/employe_list_provider.dart';

class EmployeeListController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  final _provider = EmployeeListProvider();
  List<Employee> employeeList = List.empty(growable: true);
  int? sortColumnIndex;
  bool isAscending = false;
  var isFetching = false.obs;
  List<String> columns = [
    "Id",
    "Name",
    "Email",
    "Phone",
    "Department",
    "Birthday",
    "Country",
  ];
  final _pageNo = 1.obs;

  @override
  onInit() {
    fetchEmployeeList();

    super.onInit();
  }

  get getPageNo => _pageNo.value;

  set setPageNo(int value) => _pageNo(value);

// Datatable pagination function for NextPage
  void nextPage() {
    _pageNo.value++;
    fetchEmployeeList();
  }

// Datatable pagination function for PrevPage
  void prevPage() {
    if (_pageNo.value > 1) {
      _pageNo.value--;
      fetchEmployeeList();
    }
  }

// Fetch employee list according to page no.
  fetchEmployeeList({int? pageNo}) async {
    if (pageNo != null) {
      _pageNo(pageNo);
    }
    isFetching(true);
    var data = await _provider.getEmployeeByPage(pageNo: _pageNo.value);
    employeeList = List<Employee>.from(
      data.map(
        (value) => Employee.fromMap(value),
      ),
    );
    isFetching(false);
    update();
  }

// This function will be used to search the data of datatables.
  searchEmployee({required String searchQuery}) async {
    isFetching(true);
    _pageNo(1);
    var data =
        await _provider.getEmployeeBySearchQuery(searchQuery: searchQuery);
    employeeList =
        List<Employee>.from(data.map((value) => Employee.fromMap(value)))
            .toList();
    textEditingController.clear();
    isFetching(false);
    update();
  }

// This function will be used to render the columns of datatables.
  List<DataColumn> getColumn() => columns
      .map(
        (String column) => DataColumn(
          label: Text(column),
          onSort: (int columnIndex, bool ascending) {
            if (columnIndex == 0) {
              employeeList.sort((emp1, emp2) => compareInt(
                  ascending, int.parse(emp1.id!), int.parse(emp2.id!)));
            } else if (columnIndex == 1) {
              employeeList.sort((emp1, emp2) =>
                  compareString(ascending, emp1.name!, emp2.name!));
            } else if (columnIndex == 2) {
              employeeList.sort((emp1, emp2) =>
                  compareString(ascending, emp1.email!, emp2.email!));
            } else if (columnIndex == 6) {
              employeeList.sort((emp1, emp2) =>
                  compareString(ascending, emp1.country!, emp2.country!));
            }

            sortColumnIndex = columnIndex;
            isAscending = ascending;
            update();
          },
        ),
      )
      .toList();

  // This function will be used to render the Row of datatables.
  List<DataRow> getRow() => employeeList.map((Employee employee) {
        final cells = [
          employee.id,
          employee.name,
          employee.email,
          employee.phone,
          employee.department,
          employee.birthday,
          employee.country
        ];
        return DataRow(
            cells: getCells(cells),
            onSelectChanged: (selected) {
              if (selected!) {
                Get.to(() => EmployeeDetailPage(employee: employee));
              }
            });
      }).toList();

  // This function will be used to render the Datacells in row of datatables.
  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((cell) => DataCell(Text(cell.toString()))).toList();

  // This function will be used to compare String data to sort the datatable.
  int compareString(bool ascending, String id, String id2) {
    return ascending ? id.compareTo(id2) : id2.compareTo(id);
  }

  // This function will be used to compare Int data to sort the datatable.
  int compareInt(bool ascending, int id, int id2) {
    return ascending ? id.compareTo(id2) : id2.compareTo(id);
  }
}
