import 'package:atlascan_flutter/models/user.dart';
import 'package:atlascan_flutter/screens/register_screen.dart';
import 'package:atlascan_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();

  // Create TextEditingControllers to get the user input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(BuildContext context) async {
    // Get the text entered by the user
    String email = _emailController.text;
    String password = _passwordController.text;

    print(password);

    // Check if the input is valid
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Send login data
    Map<String, dynamic> loginData = {
      "email": email,
      "password": password,
    };

    try {
      User? req = await _authService.loginUser(loginData);
      if (req != null) {
        Navigator.pushNamed(
          context, '/scanredirect',
          arguments: req,
        );
      } else {
        // Failed login, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to login. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Error handling for the login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
              Center(
                child: Text(
                  'Login here',
                  style: TextStyle(
                    color: Color(0xFF2F4FCD),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Scan your documents fast and easy',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    _buildTextField('Email', _emailController),
                    SizedBox(height: 20),
                    _buildTextField('Password', _passwordController,
                        isPassword: true), // Pass true to obscure text
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          print('Forgot Password Clicked');
                        },
                        child: Text(
                          'Forgot your password?',
                          style: TextStyle(
                            color: Color(0xFF2F4FCD),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildSignInButton(context),
                    SizedBox(height: 20),
                    _buildCreateAccount(context),
                    SizedBox(height: 30),
                    _buildGoogleSignIn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText:
          isPassword, // This will obscure the text if it's a password field
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2F4FCD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => login(context), // Trigger the login process
        child: Text(
          'Sign in',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildCreateAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('New here?', style: TextStyle(color: Colors.black54)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: Text(
            ' Create Account',
            style: TextStyle(
              color: Color(0xFF2F4FCD),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleSignIn() {
    return Column(
      children: [
        Text(
          'Or continue with',
          style: TextStyle(color: Colors.black54),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            print('Google Sign-In Clicked');
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'G',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
