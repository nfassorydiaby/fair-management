import 'package:equatable/equatable.dart';

abstract class TombolaEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EnterTombolaEvent extends TombolaEvent {
  final int studentId;
  final int tickets;

  EnterTombolaEvent({required this.studentId, required this.tickets});

  @override
  List<Object> get props => [studentId, tickets];
}

class DrawTombolaEvent extends TombolaEvent {}
