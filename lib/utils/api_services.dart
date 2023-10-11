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
      if (data['sts'] == '00') {
        throw Exception(data['msg']);
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

  Future<http.Response?> post({
    String? endPoint,
    Map<String, String>? body,
  }) async {
    try {
      final http.Response response = await client.post(
        Uri.parse(apiUrl + endPoint!),
        body: body,
      );

      final jsonData = jsonDecode(response.body);
      if (jsonData['sts'] == '00') {
        throw Exception(jsonData['msg']);
      } else if (response.statusCode < 200) {
        throw Exception(errorFetchingData + response.statusCode.toString());
      }

      return response;
    } on SocketException {
      throw noInternet;
    } on HttpException {
      throw serviceNotFound;
    } on FormatException {
      throw badResponseFormat;
    } catch (e) {
     String error=e.toString().split('Exception:').last.trim();
      if ( error.contains('must be a valid email') ){
        throw 'Invalid email';
      }else{
        throw throw e.toString().split('Exception:').last.trim();

      }
    }
  }
}
