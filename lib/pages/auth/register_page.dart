import 'package:convo_connect/helper/helper_function.dart';
import 'package:convo_connect/pages/auth/login_page.dart';
import 'package:convo_connect/pages/home_page.dart';
import 'package:convo_connect/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:convo_connect/widgets/widgets.dart';
import 'package:convo_connect/shared/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email ='';
  String password ='';
  String fullName ='';
  AuthService authSerivce = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading? Center(child: CircularProgressIndicator(color: Constants.primaryColor,)) : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ConvoConnect',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.teal),
                ),
                SizedBox(height: 10),
                Text('Create your account now to chat and explore',
                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                Image.asset('images/register.png'),
                TextFormField(
                  onChanged: (value){
                    setState(() {
                      fullName = value;
                    });
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Full Name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Constants.primaryColor,
                    ),
                  ),
                   validator: (val){
                    if(val!.isNotEmpty){
                      return null;
                    }
                    else{
                      return 'Name cannot be empty';
                    }
                  },
                ),
                SizedBox(height: 8,),
                TextFormField(
                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Constants.primaryColor,
                    ),
                  ),
                  //check the validation
                  validator: (val){
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : 'Please enter a valid Email';

                    //.hasMatch(val!) return true or false
                  },
                ),
                SizedBox(height: 8,),
                TextFormField(
                  obscureText: true,
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },
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
                ),
                SizedBox(height:20),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Constants.primaryColor),
                    onPressed:(){
                      register();
                    },
                    child: Text('Register',style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        nextScreen(context, LoginPage());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Login  now',
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
  register() async{
    if(formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authSerivce.registerUserWithEmailandPassword(fullName, email, password).then((value) async{
        if(value == true){
         // saving shared preference state
          await HelperFunctions.saveUserLoggenInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          //yahan pe replace because vaapis register pe thodei bhejna
          nextScreenReplace(context, HomePage());
        }
        //agar email password vala authentication band hai ya humne nahi chose kiya
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
