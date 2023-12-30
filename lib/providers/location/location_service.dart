import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:polymarq/providers/location/address_model.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/logger.dart';

final postionProvider = FutureProvider.autoDispose<Position?>((ref) async {
  return LocationService().getCurrentPosition().then((position) => position);
});

final locationProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final addressProvider = FutureProvider.autoDispose<AddressModel?>((ref) async {
  final position = await ref.watch(postionProvider.future);
  if (position != null) {
    return ref.read(locationProvider).getAddress(
          position.latitude,
          position.longitude,
        );
  }
  return null;
});

class LocationService {
  // LocationService(this.context);

  // final BuildContext? context;
  String? _currentAddress;
  Position? _currentPosition;

  String? get currentAddress => _currentAddress;
  Position? get currentPosition => _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      final context = AppRoute.navigatorKey.currentContext!;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location services are disabled. Please enable the services',
          ),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        final context = AppRoute.navigatorKey.currentContext!;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      final context = AppRoute.navigatorKey.currentContext!;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  Future<Position?> getCurrentPosition() async {
    log.d('Getting current location');
    try {
      final hasPermission = await _handleLocationPermission();

      if (!hasPermission) {
        log.d('Permission not granted');
        return null;
      }

      final value = Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await value.then((value) async {
        final val = await getAddress(value.latitude, value.longitude);
        log.d(val);
        // return value;
      });
      return value;
    } catch (e) {
      log.d(e);
      return null;
    }
  }

  /// get the user's current address from their coordinates
  Future<AddressModel?> getAddress(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        //  '${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}';
        return AddressModel(
          address: place.name,
          locality: place.locality,
          postalCode: place.postalCode,
          country: place.country,
        );
      } else {
        return null;
      }
    } catch (e) {
      log.e(e.toString());
      return null;
    
    }
  }
}
