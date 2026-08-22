import 'station.dart';

class GtfsRoute {
  final String id, shortName, longName;
  final int type;
  GtfsRoute({required this.id, required this.shortName, required this.longName, required this.type});
}

class Trip {
  final String id, routeId;
  final String? headsign;
  Trip({required this.id, required this.routeId, this.headsign});
}

class StopTime {
  final String tripId, stopId, arrivalTime, departureTime;
  final int stopSequence;
  StopTime({required this.tripId, required this.stopId, required this.arrivalTime, required this.departureTime, required this.stopSequence});
}

class TripPlan {
  final List<TripStep> steps;
  final Duration totalDuration;
  TripPlan({required this.steps, required this.totalDuration});
}

class TripStep {
  final Station station;
  final String arrivalTime;
  final String? routeName;
  final bool isTransfer;
  TripStep({required this.station, required this.arrivalTime, this.routeName, this.isTransfer = false});
}
