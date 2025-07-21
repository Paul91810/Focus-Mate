import 'package:bloc/bloc.dart';
import 'package:focus_mate/data/local/hive_boxs.dart';
import 'package:focus_mate/data/local/hive_keys.dart';
import 'package:focus_mate/data/models/profile_model.dart';
import 'package:focus_mate/data/repo/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileRepo repo;

  ProfileBloc(this.repo) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final profileBox = AppHiveBox.profileBox;
    final cachedProfile = profileBox.get(HiveKeys.userProfile);

    // Show cached first
    if (cachedProfile != null) {
      emit(ProfileLoaded(profile: cachedProfile, isCached: true));
    }

    try {
      final freshProfile = await repo.getProfileSmartly();
      emit(ProfileLoaded(profile: freshProfile, isCached: false));
    } catch (e) {
      if (cachedProfile != null) {
        emit(ProfileError("Could not refresh profile. Showing cached data."));
      } else {
        emit(ProfileError("Failed to load profile and no cached data."));
      }
    }
  }
}
