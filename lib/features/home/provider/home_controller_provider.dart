import 'package:event_listing_app/features/home/presentation/controller/category_controller.dart';
import 'package:event_listing_app/features/home/provider/home_usecase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryControllerProvider = 
    StateNotifierProvider<CategoryController, CategoryState>((ref) {
  return CategoryController(
    getCategories: ref.read(getCategoriesProvider),
  );
});