import 'package:chat_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

 CollectionReference<userss> get_user_ref_with_converter(){
 return FirebaseFirestore.instance.collection(userss.COLLECTION_NAME).withConverter<userss>(
    fromFirestore: (snapshot, _) => userss.fromJson(snapshot.data()!),
    toFirestore: (userss, _) => userss.toJson(),
  );
}