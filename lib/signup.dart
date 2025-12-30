import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false; // For showing a loading indicator

  // Signup function
  Future<void> submitForm() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    setState(() {
  _isLoading = true;
});

try {
  // Check if email is already registered
  List<String> signInMethods = await FirebaseAuth.instance
      .fetchSignInMethodsForEmail(emailController.text.trim());

  if (signInMethods.isNotEmpty) {
    // Email already exists
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Email is already registered!")),
    );
    return; // Stop execution
  }

  // Email not in use, create user
  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

  // Update display name
  await userCredential.user
      ?.updateDisplayName(usernameController.text.trim());

  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account created successfully!")));

  // Navigate to login page or home page
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
} on FirebaseAuthException catch (e) {
  String message = "Signup failed";
  if (e.code == 'weak-password') {
    message = "Password is too weak";
  } else if (e.code == 'email-already-in-use') {
    message = "Email already in use";
  }
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
} catch (e) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Error: $e")));
} finally {
  setState(() {
    _isLoading = false;
  });
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Face book",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Create your account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            _buildInput("Username", usernameController),
            _gap(),
            _buildInput("Email", emailController,
                keyboard: TextInputType.emailAddress),
            _gap(),
            _buildInput("Full Name", nameController),
            _gap(),
            _buildInput("Password", passwordController, isPassword: true),
            _gap(),
            _buildInput("Confirm Password", confirmPasswordController,
                isPassword: true),
            const SizedBox(height: 25),

            // SIGNUP BUTTON
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Input Builder Widget
  Widget _buildInput(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF5F6F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      ),
    );
  }

  SizedBox _gap() => const SizedBox(height: 12);
}

/*
firebase 
Email AUTh
dependeciecs
   firebaseCore
   firebase Auth

Main 
widget flutterBindings =.ensureInitialized(); initolizing firbase engine 
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
register  or signup storing user data in firebase database 
 await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(), for singup
      username : usernameController.text.trim(),
    );

login it async function because it take time to connect to firebase server

  Future<void> loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      print("Login Success");
    } catch (e) {
      print("Login Failed: $e");
    }
  }

logout async function
 Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
    print("User Logged Out");
  } 
  

  // login by google account 
  dependices
     firebase_core:
     firebase_auth:
    google_sign_in:
  Futurrre <userCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);or 
    firebaseAuth.instance.signInWithPopup(credential); 
  }
  what crush anlysis feature in firbase 
 
*/
