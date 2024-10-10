import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/token_repository.dart';
import 'token_event.dart';
import 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final TokenRepository tokenRepository;

  TokenBloc({required this.tokenRepository}) : super(TokenInitial()) {
    on<BuyTokensEvent>((event, emit) async {
      try {
        emit(TokenLoading());
        final result = await tokenRepository.buyTokens(event.parentId, event.amount);
        emit(TokensBought(result: result));
      } catch (error) {
        emit(TokenError(message: error.toString()));
      }
    });

    on<DistributeTokensEvent>((event, emit) async {
      try {
        emit(TokenLoading());
        final result = await tokenRepository.distributeTokens(
          event.parentId,
          event.childId,
          event.tokenCount,
        );
        emit(TokensDistributed(result: result));
      } catch (error) {
        emit(TokenError(message: error.toString()));
      }
    });
  }
}
