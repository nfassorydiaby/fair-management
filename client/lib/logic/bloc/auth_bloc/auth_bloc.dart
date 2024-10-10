import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:client/data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.registerUser(event.name, event.email, event.password, event.role);
        emit(AuthRegistered());
      } catch (error) {
        emit(AuthFailure(message: error.toString()));
      }
    });

    on<LoginUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await authRepository.loginUser(event.email, event.password);
        emit(AuthAuthenticated(token: token));
      } catch (error) {
        emit(AuthFailure(message: error.toString()));
      }
    });

    on<FetchUsersEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final users = await authRepository.getUsers();
        emit(UsersLoaded(users: users));
      } catch (error) {
        emit(AuthFailure(message: error.toString()));
      }
    });
  }
}
