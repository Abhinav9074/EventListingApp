import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo2.png',
                  width: 28.w,
                  height: 28.h,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Kozhikode',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12.sp,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),

                Icon(
                  LucideIcons.ticket,
                  size: 24.sp,
                  color: Colors.grey.shade700,
                ),
                SizedBox(width: 10.w),

                Icon(
                  LucideIcons.bell,
                  size: 24.sp,
                  color: Colors.grey.shade700,
                ),
              ],
            ),

            SizedBox(height: 12.h),

            SizedBox(
              height: 30.h,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search events, places...",
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  prefixIcon: Icon(
                    LucideIcons.search,
                    color: Colors.grey.shade600,
                    size: 17.sp,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(
                      width: 0.3,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(
                      width: 0.3,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(width: 0.5, color: Colors.black87),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}
