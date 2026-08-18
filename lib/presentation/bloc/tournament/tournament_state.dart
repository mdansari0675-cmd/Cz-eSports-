import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:axiova_x/data/models/tournament/tournament_model.dart';

part 'tournament_state.freezed.dart';

@freezed
class TournamentState with _$TournamentState {
  const factory TournamentState.initial() = _Initial;
  const factory TournamentState.loading() = _Loading;
  const factory TournamentState.loaded(List<TournamentModel> tournaments) =
      _Loaded;
  const factory TournamentState.detailsLoaded(TournamentModel tournament) =
      _DetailsLoaded;
  const factory TournamentState.joinedSuccessfully() = _JoinedSuccessfully;
  const factory TournamentState.roomDetailsRevealed(
    String roomId,
    String password,
  ) = _RoomDetailsRevealed;
  const factory TournamentState.resultSubmitted() = _ResultSubmitted;
  const factory TournamentState.error(String message) = _Error;
}
