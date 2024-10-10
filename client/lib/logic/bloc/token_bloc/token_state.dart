import 'package:equatable/equatable.dart';

abstract class TokenState extends Equatable {
  @override
  List<Object> get props => [];
}

class TokenInitial extends TokenState {}

class TokenLoading extends TokenState {}

class TokensBought extends TokenState {
  final String result;

  TokensBought({required this.result});

  @override
  List<Object> get props => [result];
}

class TokensDistributed extends TokenState {
  final String result;

  TokensDistributed({required this.result});

  @override
  List<Object> get props => [result];
}

class TokenError extends TokenState {
  final String message;

  TokenError({required this.message});

  @override
  List<Object> get props => [message];
}
