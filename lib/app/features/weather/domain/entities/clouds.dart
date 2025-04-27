import 'package:equatable/equatable.dart';

class Clouds extends Equatable {
  const Clouds({
    required this.all,
  });

  final int? all;

  @override
  List<Object?> get props => [all];
}
