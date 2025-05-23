import 'package:event_listing_app/core/errors/failures.dart';
import 'package:event_listing_app/features/events/domain/entity/event_entity.dart';
import 'package:event_listing_app/features/events/domain/repository/event_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetEvents {
  final EventRepository repository;

  GetEvents(this.repository);

  Future<Either<Failure, List<EventsEntity>>> call(String url) async {
    return await repository.getEvents(url);
  }
}