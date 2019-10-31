import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'package:app/model.dart';

String get clientAuthorization =>
    "Basic ${new Base64Encoder().convert("app:wbdsnx".codeUnits)}";

class HttpResult {
  bool success;
  int code;
  Map<String, dynamic> data;
  String errMsg;

  HttpResult(this.success, this.code, this.data, this.errMsg);
}

class HttpUtil {
  static Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:8888'));

  HttpUtil() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions request) {},
        onResponse: (Response response) {},
        onError: (DioError error) {}));
  }

  Future<dynamic> postAsync(String url, {dynamic data}) async {
    return _getResult(await dio.post(
      url,
      data: data,
    ));
  }

  HttpResult _getResult(Response response) {
    Map data;
    if (!(response.data is Map)) {
      data = json.decode(response.data);
    } else {
      data = response.data;
    }
    int code = data['code'];
    if (code == 200) {
      return HttpResult(
          true, code, (data['data'] is Map) ? data['data'] : null, null);
    } else
      return HttpResult(false, code, null, data['msg']);
  }
}
