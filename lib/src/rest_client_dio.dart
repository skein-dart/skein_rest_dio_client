import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:skein_rest_client/skein_rest_client.dart';

class RestClientDio with RestClient, RestClientHelper {

  final Dio dio;

  RestClientDio(this.dio);

  @override
  CancelableOperation<T> doPost<T>([dynamic data]) {
    final token = CancelToken();
    return _wrap(() => _request("POST", token: token, data: data), cancelToken: token);
  }

  @override
  CancelableOperation<T> doDelete<T>([data]) {
    final token = CancelToken();
    return _wrap(() => _request("DELETE", token: token, data: data), cancelToken: token);
  }

  @override
  CancelableOperation<T> doGet<T>() {
    final token = CancelToken();
    return _wrap(() => _request("GET", token: token), cancelToken: token);
  }

  @override
  CancelableOperation<T> doPatch<T>([data]) {
    final token = CancelToken();
    return _wrap(() => _request("PATCH", token: token, data: data), cancelToken: token);
  }

}

extension on RestClientDio {

  CancelableOperation<T> _wrap<T>(Future<T> Function() computation, {required CancelToken cancelToken}) {
    return CancelableOperation.fromFuture(Future(computation), onCancel: () => cancelToken.cancel());
  }

  Future<T> _request<T>(String method, {CancelToken? token, data}) async {

    final options = Options(
      method: method,
      headers: await formHeaders()
    );

    final encodedData = await encodeIfNeeded(data);

    final response = await dio.request(uri.toString(),
      data: encodedData,
      cancelToken: token,
      options: options,
    );

    return decodeIfNeeded(response.data);
  }

}