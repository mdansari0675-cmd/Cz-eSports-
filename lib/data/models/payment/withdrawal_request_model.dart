import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdrawal_request_model.freezed.dart';
part 'withdrawal_request_model.g.dart';

@freezed
class WithdrawalRequestModel with _$WithdrawalRequestModel {
  const factory WithdrawalRequestModel({
    required String requestId,
    required String userId,
    required double amount,
    required String upiId,
    Map<String, dynamic>? bankDetails,
    @Default('upi') String withdrawalMethod,
    @Default('pending') String status,
    DateTime? requestDate,
    DateTime? approvedAt,
    String? approvedBy,
    DateTime? completedAt,
    String? rejectionReason,
    String? transactionId,
    String? remarks,
  }) = _WithdrawalRequestModel;

  factory WithdrawalRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalRequestModelFromJson(json);

  factory WithdrawalRequestModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WithdrawalRequestModel.fromJson({
      ...data,
      'requestId': doc.id,
      'requestDate': (data['requestDate'] as Timestamp?)?.toDate(),
      'approvedAt': (data['approvedAt'] as Timestamp?)?.toDate(),
      'completedAt': (data['completedAt'] as Timestamp?)?.toDate(),
    });
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json['requestDate'] =
        requestDate == null ? null : Timestamp.fromDate(requestDate!);
    json['approvedAt'] =
        approvedAt == null ? null : Timestamp.fromDate(approvedAt!);
    json['completedAt'] =
        completedAt == null ? null : Timestamp.fromDate(completedAt!);
    json.remove('requestId');
    return json;
  }
}
