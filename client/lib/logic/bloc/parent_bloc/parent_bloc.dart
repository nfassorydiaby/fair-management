import 'package:flutter_bloc/flutter_bloc.dart';
import 'parent_event.dart';
import 'parent_state.dart';
import '../../../data/repositories/parent_repository.dart';

class ParentBloc extends Bloc<ParentEvent, ParentState> {
  final ParentRepository parentRepository;

  ParentBloc({required this.parentRepository}) : super(ParentInitial());

  @override
  Stream<ParentState> mapEventToState(ParentEvent event) async* {
    if (event is FetchChildren) {
      yield ParentLoading();
      try {
        final parent = await parentRepository.fetchParentChildren(event.parentId);
        yield ParentLoaded(parent: parent);
      } catch (e) {
        yield ParentError(message: 'Failed to fetch children');
      }
    }
  }
}
