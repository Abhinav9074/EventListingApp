import 'package:event_listing_app/features/events/domain/entity/event_entity.dart';
import 'package:event_listing_app/features/events/domain/usecases/get_events_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class EventController extends StateNotifier<EventState> {
  final GetEvents getEvents;

  EventController({required this.getEvents}) : super(EventState.initial());

  Future<void> fetchEvents(String url) async {
    state = state.copyWith(
      isLoading: state.events.isEmpty, // Only show loading if no events
      error: null,
    );
    
    final result = await getEvents(url);
    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (events) => state.copyWith(
        isLoading: false,
        events: events,
      ),
    );
  }

  // Add this method to reset events
  void resetEvents() {
    state = EventState.initial();
  }
}
class EventState {
  final bool isLoading;
  final String? error;
  final List<EventsEntity> events;

  EventState({
    required this.isLoading,
    this.error,
    required this.events,
  });

  factory EventState.initial() => EventState(
        isLoading: false,
        events: [],
      );

  EventState copyWith({
    bool? isLoading,
    String? error,
    List<EventsEntity>? events,
  }) {
    return EventState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      events: events ?? this.events,
    );
  }
}