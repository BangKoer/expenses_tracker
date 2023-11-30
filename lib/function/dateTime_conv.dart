// Convert DateTime obj to a string yyyymmdd
String convertDateTimeToString(DateTime dateTime) {
  // year in yyyy format
  String year = dateTime.year.toString();

  // month in mm format
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0' + month;
  }

  // Day in dd format
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0' + day;
  }

  return year + month + day;
}
