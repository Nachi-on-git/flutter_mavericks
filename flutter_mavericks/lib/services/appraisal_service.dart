import 'package:flutter_mavericks/models/http_response.dart';

import '../config/url_management.dart';
import 'http_service.dart';

class AppraisalsService {
  HttpService httpService = HttpService();

  Future<HttpResponses> getMyAppraisal({required int id}) async {
    return await httpService.doGet(path: getAppraisalsApi, params: {'id': id});
  }

  submitMyAppraisal() {}
}
