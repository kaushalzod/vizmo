import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vizmo/Shared/constant.dart';

class EmployeeListProvider {
  // Will fetch list of all employee from api
  getAllEmployee() async {
    try {
      http.Response response;
      response = await http.get(Uri.parse(baseUrl + '/employee'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Will fetch the checkin details of particular employee by employee Id
  getAllCheckins({required String empId}) async {
    try {
      http.Response response;
      response =
          await http.get(Uri.parse(baseUrl + "/employee/$empId/checkin"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //Will fetch the checkin details of particular checkin by checkin Id and Employee Id
  getCheckinDetail({required int empId, required int checkinId}) async {
    try {
      http.Response response;
      response = await http
          .get(Uri.parse(baseUrl + '/employee/$empId/checkin/$checkinId'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //Get 10 employee list by page no
  getEmployeeByPage({required int pageNo}) async {
    try {
      http.Response response;
      response = await http
          .get(Uri.parse(baseUrl + '/employee?page=$pageNo&limit=10'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //Get employee list by search query
  getEmployeeBySearchQuery({required String searchQuery}) async {
    try {
      http.Response response;
      response =
          await http.get(Uri.parse(baseUrl + '/employee?filter=$searchQuery'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
