class userss{
  static const String COLLECTION_NAME='users';
  String id;
  String username;
  String email;
  userss({required this.email,required this.id,required this.username});
  userss.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    username: json['username']! as String,
    email: json['email']! as String,
  );
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email
    };
  }
}