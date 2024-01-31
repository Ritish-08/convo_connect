import 'package:convo_connect/pages/home_page.dart';
import 'package:convo_connect/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:convo_connect/shared/constants.dart';
import '../widgets/widgets.dart';
import 'auth/login_page.dart';
class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({super.key, required this.email, required this.userName});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set your desired color for the drawer icon
        ),
        backgroundColor: Constants.primaryColor,
        title: Text('Profile', style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      drawer:SafeArea(
        child: Drawer(
          child: ListView(
            //padding: EdgeInsets.symmetric(vertical: 4000),
            children: [
              Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.grey[700],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.userName,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Divider(
                height: 2,
              ),
              ListTile(
                onTap: () {
                  nextScreen(context, HomePage());
                },
                selected: true,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                leading: Icon(Icons.group),
                title: Text(
                  'Groups',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {
                },
                selected: true,
                selectedColor: Constants.primaryColor,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                leading: Icon(Icons.group),
                title: Text(
                  'Profile',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Logout'),
                          content: Text('Are you Sure you want to logout.'),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () async{
                                await authService.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context)=>LoginPage()),
                                        (route)=>false);
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        );
                      });
                },
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.account_circle, size: 200, color: Colors.grey[700],),
            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Full Name-', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                Text(widget.userName, style: TextStyle(fontSize: 15,color: Colors.black),),
              ],
            ),
            Divider(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text('Email-', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                Flexible(child: Text(widget.email, style: TextStyle(fontSize: 15),)),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
