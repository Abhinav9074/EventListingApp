import 'package:event_listing_app/features/home/data/datasource/category_remote_data_source.dart';
import 'package:event_listing_app/features/home/data/repository/category_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_listing_app/core/providers/network_providers.dart';

final categoryRemoteDataSourceProvider = Provider<CategoryRemoteDataSource>((ref) {
  return CategoryRemoteDataSourceImpl(dioClient: ref.read(dioClientProvider));
});

final categoryRepositoryProvider = Provider((ref) {
  return CategoryRepositoryImpl(
    remoteDataSource: ref.read(categoryRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});