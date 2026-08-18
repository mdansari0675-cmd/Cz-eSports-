import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_model.freezed.dart';
part 'tournament_model.g.dart';

@freezed
class TournamentModel with _$TournamentModel {
  const factory TournamentModel({
    required String tournamentId,
    required String name,
    required String description,
    required String gameType,
    required String gameMode,
    @Default('upcoming') String status,
    required double entryFee,
    required Map<String, dynamic> prizePool,
    double? perKillBonus,
    required int totalSlots,
    @Default(0) int registeredPlayers,
    String? map,
    DateTime? scheduledTime,
    DateTime? registrationDeadline,
    DateTime? matchStartTime,
    DateTime? matchEndTime,
    Map<String, dynamic>? roomDetails,
    @Default([]) List<String> registeredPlayersList,
    Map<String, dynamic>? results,
    required String createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TournamentModel;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);

  factory TournamentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TournamentModel.fromJson({
      ...data,
      'tournamentId': doc.id,
      'scheduledTime': (data['scheduledTime'] as Timestamp?)?.toDate(),
      'registrationDeadline':
          (data['registrationDeadline'] as Timestamp?)?.toDate(),
      'matchStartTime': (data['matchStartTime'] as Timestamp?)?.toDate(),
      'matchEndTime': (data['matchEndTime'] as Timestamp?)?.toDate(),
      'createdAt': (data['createdAt'] as Timestamp?)?.toDate(),
      'updatedAt': (data['updatedAt'] as Timestamp?)?.toDate(),
    });
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json['scheduledTime'] =
        scheduledTime == null ? null : Timestamp.fromDate(scheduledTime!);
    json['registrationDeadline'] = registrationDeadline == null
        ? null
        : Timestamp.fromDate(registrationDeadline!);
    json['matchStartTime'] = matchStartTime == null
        ? null
        : Timestamp.fromDate(matchStartTime!);
    json['matchEndTime'] =
        matchEndTime == null ? null : Timestamp.fromDate(matchEndTime!);
    json['createdAt'] = createdAt == null ? null : Timestamp.fromDate(createdAt!);
    json['updatedAt'] = updatedAt == null ? null : Timestamp.fromDate(updatedAt!);
    json.remove('tournamentId');
    return json;
  }

  int get slotsLeft => totalSlots - registeredPlayers;

  bool get isFull => slotsLeft <= 0;

  bool get isRegistrationClosed =>
      DateTime.now().isAfter(registrationDeadline ?? DateTime.now());
}
