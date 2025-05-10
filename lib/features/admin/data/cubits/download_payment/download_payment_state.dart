part of 'download_payment_cubit.dart';

sealed class DownloadPaymentState extends Equatable {
  const DownloadPaymentState();

  @override
  List<Object> get props => [];
}

final class DownloadPaymentInitial extends DownloadPaymentState {}

final class DownloadPaymentLoading extends DownloadPaymentState {}

final class DownloadPaymentSuccess extends DownloadPaymentState {}

final class DownloadPaymentFailure extends DownloadPaymentState {
  final String message;
  const DownloadPaymentFailure({required this.message});
}
