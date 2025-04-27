import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/location.dart';
import '../../../domain/usecases/get_address_from_location.dart';
import '../../../domain/usecases/get_device_location.dart';
import '../../../data/services/location_service.dart';

part 'device_location_state.dart';

class DeviceLocationCubit extends Cubit<DeviceLocationState> {
  DeviceLocationCubit(
    this._getDeviceLocation,
    this._getAddressFromLocation,
  ) : super(DeviceLocationInitial());

  final GetDeviceLocation _getDeviceLocation;
  final GetAddressFromLocation _getAddressFromLocation;

  Future<void> getCurrentAddress() async {
    emit(DeviceLocationLoading());
    final result = await _getDeviceLocation();
    if (result.isSuccessful) {
      if (result.value!.status == PermissionStatus.granted) {
        final addressResult = await _getAddressFromLocation(
          // If permission is granted, location is not null
          params: Location(
            latitude: result.value!.location!.latitude,
            longitude: result.value!.location!.longitude,
          ),
        );
        if (addressResult.isSuccessful) {
          emit(DeviceLocationLoaded(addressResult.value!));
          return;
        }
      } else {
        emit(DeviceLocationError(status: result.value!.status));
      }
      return;
    }
    emit(DeviceLocationError());
  }
}
