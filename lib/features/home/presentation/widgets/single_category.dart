import 'package:event_listing_app/features/home/domain/entity/category_entity.dart';
import 'package:event_listing_app/features/home/presentation/widgets/network_image_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recase/recase.dart';

class SingleCategoryWidget extends StatelessWidget {
  final CategoryEntity data;
  const SingleCategoryWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: InkWell(
        onTap: () {
          context.push('/events', extra: data);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NetworkImageAvatar(imageQuery: data.name),
            SizedBox(height: 7.h),
            Text(
              data.name.titleCase,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
