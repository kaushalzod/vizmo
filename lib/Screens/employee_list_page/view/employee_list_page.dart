import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizmo/Screens/employee_list_page/controller/employe_list_controller.dart';

class EmployeeListPage extends GetView<EmployeeListController> {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dependency Injection of Employee list controller
    var employeelistController = Get.put(EmployeeListController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
        actions: [
          // Refresh Button to refresh all the data from page 1
          IconButton(
            onPressed: () {
              controller.fetchEmployeeList(pageNo: 1);
            },
            icon: const Icon(Icons.refresh),
          ),
          // Search button to filter out the query user input
          // It will display dialog with text field to input Search query
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Search",
                content: Column(
                  children: [
                    // Textfield to take user input and run search query
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: controller.textEditingController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          label: Text("Search"),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        ),
                      ),
                    ),
                  ],
                ),
                // On confirm button press search http call will be executed
                // and result will be stored in employeelist variable and will be show
                // in Datatables
                confirm: TextButton(
                  onPressed: () {
                    controller.searchEmployee(
                        searchQuery: controller.textEditingController.text);
                    Get.back();
                  },
                  child: const Text("Search"),
                ),
                // Cancel button is used to close the dialog box
                cancel: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Close"),
                ),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      // Two conditions where if http call is in progress then CircularProgress Indicator will be shown
      // and If http call is not in progress but data is empty so Not found text will be displayed
      // if neither http call nor data is empty then Datatable will be displayed
      body: Obx(
        () => controller.isFetching.value
            ? const Center(child: CircularProgressIndicator())
            : controller.employeeList.isEmpty
                ? const Center(child: Text("Employees Not Found"))
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            // Get Builder is a widget from Getx package to manage the state
                            GetBuilder<EmployeeListController>(
                              init: employeelistController,
                              builder: (controller) {
                                return DataTable(
                                  columns: controller.getColumn(),
                                  rows: controller.getRow(),
                                  showCheckboxColumn: false,
                                  sortColumnIndex: controller.sortColumnIndex,
                                  sortAscending: controller.isAscending,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // Custom Pagination button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              controller.prevPage();
                            },
                            label: const Icon(Icons.arrow_back),
                            icon: const Text("Prev"),
                          ),
                          Obx(
                            () => Text(controller.getPageNo.toString()),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              controller.nextPage();
                            },
                            label: const Text("Next"),
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }
}
