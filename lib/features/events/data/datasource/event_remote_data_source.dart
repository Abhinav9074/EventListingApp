import 'dart:developer';

import 'package:event_listing_app/core/errors/failures.dart';
import 'package:event_listing_app/core/network/dio_client.dart';
import 'package:event_listing_app/features/events/data/models/event_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class EventRemoteDataSource {
  Future<Either<Failure, List<EventModel>>> getEvents(String url);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final DioClient dioClient;

  EventRemoteDataSourceImpl({required this.dioClient});

@override
Future<Either<Failure, List<EventModel>>> getEvents(String url) async {
  final response = await dioClient.get(url);
  return response.fold(
    (failure) => Left(failure),
    (data) {
      try {
        final eventsList = data['item'] as List;
        final events = eventsList
            .map((event) => EventModel.fromJson(event))
            .toList();
        return Right(events);
      } catch (e) {
        log('Error parsing events: $e');
        return Left(ServerFailure('Failed to parse events data'));
      }
    },
  );
}
}