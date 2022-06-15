import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/room.dart';

 CollectionReference<userss> get_user_ref_with_converter(){
 return FirebaseFirestore.instance.collection(userss.COLLECTION_NAME).withConverter<userss>(
    fromFirestore: (snapshot, _) => userss.fromJson(snapshot.data()!),
    toFirestore: (userss, _) => userss.toJson(),
  );
}
CollectionReference<Room>get_room_ref_with_converter(){
   return FirebaseFirestore.instance.collection(Room.COLLECTION_NAME).withConverter<Room>(
       fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
  toFirestore: (room, _) => room.toJson());
}
CollectionReference<Message>get_message_ref_with_converter(String id){
  return get_room_ref_with_converter().doc(id).collection(Message.COLLECTION_NAME).withConverter<Message>(
      fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
      toFirestore: (message, _) => message.toJson());
}