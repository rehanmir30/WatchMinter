class Message {
  Message({
    required this.senderId,
    required this.receiverId,
    required this.time,
    required this.message,
    required this.username,
  });
  late final String senderId;
  late final String receiverId;
  late final String message;
  late final String time;
  late final String username;

  Message.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'].toString();
    receiverId = json['receiverId'].toString();
    time = json['time'].toString();
    message = json['message'].toString();
    username = json['username'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['time'] = time;
    data['message'] = message;
    data['username'] = username;
    return data;
  }
}
