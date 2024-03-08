import 'package:flutter/material.dart';
import 'package:griffin/utils/simple_logger.dart';

class SignInCard extends StatefulWidget {
  const SignInCard({
    super.key,
    required this.signInFunction,
    required this.isLoading,
  });
  final Function(String userName, String password) signInFunction;
  final bool isLoading;

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
                    _isButtonClicked = _isUsernameValid && _isPasswordValid;
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
                    _isPasswordValid = _validatePassword(value);
                    _isButtonClicked = _isUsernameValid && _isPasswordValid;
                    logger.info(_isButtonClicked);
                  });
                },
              ),
              const SizedBox(height: 20),
              widget.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        if (_isButtonClicked) {
                          await widget.signInFunction(
                            _usernameController.text,
                            _passwordController.text,
                          );
                          setState(() {
                            _isButtonClicked = false;
                            _passwordController.text = '';
                          });
                          // context.go('/splash');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.black54;
                            }
                            return _isButtonClicked
                                ? Colors.blue
                                : Colors.black54;
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
    return password.isNotEmpty;
  }
}
