import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

@freezed
class WalletModel with _$WalletModel {
  const factory WalletModel({
    required String userId,
    @Default(0.0) double balance,
    @Default(0.0) double totalDeposited,
    @Default(0.0) double totalWithdrawn,
    @Default(0.0) double totalWon,
    @Default(0.0) double totalSpent,
    DateTime? lastUpdatedAt,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  factory WalletModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WalletModel.fromJson({
      ...data,
      'userId': doc.id,
      'lastUpdatedAt': (data['lastUpdatedAt'] as Timestamp?)?.toDate(),
    });
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json['lastUpdatedAt'] =
        lastUpdatedAt == null ? null : Timestamp.fromDate(lastUpdatedAt!);
    json.remove('userId');
    return json;
  }
}
