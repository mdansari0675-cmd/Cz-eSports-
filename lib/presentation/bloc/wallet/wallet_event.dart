import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_event.freezed.dart';

@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.getWalletBalance() = _GetWalletBalance;
  const factory WalletEvent.addMoney(double amount) = _AddMoney;
  const factory WalletEvent.requestWithdrawal(
    double amount,
    String withdrawalMethod,
    Map<String, dynamic> details,
  ) = _RequestWithdrawal;
  const factory WalletEvent.getTransactionHistory() = _GetTransactionHistory;
}
