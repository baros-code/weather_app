import '../../../../core/utils/result.dart';
import '../../../../core/utils/use_case.dart';
import '../../data/services/location_service.dart';
import '../repositories/location_repository.dart';

class GetDeviceLocation extends UseCase<void, LocationResult, void> {
  GetDeviceLocation(this._locationRepository, super.logger);

  final LocationRepository _locationRepository;

  @override
  Future<Result<LocationResult, Failure>> execute({void params}) {
    return _locationRepository.getCurrentLocation();
  }
}
