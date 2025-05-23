import 'dart:developer';

import 'package:event_listing_app/features/events/domain/entity/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class EventWidget extends StatefulWidget {
  final EventsEntity data;
  const EventWidget({super.key, required this.data});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  String formatEventDate(DateTime dateTime) {
    return DateFormat('EEE MMM d yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log(widget.data.eventUrl);
        context.push('/web-view', extra: widget.data.eventUrl);
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: NetworkImage(widget.data.thumbUrl),
                  fit: BoxFit.fill,
                  onError: (exception, stackTrace) {
                    log('Error loading image: $exception');
                  },
                ),
              ),
              height: 80.h,
              width: 130.w,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.2)],
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: SizedBox(
                height: 80.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.eventName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.data.venue.city.isNotEmpty
                              ? widget.data.venue.city
                              : widget.data.location,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatEventDate(widget.data.startDateTime),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                log(
                                  'Bookmark tapped for ${widget.data.eventName}',
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                child: Icon(
                                  Icons.star_border_outlined,
                                  size: 18.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),

                            SizedBox(width: 8.w),

                            InkWell(
                              onTap: () {
                                Share.share(
                                  'Here have a look at this event on All events app ${widget.data.eventUrl}',
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                child: Icon(
                                  Icons.ios_share,
                                  size: 18.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
