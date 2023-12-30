import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

/// login state
class ChangePasswordLoading extends ProfileState {}

class ChangePasswordFailure extends ProfileState {
  const ChangePasswordFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class ChangePasswordSuccess extends ProfileState {
  const ChangePasswordSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class VerifyPasswordLoading extends ProfileState {}

class VerifyPasswordFailure extends ProfileState {
  const VerifyPasswordFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class VerifyPasswordSuccess extends ProfileState {
  const VerifyPasswordSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class NewPasswordLoading extends ProfileState {}

class NewPasswordFailure extends ProfileState {
  const NewPasswordFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class NewPasswordSuccess extends ProfileState {
  const NewPasswordSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class DeleteAccountLoading extends ProfileState {}

class DeleteAccountFailure extends ProfileState {
  const DeleteAccountFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class DeleteAccountSuccess extends ProfileState {
  const DeleteAccountSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class CreateBankAccountLoading extends ProfileState {}

class CreateBankAccountFailure extends ProfileState {
  const CreateBankAccountFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class CreateBankAccountSuccess extends ProfileState {
  const CreateBankAccountSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
