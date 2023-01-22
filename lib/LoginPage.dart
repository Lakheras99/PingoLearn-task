import 'package:flutter/material.dart';
import 'package:pingolearn/SignupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _email, _password;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: h * 0.1, right: w * 0.75),
              child: Text("e-Shop"),
            ),
            SizedBox(
              height: h * 0.15,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) => _name = value,
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !(value?.contains('@') ?? false)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value,
                    ),
                    SizedBox(height: h * 0.25),
                    ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          print(
                              'Name: $_name, Email: $_email, Password: $_password');
                          // Add your desired action here, such as sending the form data to a server
                        }
                      },
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? '),
                          InkWell(child: Text('  Login'),onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                          },)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
