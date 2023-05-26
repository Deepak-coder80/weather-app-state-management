import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final double lat;
  final double lng;
  final String country;

  const DirectGeocoding({
    required this.name,
    required this.lat,
    required this.lng,
    required this.country,
  });

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];

    return DirectGeocoding(
      name: data['name'],
      lat: data['lat'],
      lng: data['lon'],
      country: data['country'],
    );
  }

  @override
  List<Object> get props => [name, lat, lng, country];


  DirectGeocoding copyWith({
    String? name,
    double? lat,
    double? lng,
    String? country,
  }) {
    return DirectGeocoding(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      country: country ?? this.country,
    );
  }

  @override
  bool get stringify => true;
}
