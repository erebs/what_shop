import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/constants/error_variables.dart';


class ApiService {
  final client = http.Client();
  static const String apiUrl = AppVariables.apiUrl;

  Future<http.Response?> get(String endPoint) async {
    try {
      final http.Response response = await client.get(
          Uri.parse(apiUrl + endPoint),
          );
      final data = jsonDecode(response.body);
      if (data['status_code'] == '00') {
        throw Exception(data['message']);
      } else if (response.statusCode < 200) {
        throw Exception(errorFetchingData + response.statusCode.toString());
      }
      return response;
    } on SocketException {
      throw Exception(noInternet);
    } on HttpException {
      throw Exception(serviceNotFound);
    } on FormatException {
      throw Exception(badResponseFormat);
    } catch (e) {
      throw Exception(unknownError);
    }
  }

  Future<http.Response?> post(
      {
        String? endPoint,
      Map<String, String>? body,
      }) async {
    try {
      final http.Response response = await client.post(
        Uri.parse(apiUrl + endPoint!),
        body: body,
      );

      final jsonData = jsonDecode(response.body);
      if (jsonData['status_code'] == '00') {
        throw Exception(jsonData['message']);
      } else if (response.statusCode < 200) {
        throw Exception(errorFetchingData + response.statusCode.toString());
      }

      return response;
    } on SocketException {
      throw Exception(noInternet);
    } on HttpException {
      throw Exception(serviceNotFound);
    } on FormatException {
      throw Exception(badResponseFormat);
    } catch (e) {
      throw Exception(e.toString().split(':')[1]);
    }
  }
}
