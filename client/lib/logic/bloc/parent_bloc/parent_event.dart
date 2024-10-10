import 'package:equatable/equatable.dart';

abstract class ParentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchChildren extends ParentEvent {
  final int parentId;

  FetchChildren({required this.parentId});

  @override
  List<Object> get props => [parentId];
}
