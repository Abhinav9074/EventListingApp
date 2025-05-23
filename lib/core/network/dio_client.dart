import 'package:dio/dio.dart';
import 'package:event_listing_app/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

class DioClient {
  final Dio dio;

  DioClient({required this.dio});

  Future<Either<Failure, dynamic>> get(String url) async {
    try {
      final response = await dio.get(url);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ServerFailure(
        e.message ?? 'Server error occurred',
        statusCode: e.response?.statusCode,
      ));
    }
  }
}