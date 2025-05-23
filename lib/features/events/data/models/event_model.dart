import 'package:event_listing_app/features/events/domain/entity/event_entity.dart';

class EventModel extends EventsEntity {
  EventModel({
    required super.eventId,
    required super.eventName,
    required super.eventNameRaw,
    required super.ownerId,
    required super.thumbUrl,
    required super.thumbUrlLarge,
    required super.startTime,
    required super.startTimeDisplay,
    required super.endTime,
    required super.endTimeDisplay,
    required super.location,
    required super.venue,
    required super.label,
    required super.featured,
    required super.eventUrl,
    required super.shareUrl,
    required super.bannerUrl,
    required super.score,
    required super.categories,
    required super.tags,
    required super.tickets,
    required super.customParams,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['event_id'] ?? '',
      eventName: json['eventname'] ?? '',
      eventNameRaw: json['eventname_raw'] ?? '',
      ownerId: json['owner_id'] ?? '',
      thumbUrl: json['thumb_url'] ?? '',
      thumbUrlLarge: json['thumb_url_large'] ?? '',
      startTime: json['start_time'] ?? 0,
      startTimeDisplay: json['start_time_display'] ?? '',
      endTime: json['end_time'] ?? 0,
      endTimeDisplay: json['end_time_display'] ?? '',
      location: json['location'] ?? '',
      venue: VenueModel.fromJson(json['venue'] ?? {}),
      label: json['label'] ?? '',
      featured: json['featured'] ?? 0,
      eventUrl: json['event_url'] ?? '',
      shareUrl: json['share_url'] ?? '',
      bannerUrl: json['banner_url'] ?? '',
      score: json['score']?.toDouble() ?? 0.0,
      categories: List<String>.from(json['categories'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      tickets: TicketsModel.fromJson(json['tickets'] ?? {}),
      customParams: json['custom_params'] ?? [],
    );
  }
}

class VenueModel extends VenueEntity {
  VenueModel({
    required super.street,
    required super.city,
    required super.state,
    required super.country,
    required super.latitude,
    required super.longitude,
    required super.fullAddress,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      fullAddress: json['full_address'] ?? '',
    );
  }
}

class TicketsModel extends TicketsEntity {
  TicketsModel({
    required super.hasTickets,
    required super.ticketUrl,
    required super.ticketCurrency,
    required super.minTicketPrice,
    required super.maxTicketPrice,
  });

  factory TicketsModel.fromJson(Map<String, dynamic> json) {
    return TicketsModel(
      hasTickets: json['has_tickets'] ?? false,
      ticketUrl: json['ticket_url'] ?? '',
      ticketCurrency: json['ticket_currency'] ?? '',
      minTicketPrice: json['min_ticket_price'] ?? 0,
      maxTicketPrice: json['max_ticket_price'] ?? 0,
    );
  }
}
