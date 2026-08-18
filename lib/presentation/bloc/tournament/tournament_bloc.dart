import 'package:flutter_bloc/flutter_bloc.dart';
import 'tournament_event.dart';
import 'tournament_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  TournamentBloc() : super(const TournamentState.initial()) {
    on<TournamentEvent>((event, emit) async {
      await event.when(
        fetchTournaments: (status) => _onFetchTournaments(status, emit),
        getTournamentDetails: (id) => _onGetTournamentDetails(id, emit),
        joinTournament: (id) => _onJoinTournament(id, emit),
        getRoomDetails: (id) => _onGetRoomDetails(id, emit),
        submitResult: (id, imageUrl) => _onSubmitResult(id, imageUrl, emit),
      );
    });
  }

  Future<void> _onFetchTournaments(
      String status, Emitter<TournamentState> emit) async {
    emit(const TournamentState.loading());
    try {
      // TODO: Implement fetching tournaments from Firestore
      // Filter by status: 'live', 'upcoming', 'completed'
      // Emit loaded state with tournament list
    } catch (e) {
      emit(TournamentState.error(e.toString()));
    }
  }

  Future<void> _onGetTournamentDetails(
      String tournamentId, Emitter<TournamentState> emit) async {
    emit(const TournamentState.loading());
    try {
      // TODO: Implement fetching tournament details
      // Fetch from Firestore by tournamentId
      // Emit detailsLoaded state
    } catch (e) {
      emit(TournamentState.error(e.toString()));
    }
  }

  Future<void> _onJoinTournament(
      String tournamentId, Emitter<TournamentState> emit) async {
    emit(const TournamentState.loading());
    try {
      // TODO: Implement joining tournament
      // 1. Deduct entry fee from wallet
      // 2. Create tournament registration document
      // 3. Update tournament registeredPlayers count
      // 4. Create transaction record
      emit(const TournamentState.joinedSuccessfully());
    } catch (e) {
      emit(TournamentState.error(e.toString()));
    }
  }

  Future<void> _onGetRoomDetails(
      String tournamentId, Emitter<TournamentState> emit) async {
    emit(const TournamentState.loading());
    try {
      // TODO: Implement getting room details
      // Check if match time is within 15 minutes
      // Reveal room ID and password
      // Emit roomDetailsRevealed state
    } catch (e) {
      emit(TournamentState.error(e.toString()));
    }
  }

  Future<void> _onSubmitResult(
      String tournamentId, String imageUrl, Emitter<TournamentState> emit) async {
    emit(const TournamentState.loading());
    try {
      // TODO: Implement result submission
      // 1. Upload image to Firebase Storage
      // 2. Update tournament registration with result
      // 3. Set resultStatus to 'pending'
      // 4. Wait for admin approval
      emit(const TournamentState.resultSubmitted());
    } catch (e) {
      emit(TournamentState.error(e.toString()));
    }
  }
}
