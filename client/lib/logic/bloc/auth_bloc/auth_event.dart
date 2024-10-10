import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String role;

  RegisterUserEvent({required this.name, required this.email, required this.password, required this.role});

  @override
  List<Object?> get props => [name, email, password, role];
}

class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;

  LoginUserEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class FetchUsersEvent extends AuthEvent {}
