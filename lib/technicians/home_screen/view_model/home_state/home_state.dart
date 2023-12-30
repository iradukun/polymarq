import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

/// login state
class CreateToolLoading extends HomeState {}

class CreateToolFailure extends HomeState {
  const CreateToolFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class CreateToolSuccess extends HomeState {
  const CreateToolSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class EditToolLoading extends HomeState {}

class EditToolFailure extends HomeState {
  const EditToolFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class EditToolSuccess extends HomeState {
  const EditToolSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class RentToolLoading extends HomeState {}

class RentToolFailure extends HomeState {
  const RentToolFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class RentToolSuccess extends HomeState {
  const RentToolSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

/// sign up state

/// resend otp  state
class ResendOTPLoading extends HomeState {}

class ResendOTPFailure extends HomeState {
  const ResendOTPFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class ResendOTPSuccess extends HomeState {
  const ResendOTPSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

/// verify otp  state
class VerifyOTPLoading extends HomeState {}

class VerifyOTPFailure extends HomeState {
  const VerifyOTPFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class VerifyOTPSuccess extends HomeState {
  const VerifyOTPSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

/// password reset state
class PasswordResetLoading extends HomeState {}

class PasswordResetFailure extends HomeState {
  const PasswordResetFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class PasswordResetSuccess extends HomeState {
  const PasswordResetSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

/// password token verify state
class PasswordTokenVerifyLoading extends HomeState {}

class PasswordTokenVerifyFailure extends HomeState {
  const PasswordTokenVerifyFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class PasswordTokenVerifySuccess extends HomeState {
  const PasswordTokenVerifySuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

/// password confirm state
class PasswordConfirmLoading extends HomeState {}

class PasswordConfirmFailure extends HomeState {
  const PasswordConfirmFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class PasswordConfirmSuccess extends HomeState {
  const PasswordConfirmSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

/// phone initialize registration state
class PhoneInitializeLoading extends HomeState {}

class PhoneInitializeFailure extends HomeState {
  const PhoneInitializeFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class PhoneInitializeSuccess extends HomeState {
  const PhoneInitializeSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

/// verify phone state
class PhoneVerifyLoading extends HomeState {}

class PhoneVerifyFailure extends HomeState {
  const PhoneVerifyFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class PhoneVerifySuccess extends HomeState {
  const PhoneVerifySuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

/// register personal with phone state
class PhoneRegisterLoading extends HomeState {}

class PhoneRegisterFailure extends HomeState {
  const PhoneRegisterFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class PhoneRegisterSuccess extends HomeState {
  const PhoneRegisterSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

/// resend phone verification state
class PhoneResendVerificationLoading extends HomeState {}

class PhoneResendVerificationFailure extends HomeState {
  const PhoneResendVerificationFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class PhoneResendVerificationSuccess extends HomeState {
  const PhoneResendVerificationSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

///logout state
class LogoutLoading extends HomeState {}

class LogoutFailure extends HomeState {
  const LogoutFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class LogoutSuccess extends HomeState {
  const LogoutSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class InitiatePurchaseLoading extends HomeState {}

class InitiatePurchaseFailure extends HomeState {
  const InitiatePurchaseFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class InitiatePurchaseSuccess extends HomeState {
  const InitiatePurchaseSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class NegotiateToolLoading extends HomeState {}

class NegotiateToolFailure extends HomeState {
  const NegotiateToolFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class NegotiateToolSuccess extends HomeState {
  const NegotiateToolSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
