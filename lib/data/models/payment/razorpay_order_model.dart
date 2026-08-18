import 'package:freezed_annotation/freezed_annotation.dart';

part 'razorpay_order_model.freezed.dart';
part 'razorpay_order_model.g.dart';

@freezed
class RazorpayOrderModel with _$RazorpayOrderModel {
  const factory RazorpayOrderModel({
    required String orderId,
    required double amount,
    @Default('INR') String currency,
    @Default('created') String status,
    String? receiptId,
    Map<String, dynamic>? notes,
  }) = _RazorpayOrderModel;

  factory RazorpayOrderModel.fromJson(Map<String, dynamic> json) =>
      _$RazorpayOrderModelFromJson(json);
}
