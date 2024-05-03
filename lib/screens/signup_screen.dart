import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController=TextEditingController(); 
  final _passwordController=TextEditingController();
  final _confirmpasswordController=TextEditingController();
  Future signUp() async {
    if(passwordConfirmed()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
    } 
  }
  bool passwordConfirmed(){
    if(_passwordController.text.trim()==_confirmpasswordController.text.trim()){
      return true;
    }
    else{
      return false;
    }
  }

 
  void openSignINScreen(){
    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginScreen()),
                );
  }

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
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
                  'SIGN UP',
                  style: GoogleFonts.robotoCondensed(fontSize: 18,
                  fontWeight:FontWeight.bold
                  )
                ),
                //subtitle
                 Text(
                  'Welcome! Here you can sign up :-)',
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
                 SizedBox(height: 10,),
                //confirmpasswordtextfield
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
                        controller:_confirmpasswordController,
                        obscureText: true,
                        decoration: InputDecoration(border: InputBorder.none , hintText: 'Confirm Password'),
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 15,),
                //signinbutton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signUp,  
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Color.fromARGB(255, 151, 53, 38) , borderRadius: BorderRadius.circular(12)),
                      child:  Center(child: 
                      Text(
                        'Sign up', 
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
                    Text('Already a member?',
                     style: GoogleFonts.robotoCondensed(
                    
                      fontWeight:FontWeight.bold,
                    ),),
                    GestureDetector(
                      onTap: openSignINScreen,
                      child: Text(' Sign In Here',
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