import '../../../../core/utils/result.dart';
import '../../data/services/location_service.dart';

abstract class LocationRepository {
  Future<Result<LocationResult, Failure>> getCurrentLocation();

  Future<Result<Address, Failure>> getAddressFromCoords(
    double latitude,
    double longitude,
  );
}
