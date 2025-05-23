import 'package:event_listing_app/core/providers/network_providers.dart';
import 'package:event_listing_app/features/events/data/datasource/event_remote_data_source.dart';
import 'package:event_listing_app/features/events/data/repository/event_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventRemoteDataSourceProvider = Provider<EventRemoteDataSource>((ref) {
  return EventRemoteDataSourceImpl(dioClient: ref.read(dioClientProvider));
});

final eventRepositoryProvider = Provider((ref) {
  return EventRepositoryImpl(
    remoteDataSource: ref.read(eventRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});