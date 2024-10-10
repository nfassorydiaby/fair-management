import 'package:equatable/equatable.dart';
import '../../../data/models/stand_model.dart';

abstract class StandState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StandInitial extends StandState {}

class StandLoading extends StandState {}

class StandLoaded extends StandState {
  final List<Stand> stands;

  StandLoaded({required this.stands});

  @override
  List<Object?> get props => [stands];
}

class StandAdded extends StandState {}

class StandUpdated extends StandState {}

class StandError extends StandState {
  final String message;

  StandError({required this.message});

  @override
  List<Object?> get props => [message];
}
