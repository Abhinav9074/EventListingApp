import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EventsAppbar extends StatelessWidget implements PreferredSizeWidget {
  const EventsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/appbar-bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Text(
                      'Events in your city',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                SizedBox(
                  height: 40.h,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "What do yo feel like doing?",
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
                      fillColor: Colors.white.withOpacity(0.9),
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
                        borderSide: BorderSide(
                          width: 0.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    final statusBarHeight =
        WidgetsBinding.instance.window.padding.top /
        WidgetsBinding.instance.window.devicePixelRatio;
    return Size.fromHeight(80.h + statusBarHeight);
  }
}
