import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.loginWithGoogle() = _LoginWithGoogle;
  const factory AuthEvent.loginWithPhone(String phoneNumber) =
      _LoginWithPhone;
  const factory AuthEvent.verifyOtp(String otp) = _VerifyOtp;
  const factory AuthEvent.logout() = _Logout;
  const factory AuthEvent.checkDeviceId() = _CheckDeviceId;
}
