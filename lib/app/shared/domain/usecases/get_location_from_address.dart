import '../../../../core/utils/result.dart';
import '../../../../core/utils/use_case.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';

class GetLocationFromAddress extends UseCase<String, Location, void> {
  GetLocationFromAddress(this._locationRepository, super.logger);

  final LocationRepository _locationRepository;

  @override
  Future<Result<Location, Failure>> execute({String? params}) {
    return _locationRepository.getLocationFromAddress(params!);
  }
}
