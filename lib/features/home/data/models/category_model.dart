import 'package:event_listing_app/features/home/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.name, required super.link});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['category'],
      link: json['data'],
    );
  }
}