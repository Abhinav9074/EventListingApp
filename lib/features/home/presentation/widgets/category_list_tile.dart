import 'dart:developer';

import 'package:event_listing_app/features/home/domain/entity/category_entity.dart';
import 'package:event_listing_app/features/home/presentation/widgets/network_image_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recase/recase.dart';

class CategoryListTile extends StatelessWidget {
  final List<CategoryEntity> data;
  const CategoryListTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
          child: Text(
            "Explore Categories",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
        ),
        ...List.generate(data.length, (index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            leading: NetworkImageAvatar(imageQuery: data[index].name),
            title: Text(
              data[index].name.titleCase,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            onTap: () {
              // Add your navigation or action logic here
              log('Tapped on ${data[index].name}');
            },
          );
        }),
        SizedBox(height: 20.h),
      ],
    );
  }
}
