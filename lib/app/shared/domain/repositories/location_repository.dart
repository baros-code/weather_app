import '../../../../core/utils/result.dart';
import '../../data/services/location_service.dart';
import '../entities/location.dart';

abstract class LocationRepository {
  Future<Result<LocationResult, Failure>> getCurrentLocation();

  Future<Result<Address, Failure>> getAddressFromLocation(
    double latitude,
    double longitude,
  );

  Future<Result<Location, Failure>> getLocationFromAddress(
    String address,
  );
}
