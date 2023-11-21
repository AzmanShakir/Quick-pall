import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/pages/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/Validations.dart';
import 'package:quick_pall_local_repo/controllers/accountController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import '/Widgets/Buttons.dart';
import 'package:get/get.dart';
import 'package:quick_pall_local_repo/pages/Sign-UpScreen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  var _email;

  var _password;
  String? emailValidationResult;
  bool isObsecure = true;
  void validateEmail(String value) {
    print(value);
    if (value.isEmpty) {
      emailValidationResult = 'Please enter an email';
    } else {
      if (!Validations.isValidEmail(value)) {
        emailValidationResult = 'Email is not in the correct format';
      }
    }
    emailValidationResult = null;
  }

  bool _isCheckedRememberMe = false;

  void _handleRememberMeCheckbox(bool value) {
    setState(() {
      _isCheckedRememberMe = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          leading: BackButton(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, left: 20, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Welcome back",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.waving_hand,
                          color: Colors.green,
                          size: 40,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Please enter your email & password to sign in",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        )),
                    SizedBox(height: 30),
                    Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 400,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value != null && value is String) {
                                    String v = value;
                                    validateEmail(value);
                                    return emailValidationResult;
                                  }
                                  //
                                },
                                onSaved: (value) {
                                  _email = value;
                                },
                                cursorColor: Colors.green,
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    prefixIcon:
                                        Icon(Icons.email, color: Colors.green),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                              SizedBox(height: 40),
                              TextFormField(
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _password = value;
                                },
                                obscureText: isObsecure,
                                cursorColor: Colors.green,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          isObsecure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isObsecure
                                                ? isObsecure = false
                                                : isObsecure = true;
                                          });
                                        }),
                                    hintText: "Password",
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.green),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.black,
                          activeColor: Colors.green,
                          value: _isCheckedRememberMe,
                          onChanged: (value) {
                            if (value != null) {
                              _handleRememberMeCheckbox(value);
                            }
                          },
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Remember me",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.green[900],
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center the content horizontally
                        children: [
                          Center(
                            child: Text(
                              "Don't have an account?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          TextButton(
                            child: Text(
                              "Sign up?",
                              style: TextStyle(
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Get.to(SignUp_EmailPasswordScreen(),
                                  transition: Transition.rightToLeft,
                                  duration: Duration(milliseconds: 500));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Widget_ElevatedButton(
                      text: "Sign in",
                      textColor: Colors.black,
                      backGroundColor: Colors.green,
                      borderColor: Colors.white,
                      callBack: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          // loading while async function exec
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  height: 200,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: Colors.green,
                                      ),
                                      SizedBox(height: 16.0),
                                      Text("Signing in..."),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          AccountHolder? user;
                          user =
                              await AccountController.SignIn(_email, _password);
                          if (user == null) {
                            Navigator.of(context).pop();
                            showDialog(
                              // barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 200,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 80,
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.black,
                                              size: 70,
                                            )),
                                        SizedBox(height: 16.0),
                                        Text("Invalid Credentials"),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            if (_isCheckedRememberMe) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('Email', user.Email);
                              prefs.setString('Password', user.Password);
                              print("Remember Me checked");
                            }
                            Navigator.of(context).pop();
                            Get.offAll(
                                HomeScreen(
                                  user: user,
                                ),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 500));
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
