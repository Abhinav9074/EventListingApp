import 'package:event_listing_app/features/home/domain/entity/category_entity.dart';
import 'package:event_listing_app/features/home/domain/usecase/get_categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CategoryController extends StateNotifier<CategoryState> {
  final GetCategories getCategories;

  CategoryController({required this.getCategories})
      : super(CategoryState.initial());

  Future<void> fetchCategories() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await getCategories();
    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (categories) => state.copyWith(
        isLoading: false,
        categories: categories,
      ),
    );
  }
}

class CategoryState {
  final bool isLoading;
  final String? error;
  final List<CategoryEntity> categories;

  CategoryState({
    required this.isLoading,
    this.error,
    required this.categories,
  });

  factory CategoryState.initial() => CategoryState(
        isLoading: false,
        categories: [],
      );

  CategoryState copyWith({
    bool? isLoading,
    String? error,
    List<CategoryEntity>? categories,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      categories: categories ?? this.categories,
    );
  }
}