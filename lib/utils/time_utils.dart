import 'package:date_format/date_format.dart';

class TimeUtils {
  static String formatDateMy({required DateTime date}) {
    return formatDate(date, [yyyy, '年', mm, '月', dd, '日', ' ', HH, ':', nn, ':', ss]);
  }
}
