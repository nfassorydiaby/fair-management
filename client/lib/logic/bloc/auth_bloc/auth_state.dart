import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;

  AuthAuthenticated({required this.token});

  @override
  List<Object?> get props => [token];
}

class AuthRegistered extends AuthState {}

class UsersLoaded extends AuthState {
  final List<dynamic> users;

  UsersLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
