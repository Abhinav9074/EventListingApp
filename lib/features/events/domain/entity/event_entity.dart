class EventsEntity {
  final String eventId;
  final String eventName;
  final String eventNameRaw;
  final String ownerId;
  final String thumbUrl;
  final String thumbUrlLarge;
  final int startTime;
  final String startTimeDisplay;
  final int endTime;
  final String endTimeDisplay;
  final String location;
  final VenueEntity venue;
  final String label;
  final int featured;
  final String eventUrl;
  final String shareUrl;
  final String bannerUrl;
  final double score;
  final List<String> categories;
  final List<String> tags;
  final TicketsEntity tickets;
  final List<dynamic> customParams;

  EventsEntity({
    required this.eventId,
    required this.eventName,
    required this.eventNameRaw,
    required this.ownerId,
    required this.thumbUrl,
    required this.thumbUrlLarge,
    required this.startTime,
    required this.startTimeDisplay,
    required this.endTime,
    required this.endTimeDisplay,
    required this.location,
    required this.venue,
    required this.label,
    required this.featured,
    required this.eventUrl,
    required this.shareUrl,
    required this.bannerUrl,
    required this.score,
    required this.categories,
    required this.tags,
    required this.tickets,
    required this.customParams,
  });

  @override
  String toString() {
    return 'EventsEntity(eventId: $eventId, eventName: $eventName, location: $location, startTimeDisplay: $startTimeDisplay)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventsEntity && other.eventId == eventId;
  }

  @override
  int get hashCode => eventId.hashCode;

  DateTime get startDateTime =>
      DateTime.fromMillisecondsSinceEpoch(startTime * 1000);
  DateTime get endDateTime =>
      DateTime.fromMillisecondsSinceEpoch(endTime * 1000);

  bool get isFeatured => featured == 1;
  bool get hasTickets => tickets.hasTickets;
  bool get isFree => tickets.minTicketPrice == 0 && tickets.maxTicketPrice == 0;
}

class VenueEntity {
  final String street;
  final String city;
  final String state;
  final String country;
  final double latitude;
  final double longitude;
  final String fullAddress;

  VenueEntity({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
  });

  @override
  String toString() {
    return 'VenueEntity(city: $city, state: $state, country: $country)';
  }
}

class TicketsEntity {
  final bool hasTickets;
  final String ticketUrl;
  final String ticketCurrency;
  final int minTicketPrice;
  final int maxTicketPrice;

  TicketsEntity({
    required this.hasTickets,
    required this.ticketUrl,
    required this.ticketCurrency,
    required this.minTicketPrice,
    required this.maxTicketPrice,
  });

  String get priceRange {
    if (minTicketPrice == 0 && maxTicketPrice == 0) {
      return 'Free';
    } else if (minTicketPrice == maxTicketPrice) {
      return '$ticketCurrency $minTicketPrice';
    } else {
      return '$ticketCurrency $minTicketPrice - $maxTicketPrice';
    }
  }

  @override
  String toString() {
    return 'TicketsEntity(hasTickets: $hasTickets, priceRange: $priceRange)';
  }
}
