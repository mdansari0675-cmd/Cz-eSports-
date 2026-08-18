import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:axiova_x/data/models/wallet/wallet_model.dart';
import 'package:axiova_x/data/models/wallet/transaction_model.dart';

part 'wallet_state.freezed.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState.initial() = _Initial;
  const factory WalletState.loading() = _Loading;
  const factory WalletState.walletLoaded(WalletModel wallet) = _WalletLoaded;
  const factory WalletState.moneyAdded(double newBalance) = _MoneyAdded;
  const factory WalletState.withdrawalRequested() = _WithdrawalRequested;
  const factory WalletState.transactionHistoryLoaded(
    List<TransactionModel> transactions,
  ) = _TransactionHistoryLoaded;
  const factory WalletState.error(String message) = _Error;
}
