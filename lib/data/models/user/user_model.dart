import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String email,
    required String phone,
    required String displayName,
    String? profilePicture,
    @Default([]) List<String> deviceIds,
    required Map<String, dynamic> inGameIds,
    @Default(0.0) double walletBalance,
    @Default(0.0) double totalEarnings,
    @Default(0) int totalWinnings,
    @Default(0) int totalMatches,
    @Default('active') String accountStatus,
    @Default('pending') String kycStatus,
    Map<String, dynamic>? kycDocument,
    Map<String, dynamic>? bankDetails,
    @Default(false) bool isAdmin,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson({
      ...data,
      'userId': doc.id,
      'createdAt': (data['createdAt'] as Timestamp?)?.toDate(),
      'updatedAt': (data['updatedAt'] as Timestamp?)?.toDate(),
      'lastLoginAt': (data['lastLoginAt'] as Timestamp?)?.toDate(),
    });
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json['createdAt'] = createdAt == null ? null : Timestamp.fromDate(createdAt!);
    json['updatedAt'] = updatedAt == null ? null : Timestamp.fromDate(updatedAt!);
    json['lastLoginAt'] =
        lastLoginAt == null ? null : Timestamp.fromDate(lastLoginAt!);
    json.remove('userId');
    return json;
  }
}
