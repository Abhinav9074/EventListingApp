import 'package:event_listing_app/core/errors/failures.dart';
import 'package:event_listing_app/core/network/network_info.dart';
import 'package:event_listing_app/features/events/data/datasource/event_remote_data_source.dart';
import 'package:event_listing_app/features/events/domain/entity/event_entity.dart';
import 'package:event_listing_app/features/events/domain/repository/event_repository.dart';
import 'package:fpdart/fpdart.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EventRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<EventsEntity>>> getEvents(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEvents = await remoteDataSource.getEvents(url);
        return remoteEvents;
      } on ServerFailure {
        return Left(ServerFailure('Server error occurred'));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}