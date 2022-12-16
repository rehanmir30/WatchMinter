class WatchHistoryModel {
  var ownerId, buyerId, time;

  WatchHistoryModel({this.ownerId, this.buyerId, this.time});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["ownerId"] = ownerId;
    map["buyerId"] = buyerId;
    map["time"] = time;
    return map;
  }
}
