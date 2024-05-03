import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/screens/menukids.dart';
import 'package:untitled3/screens/signup_screen.dart';




class LoginKid extends StatefulWidget {
  const LoginKid({Key? key});

  @override
  State<LoginKid> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginKid> {
  final _emailController=TextEditingController(); 
  final _passwordController=TextEditingController();
  final _firestore=FirebaseFirestore.instance;
   String? name;
  Future signIn() async {
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('children')
      .where('enfant', isEqualTo: name)
      .get();
       if (querySnapshot.docs.isNotEmpty) {
    // L'utilisateur est déjà présent dans la base de données
     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
    print('L\'utilisateur existe déjà dans la base de données.');
   
  }else {
   
    print('Utilisateur nexiste pas dans  la base de données.');
  }
     
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
                       onChanged: (value){
               name=value;
              },
                        decoration: InputDecoration(border: InputBorder.none , hintText: 'Name',),
                        
                      ),
                    ),
                  ),
                ),
                  SizedBox(height: 10,),
                
                 
             
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
                
                
                
              ]
            ),
          ),
        ),
      ),
    );
  }
}