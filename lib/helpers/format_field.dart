import 'package:intl/intl.dart';

String getSanitizedText(String text) {
  return text.replaceAll(RegExp(r'[^\d]'), '');
}

String numToString(num number) {
  return NumberFormat('###,###.00', 'pt-br')
      .format(double.parse(number.toStringAsFixed(2)));
}

String dateToString(DateTime datetime) {
  return DateFormat('dd/mm/YYYY HH:mm', 'pt-br').format(datetime);
}
