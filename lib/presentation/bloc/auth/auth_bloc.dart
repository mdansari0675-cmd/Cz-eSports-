import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        started: () => _onStarted(emit),
        loginWithGoogle: () => _onLoginWithGoogle(emit),
        loginWithPhone: (phone) => _onLoginWithPhone(phone, emit),
        verifyOtp: (otp) => _onVerifyOtp(otp, emit),
        logout: () => _onLogout(emit),
        checkDeviceId: () => _onCheckDeviceId(emit),
      );
    });
  }

  Future<void> _onStarted(Emitter<AuthState> emit) async {
    // Check if user is already authenticated
    // TODO: Implement checking auth status
  }

  Future<void> _onLoginWithGoogle(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      // TODO: Implement Google login
      // 1. Check device ID
      // 2. Perform Google OAuth
      // 3. Create/Update user in Firestore
      // 4. Emit authenticated state
      emit(const AuthState.authenticated('userId'));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> _onLoginWithPhone(
      String phoneNumber, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      // TODO: Implement phone login
      // 1. Verify device ID
      // 2. Send OTP to phone
      // 3. Emit phone verification needed state
      emit(const AuthState.phoneVerificationNeeded());
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> _onVerifyOtp(String otp, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      // TODO: Implement OTP verification
      // 1. Verify OTP with Firebase
      // 2. Create/Update user in Firestore
      // 3. Emit authenticated state
      emit(const AuthState.authenticated('userId'));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> _onLogout(Emitter<AuthState> emit) async {
    try {
      // TODO: Implement logout
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> _onCheckDeviceId(Emitter<AuthState> emit) async {
    try {
      // TODO: Implement device ID check
      // 1. Get device ID
      // 2. Check if device is already linked to another account
      // 3. Emit appropriate state
    } catch (e) {
      emit(AuthState.deviceCheckFailed(e.toString()));
    }
  }
}
