import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String transactionId,
    required String userId,
    required String type,
    required double amount,
    @Default('pending') String status,
    String? paymentMethod,
    String? razorpayPaymentId,
    String? razorpayOrderId,
    String? upiId,
    Map<String, dynamic>? bankDetails,
    String? tournamentId,
    String? description,
    DateTime? createdAt,
    DateTime? completedAt,
    String? failureReason,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel.fromJson({
      ...data,
      'createdAt': (data['createdAt'] as Timestamp?)?.toDate(),
      'completedAt': (data['completedAt'] as Timestamp?)?.toDate(),
    });
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json['createdAt'] = createdAt == null ? null : Timestamp.fromDate(createdAt!);
    json['completedAt'] =
        completedAt == null ? null : Timestamp.fromDate(completedAt!);
    json.remove('transactionId');
    return json;
  }
}
