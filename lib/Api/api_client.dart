import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/api_exception.dart';


class ApiClient {
  Future<Response> invokeAPI(String path, String method, Object? body) async {
    Map<String, String> headerParams = {};
    Response response;

    String url = path;
    print(url);

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString("accessToken").toString();
    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;

    print(body);
    switch (method) {
      case "POST":
        response = await post(Uri.parse(url),
            headers: {
              'content-Type': 'application/json',
              // "Authorization": 'Bearer $accessToken'
            },
            body: body);

        break;
      case "PUT":
        response = await put(Uri.parse(url),
            headers: {
              'content-Type': 'application/json',
              // "Authorization": 'Bearer $accessToken'
            },
            body: body);
        break;
      case "DELETE":
        response = await delete(Uri.parse(url),
            headers: {
              'content-Type': 'application/json',
              // "Authorization": 'Bearer $accessToken'
            },
            body: body);
        break;
      case "POST_":
        response = await post(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;
      case "GET_":
        response = await post(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;
      case "GET":
        response = await get(
          Uri.parse(url),
          headers: {
            // "Authorization": 'Bearer $accessToken',
              'Accept': 'application/json',
            'content-Type': 'application/json',
            'x-Rapidapi-host': 'open-weather13.p.rapidapi.com',
            'x-Rapidapi-key': 'f6d974cf72msh2a38ce245a6e1dep1c3733jsn271f6f36b8b5'
          },
          
        );

        break;
      case "PATCH":
        response = await patch(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
        break;
      case "PATCH1":
        response = await patch(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;
      default:
        response = await get(Uri.parse(url), headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    }

    print('status of $path =>${response.statusCode}');
    print(response.body);
    if (response.statusCode >= 400) {
      log('$path : ${response.statusCode} : ${response.body}');
      // Utils().toastMessage(response.body);

      throw ApiException(_decodeBodyBytes(response), response.statusCode);
    }
    return response;
  }

  Future<Response> invokeMultipartAPI(String path, String method,
      Map<String, String>? fields, List<MultipartFile>? files) async {
    var uri = Uri.parse(path);
    var request = MultipartRequest(method, uri);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("accessToken").toString();

    request.headers.addAll({
      "Authorization": 'Bearer $accessToken',
    });

    if (fields != null) {
      request.fields.addAll(fields);
    }
    if (files != null) {
      request.files.addAll(files);
    }

    var streamedResponse = await request.send();
    var response = await Response.fromStream(streamedResponse);

    print('status of $path =>${response.statusCode}');
    print(response.body);
    if (response.statusCode >= 400) {
      log('$path : ${response.statusCode} : ${response.body}');
      throw ApiException(_decodeBodyBytes(response), response.statusCode);
    }
    return response;
  }

  String _decodeBodyBytes(Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}