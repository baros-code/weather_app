part of 'device_location_cubit.dart';

sealed class DeviceLocationState extends Equatable {
  const DeviceLocationState();

  @override
  List<Object?> get props => [];
}

class DeviceLocationInitial extends DeviceLocationState {}

class DeviceLocationLoading extends DeviceLocationState {}

class DeviceLocationLoaded extends DeviceLocationState {
  const DeviceLocationLoaded(this.address);

  final Address address;

  @override
  List<Object> get props => [address];
}

class DeviceLocationError extends DeviceLocationState {
  const DeviceLocationError({this.status});

  final PermissionStatus? status;

  @override
  List<Object?> get props => [status];
}
