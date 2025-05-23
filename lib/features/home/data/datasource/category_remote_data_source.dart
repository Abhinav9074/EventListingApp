import 'package:event_listing_app/core/errors/failures.dart';
import 'package:event_listing_app/core/network/dio_client.dart';
import 'package:event_listing_app/features/home/data/models/category_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoryRemoteDataSource {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final DioClient dioClient;
  static const String _categoriesUrl =
      'https://allevents.s3.amazonaws.com/tests/categories.json';

  CategoryRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    final response = await dioClient.get(_categoriesUrl);
    return response.fold(
      (failure) => Left(failure),
      (data) {
        try {
          final categories = (data as List)
              .map((category) => CategoryModel.fromJson(category))
              .toList();
          return Right(categories);
        } catch (e) {
          return Left(ServerFailure('Failed to parse categories data'));
        }
      },
    );
  }
}