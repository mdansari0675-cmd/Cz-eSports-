import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_event.freezed.dart';

@freezed
class TournamentEvent with _$TournamentEvent {
  const factory TournamentEvent.fetchTournaments(String status) =
      _FetchTournaments;
  const factory TournamentEvent.getTournamentDetails(String tournamentId) =
      _GetTournamentDetails;
  const factory TournamentEvent.joinTournament(String tournamentId) =
      _JoinTournament;
  const factory TournamentEvent.getRoomDetails(String tournamentId) =
      _GetRoomDetails;
  const factory TournamentEvent.submitResult(
    String tournamentId,
    String imageUrl,
  ) = _SubmitResult;
}
