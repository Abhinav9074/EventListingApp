import 'package:event_listing_app/features/home/domain/usecase/get_categories.dart';
import 'package:event_listing_app/features/home/provider/home_data_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getCategoriesProvider = Provider((ref) {
  return GetCategories(ref.read(categoryRepositoryProvider));
});