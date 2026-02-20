import 'package:intl/intl.dart';

String formatRupiah(int number) {
  return NumberFormat.decimalPattern('id').format(number);
}
