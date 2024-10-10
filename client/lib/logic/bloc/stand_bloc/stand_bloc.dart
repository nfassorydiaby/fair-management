import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/logic/bloc/stand_bloc/stand_event.dart';
import 'package:client/logic/bloc/stand_bloc/stand_state.dart';
import '../../../data/repositories/stand_repository.dart';

class StandBloc extends Bloc<StandEvent, StandState> {
  final StandRepository standRepository;

  StandBloc({required this.standRepository}) : super(StandInitial());

  @override
  Stream<StandState> mapEventToState(StandEvent event) async* {
    if (event is LoadStandsEvent) {
      yield StandLoading();
      try {
        final stands = await standRepository.getAllStands();
        yield StandLoaded(stands: stands);
      } catch (e) {
        yield StandError(message: e.toString());
      }
    } else if (event is AddStandEvent) {
      try {
        await standRepository.addStand(event.name, event.stock);
        yield StandAdded();
        add(LoadStandsEvent()); // reload stands
      } catch (e) {
        yield StandError(message: e.toString());
      }
    } else if (event is UpdateStandEvent) {
      try {
        await standRepository.updateStand(event.standId, event.name, event.stock);
        yield StandUpdated();
        add(LoadStandsEvent()); // reload stands
      } catch (e) {
        yield StandError(message: e.toString());
      }
    }
  }
}
