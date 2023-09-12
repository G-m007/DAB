import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage() ,
    
    
    
    
     );
 
  }
}


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

   Future<FirebaseApp>_initializeFirebase() async{
    FirebaseApp firebaseApp=await Firebase.initializeApp();
    return firebaseApp; 
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      future:  _initializeFirebase(),
      builder:  (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          return LoginScreen();
        }
        return const Center(child: CircularProgressIndicator(),
        );
      }
    ) ,
      ) ;
  }
}




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Login Func
  static Future<User?> loginUsingEmailPassword({required String email,required String password,required BuildContext context})async{
  FirebaseAuth auth= FirebaseAuth.instance;
  User? user;
  try{
    UserCredential userCredential= await auth.signInWithEmailAndPassword(email: email, password: password);
    user=userCredential.user;
    
  } on FirebaseAuthException catch (e){
    if(e.code=='User-not-found'){
      print("No user found for that email"); 
    }
  }
  return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController=TextEditingController();
    TextEditingController _passwordController=TextEditingController(); 
    return Padding(padding:EdgeInsets.all(16.0),
    child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.start,
       children:[
        const Text(
          "Donate A Bite",
          style: TextStyle(
            color: Colors.black,
            fontSize:28.0,
            fontWeight: FontWeight.bold,
             
          ),
        ),
        const Text(
          "Login",
          style: TextStyle(
            color: Colors.red,
            fontSize: 44.0,
            fontWeight: FontWeight.bold
            
            
            ),
          ),
          const SizedBox(height: 44.0,
          
          
           ),
            TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress ,
            decoration: InputDecoration(
              hintText: "Email ID ",
              prefixIcon: Icon(Icons.mail,color: Colors.black,),
            ),
           ),
            const SizedBox(
            height: 26.0,
            ),
             TextField(
              controller:  _passwordController,
              obscureText: true,
              decoration:const InputDecoration(
              hintText: "Password ",
              prefixIcon: Icon(Icons.lock,color: Colors.black,)
              ), 
            ),
            const SizedBox(height: 22.0,
            ),
      
            const Text("Forgot Password",style: TextStyle(color: Colors.blue),
            
            ),
            const SizedBox(height: 88.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                onPressed: ()async {
                  User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                  print(user);
                  if(user!=null){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ProfileScreen()));
                  }

                },
                child: const Text("Login ",
                style: TextStyle(color: Colors.white,
                fontSize: 18.0,

                ),
                ),
                ),

                
                ),
            
      

        ],
         
    ),
    
    
    );
  }
} 