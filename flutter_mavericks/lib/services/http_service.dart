import 'dart:convert';
import 'dart:io';
import 'package:flutter_mavericks/models/http_response.dart';
import 'package:flutter_mavericks/services/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../config/environment.dart';

class HttpService {
  doGet({
    required String path,
    required Map<String, dynamic> params,
    bool tokenRequired = false,
  }) async {
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};
      // check if token is required then add bearer token in header
      if (tokenRequired) {
        SharedPreferenceService sharedPreferences = SharedPreferenceService();
        // GET TOKEN
        String? token = await sharedPreferences.getUserToken(key: 'token');
        headers.putIfAbsent('Authorization', () => 'Bearer $token');
      }
      var uri = Uri.https(Environment.baseUrl, path, params);
      final response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = {}; // Initialize as an empty map
      if (response.body.isNotEmpty) {
        data = json.decode(utf8.decode(response.bodyBytes));
      }
      switch (response.statusCode) {
        case 200: // API success
        case 201:
        case 204:
          return HttpResponses(
              status: true,
              message: data.isNotEmpty ? data['message'] : null,
              data: data.isNotEmpty ? data['data'] : null);
        case 401: // token expired
        case 403:
          return HttpResponses(status: false, message: data['message']);
        case 400:
          return HttpResponses(status: false, message: data['message']);
        case 404: // API not found
          return HttpResponses(status: false, message: 'API not found !!!');
        case 500:
          return HttpResponses(
              status: false, message: 'Internal Server Error !');
        case 504: // Timeout
          return HttpResponses(status: false, message: 'TIMEOUT !!!');
        default:
          return HttpResponses(status: false, message: 'FAILED !!!');
      }
    } on SocketException {
      return HttpResponses(
          status: false, message: 'Please check your internet connection!!!');
    } catch (error) {
      return HttpResponses(status: false, message: error.toString());
    }
  }

  doPost({
    String? path,
    dynamic body,
    dynamic params,
    bool tokenRequired = false,
  }) async {
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};
      // check if token is required then add bearer token in header
      if (tokenRequired) {
        SharedPreferenceService sharedPreferences = SharedPreferenceService();
        // GET TOKEN
        String? token = await sharedPreferences.getUserToken(key: 'token');
        headers.putIfAbsent('Authorization', () => 'Bearer $token');
      }
      var uri = Uri.https(Environment.baseUrl, path!, params);
      final response =
          await http.post(uri, body: json.encode(body), headers: headers);
      dynamic data; // set decoded body response
      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }

      switch (response.statusCode) {
        case 200: // API success
        case 201:
        case 204:
          return HttpResponses(
              status: data['status'] == true ? true : false, message: data['message'], data: data['data'] ?? '');
        case 401: // token expired
        case 403:
          return HttpResponses(status: false, message: data['message']);
        case 400:
          return HttpResponses(status: false, message: data['message']);
        case 404: // API not found
          return HttpResponses(
              status: false,
              message: data['message'],
              data: data['data'] ?? '');
        case 500:
          return HttpResponses(
              status: false, message: 'Internal Server Error !');
        case 504: // Timeout
          return HttpResponses(status: false, message: 'TIMEOUT !!!');
        default:
          return HttpResponses(status: false, message: 'FAILED !!!');
      }
    } on SocketException {
      return HttpResponses(
          status: false, message: 'Please check your internet connection!!!');
    } catch (error) {
      return HttpResponses(status: false, message: error.toString());
    }
  }

  // get call for http
  doPut(
      {required String path,
      required Map<String, dynamic> params,
      bool tokenRequired = false}) async {
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};
      // check if token is required then add bearer token in header
      if (tokenRequired) {
        SharedPreferenceService sharedPreferences = SharedPreferenceService();
        // GET TOKEN
        String? token = await sharedPreferences.getUserToken(key: 'token');
        headers.putIfAbsent('Authorization', () => 'Bearer $token');
      }
      var uri = Uri.https(Environment.baseUrl, path, params);
      final response = await http.put(uri, headers: headers);
      dynamic data; // set decoded body response
      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }
      switch (response.statusCode) {
        case 200: // API success
        case 201:
        case 204:
          return HttpResponses(status: true, message: 'OK', data: data);
        case 401: // token expired
        case 403:
          return HttpResponses(status: false, message: 'Unauthorised !!!');
        case 400:
          return HttpResponses(status: false, message: 'Bad Request !!!');
        case 404: // API not found
          return HttpResponses(status: false, message: 'API not found !!!');
        case 504: // Timeout
          return HttpResponses(status: false, message: 'TIMEOUT !!!');
        default:
          return HttpResponses(status: false, message: 'FAILED !!!');
      }
    } on SocketException {
      return HttpResponses(
          status: false, message: 'Please check your internet connection!!!');
    } catch (error) {
      return HttpResponses(status: false, message: error.toString());
    }
  }

  // get call for http
  doDelete({
    String? path,
    Map<String, dynamic>? params,
    bool tokenRequired = false,
  }) async {
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};
      // check if token is required then add bearer token in header
      if (tokenRequired) {
        SharedPreferenceService sharedPreferences = SharedPreferenceService();
        // GET TOKEN
        String? token = await sharedPreferences.getUserToken(key: 'token');
        headers.putIfAbsent('Authorization', () => 'Bearer $token');
      }
      var uri = Uri.https(Environment.baseUrl, path!, params);
      final response = await http.delete(uri, headers: headers);
      dynamic data; // set decoded body response
      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }
      switch (response.statusCode) {
        case 200: // API success
        case 201:
        case 204:
          return HttpResponses(status: true, message: 'OK', data: data);
        case 401: // token expired
        case 403:
          return HttpResponses(status: false, message: 'Unauthorised !!!');
        case 400:
          return HttpResponses(status: false, message: 'Bad Request !!!');
        case 404: // API not found
          return HttpResponses(status: false, message: 'API not found !!!');
        case 504: // Timeout
          return HttpResponses(status: false, message: 'TIMEOUT !!!');
        default:
          return HttpResponses(status: false, message: 'FAILED !!!');
      }
    } on SocketException {
      return HttpResponses(
          status: false, message: 'Please check your internet connection!!!');
    } catch (error) {
      return HttpResponses(status: false, message: error.toString());
    }
  }

  Stream<String> doStream({
    String? path,
    String? params,
    bool tokenRequired = false,
  }) async* {
    var request = http.Request(
        'GET', Uri.parse('https://${Environment.baseUrl}/$path?$params'));
    Map<String, String> headers = {"Content-Type": "application/json"};
    // check if token is required then add bearer token in header
    if (tokenRequired) {
      SharedPreferenceService sharedPreferences = SharedPreferenceService();
      // GET TOKEN
      String? token = await sharedPreferences.getUserToken(key: 'token');
      headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    yield* streamedResponse.stream.transform(utf8.decoder);
  }

  Stream<String> doStreamWithoutTranform({
    String? path,
    String? params,
    bool tokenRequired = false,
  }) async* {
    var request = http.Request(
        'GET', Uri.parse('https://${Environment.baseUrl}/$path?$params'));
    Map<String, String> headers = {"Content-Type": "application/json"};
    // check if token is required then add bearer token in header
    if (tokenRequired) {
      SharedPreferenceService sharedPreferences = SharedPreferenceService();
      // GET TOKEN
      String? token = await sharedPreferences.getUserToken(key: 'token');
      headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    await http.Response.fromStream(streamedResponse);
  }
}
