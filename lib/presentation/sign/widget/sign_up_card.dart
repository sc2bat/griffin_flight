import 'package:flutter/material.dart';
import 'package:griffin/utils/simple_logger.dart';

class SignUpCard extends StatefulWidget {
  const SignUpCard({super.key});

  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _isEmailValid = false;
  bool _isUsernameValid = false;
  bool _isPasswordValid = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordValid = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _isEmailValid ? null : 'Invalid email',
                ),
                onChanged: (value) {
                  setState(() {
                    _isEmailValid = _validateEmail(value);
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  errorText: _isUsernameValid ? null : 'Invalid username',
                ),
                onChanged: (value) {
                  setState(() {
                    _isUsernameValid = _validateUsername(value);
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _isPasswordValid ? null : 'Invalid password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    logger.info(_isPasswordValid);
                    _isPasswordValid = _validatePassword(value);
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password confirm',
                  errorText:
                      _isConfirmPasswordValid ? null : 'Passwords do not match',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _isConfirmPasswordValid =
                        _passwordMatch(value, _passwordController.text);
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle signup logic here
                },
                child: const Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateEmail(String email) {
    return email.isNotEmpty;
  }

  bool _validateUsername(String username) {
    return username.isNotEmpty;
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty &&
        password.length >= 8 &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  bool _passwordMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
