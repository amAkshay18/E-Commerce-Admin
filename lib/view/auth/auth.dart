import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firebase = FirebaseAuth.instance;

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  var _email = '';
  var _password = '';
  var _isAuthenticating = false;
  void _submit() async {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }
    _formKey.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        // ignore: unused_local_variable
        final userCredential = await firebase.signInWithEmailAndPassword(
            email: _email, password: _password);
      } else {
        final userCredential = await firebase.createUserWithEmailAndPassword(
            email: _email, password: _password);
        // ignore: avoid_print
        print('sdsadfsd $userCredential');
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).clearSnackBars();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed'),
          ),
        );
      } else if (error.code == 'invalid-email') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).clearSnackBars();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'LeafLoom',
              style: TextStyle(
                color: Colors.green,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            const Text(
              'Welcome! Please Log-in or Sign-up to continue',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      !value.contains('@') ||
                      value.trim().isEmpty) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
            ),
            // const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                textCapitalization: TextCapitalization.none,
                obscureText: true,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
            ),
            // const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(double.infinity, 55),
                ),
                child: Text(_isLogin ? 'Log in' : 'Sign up'),
              ),
            ),
            if (!_isAuthenticating)
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin ? 'Create Account' : 'I already have an account',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
