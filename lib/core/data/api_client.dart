import 'package:dio/dio.dart';
import '../constants/config.dart';
import 'models/user.dart';
import 'providers/local_storage.dart';

class ApiClient {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: Config.baseMTVirtual));

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Config.baseMTVirtual,
      // receiveTimeout: 15000,
      // connectTimeout: 15000,
      // sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });

    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final User? user = await LocalStorage().getSession();
    // if token required
    if (options.headers.containsKey("requiresToken")) {
      bool require = options.headers["requiresToken"];
      if (require) {
        // if local token has expired
        if (user == null) {
          print("ERROR IN LOGIN");
        } else {
          // set token from securelocalstorage
          options.headers.remove("requiresToken");
          options.headers.addAll({
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user.token}',
          });
        }
      }
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }
}
