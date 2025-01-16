import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resolve_app/services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final Map<String, String> _formData = {};
  bool _isLoading = false;
  String? _errorMessage;
  static const bool isProd = false; // set this to false for development env

  // function to Check network connectivity (prod)
  Future<bool> _isNetworkConnected() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));

      // If the response status is OK, then internet is available
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  bool passwordsMatch(Map<String, String> formData) {
    return formData['password']?.isNotEmpty == true &&
        formData['confirmPassword']?.isNotEmpty == true &&
        formData['password'] == formData['confirmPassword'];
  }

  void _register(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Check network connectivity: comment this block if you used dev `_baseUrl`
    final isConnected = await _isNetworkConnected();
    if (!isConnected && context.mounted && isProd) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text("No internet connection. Please check your network."),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 5),
        ),
      );
      return;
    }
    // END Check network connectivity

    // Attempt register
    final result = await _authService.register(_formData);

    setState(() {
      _isLoading = false;
    });

    if (result['success'] && context.mounted) {
      Navigator.pushReplacementNamed(context, '/login'); // Navigate to Login
    } else {
      setState(() {
        _errorMessage = result['message'];
      });

      // Show the error message in a SnackBar
      if (_errorMessage != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F41BB),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Create an account to collaborate on solving real-world challenges with innovative tech solutions.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => _formData['firstName'] = value,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) => _formData['lastName'] = value,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) => _formData['email'] = value,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) => _formData['phone'] = value,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) => _formData['username'] = value,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) => _formData['password'] = value,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) =>
                          _formData['confirmPassword'] = value,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // All fields are valid
                                if (_formKey.currentState!.validate()) {
                                  // check if passwords match
                                  if (passwordsMatch(_formData)) {
                                    _register(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Passwords do not match'),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1F41BB),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        // Navigate to the registration screen
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Already have an account? Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF494949),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Or continue with',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F41BB),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Social Media Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google Icon
                        Container(
                          width: 60,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFECECEC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(Icons.g_mobiledata_outlined, size: 40),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Facebook Icon
                        Container(
                          width: 60,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFECECEC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(Icons.facebook, size: 30),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Apple Icon
                        Container(
                          width: 60,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFECECEC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(Icons.apple, size: 30),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
