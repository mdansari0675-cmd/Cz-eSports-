import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_registration_model.freezed.dart';
part 'tournament_registration_model.g.dart';

@freezed
class TournamentRegistrationModel with _$TournamentRegistrationModel {
  const factory TournamentRegistrationModel({
    required String userId,
    required String tournamentId,
    DateTime? registrationDate,
    @Default(false) bool entryFeeDeducted,
    @Default(0.0) double entryFeeAmount,
    String? transactionId,
    @Default('registered') String status,
    String? participantInGameId,
    @Default(false) bool resultSubmitted,
    String? resultImageUrl,
    @Default('pending') String resultStatus,
    DateTime? adminReviewedAt,
    String? adminReviewedBy,
    int? killCount,
    int? finalRank,
    double? prizeWon,
    @Default(false) bool prizeDistributed,
    DateTime? prizeDistributedAt,
  }) = _TournamentRegistrationModel;

  factory TournamentRegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentRegistrationModelFromJson(json);

  factory TournamentRegistrationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TournamentRegistrationModel.fromJson({
      ...data,
      'registrationDate': (data['registrationDate'] as Timestamp?)?.toDate(),
      'adminReviewedAt': (data['adminReviewedAt'] as Timestamp?)?.toDate(),
      'prizeDistributedAt':
          (data['prizeDistributedAt'] as Timestamp?)?.toDate(),
    });
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json['registrationDate'] = registrationDate == null
        ? null
        : Timestamp.fromDate(registrationDate!);
    json['adminReviewedAt'] = adminReviewedAt == null
        ? null
        : Timestamp.fromDate(adminReviewedAt!);
    json['prizeDistributedAt'] = prizeDistributedAt == null
        ? null
        : Timestamp.fromDate(prizeDistributedAt!);
    return json;
  }
}
