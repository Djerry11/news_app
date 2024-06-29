import 'package:dio/dio.dart';
import 'package:news_app/src/core/utils/logger_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();
  dio.interceptors.add(LoggerInterceptor());
  return dio;
}
