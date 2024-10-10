import 'package:equatable/equatable.dart';

abstract class TokenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BuyTokensEvent extends TokenEvent {
  final int parentId;
  final int amount;

  BuyTokensEvent({required this.parentId, required this.amount});

  @override
  List<Object> get props => [parentId, amount];
}

class DistributeTokensEvent extends TokenEvent {
  final int parentId;
  final int childId;
  final int tokenCount;

  DistributeTokensEvent({
    required this.parentId,
    required this.childId,
    required this.tokenCount,
  });

  @override
  List<Object> get props => [parentId, childId, tokenCount];
}
