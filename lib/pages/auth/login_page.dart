import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convo_connect/pages/home_page.dart';
import 'package:convo_connect/pages/auth/register_page.dart';
import 'package:convo_connect/services/database_service.dart';
import 'package:convo_connect/shared/constants.dart';
import 'package:convo_connect/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helper/helper_function.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();//instance of form
  String email ='';
  String password ='';
  AuthService authSerivce = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_isLoading ? Center(child: CircularProgressIndicator(color: Constants.primaryColor,)) :SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,//har ek entry ke liye ek alag object bann rha hai formkey mein store hoke aage access krne ke liye
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ConvoConnect',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.teal),
                ),
                SizedBox(height: 10),
                Text('Login now to see what they are talking!',
                style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                Image.asset('images/login.png'),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Constants.primaryColor,
                    ),
                  ),
                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },
                  //check the validation
                  validator: (val){
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : 'Please enter a valid Email';

                    //.hasMatch(val!) return true or false
                  },
                ),
                SizedBox(height: 8,),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Constants.primaryColor,
                    ),
                  ),
                  validator: (val){
                    if (val!.length < 6) {
                      return "Password must be at least 6 characters";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(height:20),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Constants.primaryColor),
                      onPressed:(){
                      login();
                     },
                      child: Text('Sign In',style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an Account? '),
                    SizedBox(width: 5,),
                    GestureDetector(
                          onTap: (){
                            nextScreen(context, RegisterPage());
                          },
                        child: RichText(
                          text: TextSpan(
                            text: 'Register here',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  login() async{
    if(formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authSerivce.loginWithUserNameandPassword(email, password).then((value) async{
        if(value == true){
          //saving shared preference state
          QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);
          //saving values to our shared prefrences
          await HelperFunctions.saveUserLoggenInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          nextScreenReplace(context, HomePage());
        }
        else{
          showSnackbar(context,Colors.red,value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
