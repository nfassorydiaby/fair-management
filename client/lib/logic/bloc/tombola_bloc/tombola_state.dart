import 'package:equatable/equatable.dart';

abstract class TombolaState extends Equatable {
  @override
  List<Object> get props => [];
}

class TombolaInitial extends TombolaState {}

class TombolaLoading extends TombolaState {}

class TombolaEntered extends TombolaState {
  final String result;

  TombolaEntered({required this.result});

  @override
  List<Object> get props => [result];
}

class TombolaWinner extends TombolaState {
  final String result;

  TombolaWinner({required this.result});

  @override
  List<Object> get props => [result];
}

class TombolaError extends TombolaState {
  final String message;

  TombolaError({required this.message});

  @override
  List<Object> get props => [message];
}
