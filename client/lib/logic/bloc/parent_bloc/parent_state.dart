import 'package:equatable/equatable.dart';
import '../../../data/models/parent_model.dart';

abstract class ParentState extends Equatable {
  @override
  List<Object> get props => [];
}

class ParentInitial extends ParentState {}

class ParentLoading extends ParentState {}

class ParentLoaded extends ParentState {
  final Parent parent;

  ParentLoaded({required this.parent});

  @override
  List<Object> get props => [parent];
}

class ParentError extends ParentState {
  final String message;

  ParentError({required this.message});

  @override
  List<Object> get props => [message];
}
