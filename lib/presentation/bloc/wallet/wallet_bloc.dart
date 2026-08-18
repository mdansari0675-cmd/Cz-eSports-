import 'package:flutter_bloc/flutter_bloc.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(const WalletState.initial()) {
    on<WalletEvent>((event, emit) async {
      await event.when(
        getWalletBalance: () => _onGetWalletBalance(emit),
        addMoney: (amount) => _onAddMoney(amount, emit),
        requestWithdrawal: (amount, method, details) =>
            _onRequestWithdrawal(amount, method, details, emit),
        getTransactionHistory: () => _onGetTransactionHistory(emit),
      );
    });
  }

  Future<void> _onGetWalletBalance(Emitter<WalletState> emit) async {
    emit(const WalletState.loading());
    try {
      // TODO: Implement fetching wallet balance from Firestore
      // Get current user's wallet document
      // Emit walletLoaded state
    } catch (e) {
      emit(WalletState.error(e.toString()));
    }
  }

  Future<void> _onAddMoney(
      double amount, Emitter<WalletState> emit) async {
    emit(const WalletState.loading());
    try {
      // TODO: Implement adding money via Razorpay
      // 1. Create Razorpay order
      // 2. Open payment gateway
      // 3. Handle payment success/failure
      // 4. Update wallet balance in Firestore
      // 5. Create transaction record
      emit(WalletState.moneyAdded(0.0));
    } catch (e) {
      emit(WalletState.error(e.toString()));
    }
  }

  Future<void> _onRequestWithdrawal(
    double amount,
    String withdrawalMethod,
    Map<String, dynamic> details,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletState.loading());
    try {
      // TODO: Implement withdrawal request
      // 1. Check wallet balance
      // 2. Create withdrawal request in Firestore
      // 3. Set status to 'pending'
      // 4. Wait for admin approval
      emit(const WalletState.withdrawalRequested());
    } catch (e) {
      emit(WalletState.error(e.toString()));
    }
  }

  Future<void> _onGetTransactionHistory(
      Emitter<WalletState> emit) async {
    emit(const WalletState.loading());
    try {
      // TODO: Implement fetching transaction history
      // Fetch all transactions for current user
      // Sort by date descending
      // Emit transactionHistoryLoaded state
    } catch (e) {
      emit(WalletState.error(e.toString()));
    }
  }
}
