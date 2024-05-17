import 'package:flutter_mavericks/config/url_management.dart';
import 'package:flutter_mavericks/services/http_service.dart';

class TimesheetService {
  HttpService httpService = HttpService();

  Future submitTimesheetDetails(Map<String, dynamic> timesheet) async {
    return await httpService.doPost(
        path: submitTimesheetApi, body: timesheet, tokenRequired: true);
  }

  getTimesheetDetails(int id, String month) async {
    return await httpService.doGet(
        path: getTimesheetApi,
        params: {'id': id.toString(), 'month': month},
        tokenRequired: true);
  }

  getMenteesTimesheet(String id, String month) async {
    return await httpService.doGet(
        path: getMenteeTimesheetApi, params: {'id': id, 'month' : month}, tokenRequired: true);
  }
}
