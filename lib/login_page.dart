import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_app/auth_services.dart';
import 'package:fun_app/home_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _myFormKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _showPassword = false;

  void clearTextInput() {
    _emailController.clear();
    _passwordController.clear();
  }

  void showSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Login Successful'),
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment(0.0, 1.0),
                      children: [
                        Container(
                          child: Image(
                            image: AssetImage(
                              'assets/images/wallpaper10.jpg',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 170.0, bottom: 10.0),
                          child: Text('Access your\nHealth Information',
                            style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _myFormKey,
                      child: Container(
                        child: Column(
                          children: [
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'ENTER EMAIL',
                                labelText: 'EMAIL',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              validator: (value) {
                                if(value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                return null;
                              },
                              cursorColor: Colors.black54,
                            ),
                            SizedBox(height: 12.0),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  hintText: 'ENTER PASSWORD',
                                  labelText: 'PASSWORD',
                                  prefixIcon: Icon(Icons.lock_outlined),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    child: Icon(
                                      _showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  )
                              ),
                              validator: (value) {
                                if(value.length < 6) {
                                  return 'Password must be more 6 characters';
                                }
                                return null;
                              },
                              obscureText: !_showPassword,
                              cursorColor: Theme.of(context).primaryColor,
                            ),
                            SizedBox(height: 25.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  splashColor: Theme.of(context).primaryColor,
                                  child: Text('FORGOT PASSWORD',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                                InkWell(
                                  splashColor: Theme.of(context).primaryColor,
                                  child: Text('LOGIN',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onTap: () {
                                    //showSnackBar(context);
                                    if(_myFormKey.currentState.validate()) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                                    }
                                    clearTextInput();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 25.0),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 45),
                                ),
                                onPressed: () async {
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  await AuthServices().signInWithGoogle().then((value) => () {
                                    print(value);
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                                  });
                                },
                                icon: FaIcon(FontAwesomeIcons.google, color: Colors.amber),
                                label: Text('Sign Up with Google',
                                  style: TextStyle(
                                      fontSize: 16.0
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: SvgPicture.asset('assets/images/icons9.svg', height: 18.0, width: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        child: Text(
                          'Health Information Technology',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text('Health is Wealth...',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Satisfy',
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.9,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
