import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/screens/home_screen.dart';
import 'package:untitled3/screens/signup_screen.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController=TextEditingController(); 
  final _passwordController=TextEditingController();
  Future signIn() async {
await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
             
  }
  void openSignupScreen(){
    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
  }
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                //image
                Image.asset(
                  'images/login.png',
                  height: 200,
                  ),
                 SizedBox(height: 20,),
                //title
                Text(
                  'SIGN IN',
                  style: GoogleFonts.robotoCondensed(fontSize: 18,
                  fontWeight:FontWeight.bold
                  )
                ),
                //subtitle
                 Text(
                  'Welcome back! Nice to see you again :-)',
                  style: GoogleFonts.robotoCondensed(fontSize: 18,
                  )
                ),
                 SizedBox(height: 50,),
                //emailtextfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                       color: Color.fromARGB(255, 243, 242, 242),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(border: InputBorder.none , hintText: 'Email',),
                        
                      ),
                    ),
                  ),
                ),
                  SizedBox(height: 10,),
                //passwordtextfield
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 242, 242),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller:_passwordController,
                        obscureText: true,
                        decoration: InputDecoration(border: InputBorder.none , hintText: 'Password'),
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 15,),
                //signinbutton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signIn,  
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Color.fromARGB(255, 151, 53, 38) , borderRadius: BorderRadius.circular(12)),
                      child:  Center(child: 
                      Text(
                        'Sign in', 
                        style: GoogleFonts.robotoCondensed(
                          color:Colors.white,
                          fontWeight:FontWeight.bold,
                          fontSize:18,
                        )
                        )),
                                
                    ),
                  ),
                ),
                 SizedBox(height: 25,),
                //textsignup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not yet a member?',
                     style: GoogleFonts.robotoCondensed(
                    
                      fontWeight:FontWeight.bold,
                    ),),
                    GestureDetector(
                      onTap: openSignupScreen,
                      child: Text(' Sign Up Now',
                      style: GoogleFonts.robotoCondensed(
                        color:Colors.green,
                        fontWeight:FontWeight.bold,
                      ),),
                    )
                  ],
                )
                
              ]
            ),
          ),
        ),
      ),
    );
  }
}