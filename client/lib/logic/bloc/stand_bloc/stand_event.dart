import 'package:equatable/equatable.dart';

abstract class StandEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStandsEvent extends StandEvent {}

class AddStandEvent extends StandEvent {
  final String name;
  final int stock;

  AddStandEvent({required this.name, required this.stock});

  @override
  List<Object> get props => [name, stock];
}

class UpdateStandEvent extends StandEvent {
  final int standId;
  final String name;
  final int stock;

  UpdateStandEvent({required this.standId, required this.name, required this.stock});

  @override
  List<Object> get props => [standId, name, stock];
}
