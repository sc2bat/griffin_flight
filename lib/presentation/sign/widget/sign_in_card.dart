import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInCard extends StatefulWidget {
  const SignInCard({
    super.key,
    required this.signInFunction,
  });
  final Function(String userName, String password) signInFunction;

  @override
  State<SignInCard> createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  bool _isUsernameValid = false;
  bool _isPasswordValid = false;
  bool _isPasswordVisible = false;
  bool _isButtonClicked = false;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
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
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  errorText: _isUsernameValid ? null : 'Invalid username',
                ),
                onChanged: (value) {
                  setState(() {
                    _isUsernameValid = _validateUsername(value);
                    _isButtonClicked = false;
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
                    _isButtonClicked = false;
                    _isPasswordValid = _validatePassword(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonClicked
                    ? null
                    : () {
                        if (_isUsernameValid && _isPasswordValid) {
                          widget.signInFunction(
                            _usernameController.text,
                            _passwordController.text,
                          );
                          setState(() {
                            _isButtonClicked = true;
                            _usernameController.text = '';
                            _passwordController.text = '';
                          });
                          context.go('/splash');
                        }
                      },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.black54;
                      }
                      return Colors.blue;
                    },
                  ),
                ),
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
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
}
