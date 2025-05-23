import 'package:event_listing_app/features/events/presentation/controller/event_controller.dart';
import 'package:event_listing_app/features/events/provider/event_usecase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventControllerProvider = 
    StateNotifierProvider<EventController, EventState>((ref) {
  return EventController(
    getEvents: ref.read(getEventsProvider),
  );
});