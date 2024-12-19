import 'package:atlascan_flutter/screens/login_screen.dart';
import 'package:atlascan_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers for the input fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Service instance for user registration
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    // Dispose controllers when the screen is disposed
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Function to handle the form submission
  void _handleRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      // Passwords do not match
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    Map<String, dynamic> registerData = {
      "username": _fullNameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
    };

    String result = await _authService.registerUser(registerData);

    // Handle response
    if (result == 'User registered successfully') {
      // If registration was successful, navigate to another screen (e.g., login)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      // If registration failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              _buildHeader(),
              SizedBox(height: 40),
              _buildInputField('Full Name', controller: _fullNameController),
              SizedBox(height: 20),
              _buildInputField('Email', controller: _emailController),
              SizedBox(height: 20),
              _buildInputField('Password', controller: _passwordController, obscureText: true),
              SizedBox(height: 20),
              _buildInputField('Confirm Password', controller: _confirmPasswordController, obscureText: true),
              SizedBox(height: 50),
              _buildSignUpButton(context),
              SizedBox(height: 30),
              _buildSignInOption(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Create Account',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F41BB),
            ),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            'Create an account so you can explore all the\nfeatures',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, {bool obscureText = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Color(0xFFF1F4FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF1F41BB), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1F41BB),
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: _handleRegister,
        child: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInOption(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text(
              ' Sign in',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F41BB),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
