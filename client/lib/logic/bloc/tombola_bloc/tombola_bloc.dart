import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/tombola_repository.dart';
import 'tombola_event.dart';
import 'tombola_state.dart';

class TombolaBloc extends Bloc<TombolaEvent, TombolaState> {
  final TombolaRepository tombolaRepository;

  TombolaBloc({required this.tombolaRepository}) : super(TombolaInitial()) {
    on<EnterTombolaEvent>((event, emit) async {
      try {
        emit(TombolaLoading());
        final result = await tombolaRepository.enterTombola(event.studentId, event.tickets);
        emit(TombolaEntered(result: result));
      } catch (error) {
        emit(TombolaError(message: error.toString()));
      }
    });

    on<DrawTombolaEvent>((event, emit) async {
      try {
        emit(TombolaLoading());
        final result = await tombolaRepository.drawTombola();
        emit(TombolaWinner(result: result));
      } catch (error) {
        emit(TombolaError(message: error.toString()));
      }
    });
  }
}
