import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> flutterToast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.lighterGrey,
    textColor: AppColors.primary,
    fontSize: 16.0,
  );
}
