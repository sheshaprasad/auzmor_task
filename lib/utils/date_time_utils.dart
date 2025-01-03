import 'package:intl/intl.dart';


///Date Time Utilities
class DateTimeUtil{

  ///We're formatting the From and To Date to Design Format using the Intl Package
  /// For List Tile
  static formatTrainingDate(from, to){
    final month = DateFormat('MMM').format(from);
    final startDay = DateFormat('dd').format(from);
    final endDay = DateFormat('dd').format(to);
    final year = DateFormat('yyyy').format(from);
    return "$month $startDay - $endDay,\n$year";
  }

  ///We're formatting the From and To Date to Design Format using the Intl Package
  /// For Carousel Slider
  static formatTrainingDateForSlider(from, to){
    final startMonth = DateFormat('MMM').format(from);
    final startDay = DateFormat('dd').format(from);
    final endMonth = DateFormat('MMM').format(to);
    final endDay = DateFormat('dd').format(to);
    return "$startDay $startMonth - $endDay $endMonth";
  }

  /// Since it will be a event of multiple days we are giving fixed time
  /// for the event it can be altered while using the [time] parameter
  static eventTime({time = "08:30 AM - 12:30 PM"}){
    return time;
  }
}