import '../../../../core/utils/result.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../services/location_service.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl(this._locationService);

  final LocationService _locationService;

  @override
  Future<Result<LocationResult, Failure>> getCurrentLocation() async {
    try {
      return Result.success(value: await _locationService.getDeviceLocation());
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result<Address, Failure>> getAddressFromLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      return Result.success(
        value: await _locationService.getAddressFromCoords(latitude, longitude),
      );
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result<Location, Failure>> getLocationFromAddress(
    String address,
  ) async {
    try {
      return Result.success(
        value: await _locationService.getLocationFromAddress(address),
      );
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}
