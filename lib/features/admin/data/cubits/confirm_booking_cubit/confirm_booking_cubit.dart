import 'package:alharamin_app/features/admin/data/models/payment_model.dart';
import 'package:alharamin_app/features/admin/data/repository/confrim_booking_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'confirm_booking_state.dart';

class ConfirmBookingCubit extends Cubit<ConfirmBookingState> {
  ConfirmBookingCubit(this._bookingRepository) : super(ConfirmBookingInitial());
  final IConfirmBookingRepository _bookingRepository;

  Future<void> confirmBooking({required String id}) async {
    emit(ConfirmBookingLoading());

    final result = await _bookingRepository.confirmBooking(id: id);

    result.fold(
      (left) => emit(ConfirmBookingFailure(message: left.message)),
      (right) => emit(ConfirmBookingConfirmed()),
    );
  }

  Future<void> deleteBooking({required String id}) async {
    emit(ConfirmBookingLoading());

    final result = await _bookingRepository.deleteBooking(id: id);

    result.fold(
      (left) => emit(ConfirmBookingFailure(message: left.message)),
      (right) => emit(ConfirmBookingDeleted()),
    );
  }

  Future<List<PaymentModel>> fetchBooking() async {
    emit(ConfirmBookingLoading());

    final result = await _bookingRepository.fetchBooking();

    return result.fold(
      (left) {
        emit(ConfirmBookingFailure(message: left.message));
        return [];
      },

      (right) {
        emit(ConfirmBookingSuccess(bookings: right));
        return right;
      },
    );
  }
}
