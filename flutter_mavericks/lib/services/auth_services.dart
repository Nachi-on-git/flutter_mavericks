import '../config/url_management.dart';
import 'http_service.dart';

class AuthService {
  HttpService httpService = HttpService();
  Future userLogin(
    String email,
    String password,
  ) async {
    Map<String, dynamic>? body = {
      'email': email,
      'password': password,
    };
    return await httpService.doPost(
      path: loginUrl,
      body: body,
    );
  }

  Future getUserDetails(String userToken) async {
    return await httpService.doGet(
      path: getUserDetailsApi,
      params: {
        'token': userToken,
      },
      tokenRequired: true,
    );
  }
}
