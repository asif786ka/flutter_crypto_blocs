import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/coin_model.dart';
import '../../models/failure_model.dart';
import '../../repositories/crypto_repository.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository _cryptoRepository;

  CryptoBloc({required CryptoRepository cryptoRepository})
      : _cryptoRepository = cryptoRepository,
        super(CryptoState.initial());

  @override
  Stream<CryptoState> mapEventToState(
      CryptoEvent event,
      ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is RefreshCoins) {
      yield* _getCoins();
    } else if (event is LoadMoreCoins) {}
  }

  Stream<CryptoState> _getCoins() async* {
    try {
      final coins = await _cryptoRepository.getTopCoins();
      yield state.copyWith(coins: coins, status: CryptoStatus.loaded);
    } on Failure catch (err) {
      yield state.copyWith(
        failure: err,
        status: CryptoStatus.error,
      );
    }
  }

  Stream<CryptoState> _mapAppStartedToState() async* {
    yield state.copyWith(status: CryptoStatus.loading);
    yield* _getCoins();
  }
}