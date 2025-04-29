import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../app_config.dart';
import '../../domain/entities/location.dart' as l1;

abstract class LocationService {
  /// Returns the current position of the device.
  Future<LocationResult> getDeviceLocation();

  Future<Address> getAddressFromCoords(double latitude, double longitude);

  Future<l1.Location> getLocationFromAddress(String address);
}

class DeviceLocationServiceImpl implements LocationService {
  @override
  Future<LocationResult> getDeviceLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return LocationResult(status: PermissionStatus.denied);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return LocationResult(status: PermissionStatus.denied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return LocationResult(status: PermissionStatus.deniedForever);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();
    // Return our custom object for encapsulating the latitude and longitude.
    final location = l1.Location(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    return LocationResult(
      status: PermissionStatus.granted,
      location: location,
    );
  }

  @override
  Future<Address> getAddressFromCoords(
    double latitude,
    double longitude,
  ) async {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      if (placemark.administrativeArea != null) {
        return Address(
          city: placemark.administrativeArea!,
          street: placemark.street ?? AppConfig.defaultString,
          country: placemark.country ?? AppConfig.defaultString,
        );
      }
    }
    throw Exception(
      'No address found for the coordinates: $latitude, $longitude',
    );
  }

  @override
  Future<l1.Location> getLocationFromAddress(String address) async {
    final locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      return l1.Location(
        latitude: locations.first.latitude,
        longitude: locations.first.longitude,
      );
    }
    throw Exception('No location found for the address: $address');
  }
}

class Address {
  const Address({
    required this.city,
    this.street,
    this.country,
  });

  final String city;
  final String? street;
  final String? country;

  factory Address.newYork() {
    return const Address(
      city: 'New York',
      street: 'Broadway',
      country: 'USA',
    );
  }
}

class LocationResult {
  const LocationResult({
    required this.status,
    this.location,
  });

  final PermissionStatus status;
  final l1.Location? location;
}

enum PermissionStatus {
  granted,
  denied,
  deniedForever,
}
