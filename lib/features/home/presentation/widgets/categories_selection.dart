import 'package:event_listing_app/core/utils/custom_bottom_sheet.dart';
import 'package:event_listing_app/features/home/presentation/widgets/category_list_tile.dart';
import 'package:event_listing_app/features/home/provider/home_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_listing_app/features/home/presentation/widgets/category_error_widget.dart';
import 'package:event_listing_app/features/home/presentation/widgets/category_loading_widget.dart';
import 'package:event_listing_app/features/home/presentation/widgets/single_category.dart';

class CartegorySelection extends ConsumerStatefulWidget {
  const CartegorySelection({super.key});

  @override
  ConsumerState<CartegorySelection> createState() => _CartegorySelectionState();
}

class _CartegorySelectionState extends ConsumerState<CartegorySelection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryControllerProvider.notifier).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryControllerProvider);

    if (state.isLoading && state.categories.isEmpty) {
      return const CategoryLoadingWidget();
    }

    if (state.error != null) {
      return CategoryErrorWidget(
        message: state.error!,
        onRetry:
            () =>
                ref.read(categoryControllerProvider.notifier).fetchCategories(),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: InkWell(
                  radius: 5,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    showCustomBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      child: CategoryListTile(data: state.categories),
                    );
                  },
                  child: Text(
                    '  Explore Categories  ',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      fontFamily: 'JakartaBold',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(Icons.arrow_forward_ios_rounded, size: 15),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 170.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 15 : 0),
                  child: SingleCategoryWidget(data: state.categories[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
