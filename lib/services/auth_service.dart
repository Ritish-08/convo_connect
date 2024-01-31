import 'package:convo_connect/helper/helper_function.dart';
import 'package:convo_connect/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login
  Future loginWithUserNameandPassword(String email, String password) async{
    try{
      User? user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
      if(user != null){
        //nothing to save here in database as already saved
        return true;
      }
    }
    on FirebaseAuthException catch(e){
      print(e);
      return e;
    }
  }


  //Register
  Future registerUserWithEmailandPassword(String fullName, String email, String password) async{
    try{
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user; //yahan se uid generate hogei
      if(user != null){
        //call database service to update user data
      await DatabaseService(uid: user.uid).savingUserData(fullName, email);
      return true;
      }
    }
    on FirebaseAuthException catch(e){
      print(e);
      return e;
    }
  }


  //signout
 Future signOut() async{
    try{
      await HelperFunctions.saveUserLoggenInStatus(false);
      await HelperFunctions.saveUserEmailSF('');
      await HelperFunctions.saveUserNameSF('');
      await firebaseAuth.signOut();
    }
    catch(e){
      return null;
    }
 }
}
