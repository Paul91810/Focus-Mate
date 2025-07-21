part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final GetProfile profile;
  final bool isCached;

  ProfileLoaded({required this.profile, this.isCached = false});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
