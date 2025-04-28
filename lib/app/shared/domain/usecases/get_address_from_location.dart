import '../../../../core/utils/result.dart';
import '../../../../core/utils/use_case.dart';
import '../../data/services/location_service.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';

class GetAddressFromLocation extends UseCase<Location, Address, void> {
  GetAddressFromLocation(this._locationRepository, super.logger);

  final LocationRepository _locationRepository;

  @override
  Future<Result<Address, Failure>> execute({Location? params}) {
    return _locationRepository.getAddressFromLocation(
      params!.latitude,
      params.longitude,
    );
  }
}
