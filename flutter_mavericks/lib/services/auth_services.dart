import '../config/url_management.dart';
import 'http_service.dart';

class AuthService {
  HttpService httpService = HttpService();

  Future userLogin(
    String email,
    String password,
  ) async {
    Map<String, dynamic>? body = {
      'email': 'reeva@gmail.com',
      'password': 'Reeva@123',
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
