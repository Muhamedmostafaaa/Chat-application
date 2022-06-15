
class Message{
  static const String COLLECTION_NAME='message';
  String id;
  String senderid;
  String content;
  int time;
  String sendername;
  Message({required this.senderid,required this.id,required this.content,required this.time,required this.sendername});
  Message.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    senderid: json['senderid']! as String,
    content: json['content']! as String,
    time: json['time']! as int,
    sendername: json['sendername']! as String,

  );
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'senderid': senderid,
      'content': content,
      'time': time,
      'sendername': sendername,


    };
  }
}