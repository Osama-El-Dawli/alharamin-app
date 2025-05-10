import 'dart:io' as io;

import 'package:alharamin_app/features/admin/data/models/payment_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

part 'download_payment_state.dart';

class DownloadPaymentCubit extends Cubit<DownloadPaymentState> {
  DownloadPaymentCubit() : super(DownloadPaymentInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> exportAndClearPayments() async {
    emit(DownloadPaymentLoading());

    try {
      final snapshot = await _firestore.collection('payments').get();
      final payments =
          snapshot.docs.map((doc) => PaymentModel.fromFirestore(doc)).toList();

      if (payments.isEmpty) {
        emit(DownloadPaymentFailure(message: 'No payments available'));
        return;
      }

      final excel = Excel.createExcel();
      final sheet = excel['Payments'];

      sheet.appendRow([
        TextCellValue('Patient Name'),
        TextCellValue('Patient Phone'),
        TextCellValue('Doctor Name'),
        TextCellValue('Speciality'),
        TextCellValue('Date'),
        TextCellValue('Time'),
        TextCellValue('Price (EGP)'),
      ]);

      int totalPrice = 0;

      for (final payment in payments) {
        totalPrice += payment.price;

        sheet.appendRow([
          TextCellValue(payment.patientName),
          TextCellValue(payment.patientPhone),
          TextCellValue(payment.doctorName),
          TextCellValue(payment.doctorSpeciality),
          TextCellValue(DateFormat('dd-MM-yyyy').format(payment.date)),
          TextCellValue(payment.time),
          TextCellValue(payment.price.toString()),
        ]);
      }

      sheet.appendRow([
        TextCellValue(''),
        TextCellValue(''),
        TextCellValue(''),
        TextCellValue(''),
        TextCellValue(''),
        TextCellValue('Total Price'),
        TextCellValue(totalPrice.toString()),
      ]);

      final excelBytes = excel.encode();
      if (excelBytes == null) {
        emit(DownloadPaymentFailure(message: 'Failed to generate Excel file'));
        return;
      }

      final fileName =
          'Payments_${DateFormat('dd-MM-yyyy').format(DateTime.now())}.xlsx';

      if (kIsWeb) {
        final blob = html.Blob([
          excelBytes,
        ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

        final url = html.Url.createObjectUrlFromBlob(blob);

        html.AnchorElement(href: url)
          ..setAttribute('download', fileName)
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        final directory = await getDownloadsDirectory();
        if (directory == null) {
          emit(
            DownloadPaymentFailure(message: 'Cannot access downloads folder'),
          );
          return;
        }

        final file = io.File('${directory.path}/$fileName');
        await file.writeAsBytes(excelBytes);
      }

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      emit(DownloadPaymentSuccess());
    } catch (e) {
      emit(DownloadPaymentFailure(message: 'Error: ${e.toString()}'));
    }
  }
}
