

class Room{
  static const String COLLECTION_NAME='rooms';
  String id;
  String roomname;
  String description;
  String categroy;
  Room({required this.categroy,required this.id,required this.roomname,required this.description});
  Room.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    roomname: json['roomname']! as String,
    description: json['description']! as String,
    categroy: json['categroy']! as String,

  );
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'roomname': roomname,
      'description': description,
      'categroy': categroy,

    };
  }
}