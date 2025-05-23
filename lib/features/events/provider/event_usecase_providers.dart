
import 'package:event_listing_app/features/events/domain/usecases/get_events_usecase.dart';
import 'package:event_listing_app/features/events/provider/event_data_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getEventsProvider = Provider((ref) {
  return GetEvents(ref.read(eventRepositoryProvider));
});