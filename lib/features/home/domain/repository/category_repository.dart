import 'package:event_listing_app/core/errors/failures.dart';
import 'package:event_listing_app/features/home/domain/entity/category_entity.dart' show CategoryEntity;
import 'package:fpdart/fpdart.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}