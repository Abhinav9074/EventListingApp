import 'package:event_listing_app/core/errors/failures.dart';
import 'package:event_listing_app/features/events/domain/entity/event_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventsEntity>>> getEvents(String url);
}