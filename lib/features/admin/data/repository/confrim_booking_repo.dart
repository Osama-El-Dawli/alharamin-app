import 'package:alharamin_app/core/error/failure.dart';
import 'package:alharamin_app/features/admin/data/models/payment_model.dart';
import 'package:dartz/dartz.dart';

abstract class IConfirmBookingRepository {
  Future<Either<Failure, void>> confirmBooking({required String id});
  Future<Either<Failure, List<PaymentModel>>> fetchBooking();
  Future<Either<Failure, void>> deleteBooking({required String id});
}
