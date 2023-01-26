import 'package:flutter/material.dart';

class MyDatUtil {
  //For getting formatted Time
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));

    return TimeOfDay.fromDateTime(date).format(context);
  }

  static String getLastMessageTime(
      {required BuildContext context, required String time}) {
    final list = time.split(" ");
    final DateTime now = DateTime.now();
    return '${list[0]} ';
  }

  //Get month name from month no. index
  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'N/A';
  }

  //Get last active Time
  static String getLastActiveTime({required BuildContext context, required String lastActive}){
    final int  i = int.parse(lastActive)??-1;
    //if time is not availabe return this below statement
    if(i==-1)return 'Last seen is not available';
    DateTime time= DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();
    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if(time.day ==now.day && time.month == now.month&&time.year==now.year){
      return 'Last seen today at ${formattedTime}';
    }
    if((now.difference(time).inHours/24).round()==1){
      return 'Last seen yesterday at ${formattedTime}';
    }
    String month = _getMonth(time);
    return 'Last seen on ${time.day} $month on $formattedTime';
  }
}
