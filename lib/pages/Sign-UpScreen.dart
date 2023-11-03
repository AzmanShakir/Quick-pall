import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_pall_local_repo/controllers/countryController.dart';
import '/utils/Validations.dart';
import '/Controllers/accountController.dart';
import '/utils/Toast.dart';
import '/utils/PickImage.dart';
import '/Widgets/Buttons.dart';
import 'package:get/get.dart';
import 'package:country_icons/country_icons.dart';
import '/models/Country.dart';
import '/models/AccountHolder.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

class SignUp_EmailPasswordScreen extends StatefulWidget {
  SignUp_EmailPasswordScreen({super.key});

  @override
  State<SignUp_EmailPasswordScreen> createState() =>
      _SignUp_EmailPasswordScreenState();
}

class _SignUp_EmailPasswordScreenState
    extends State<SignUp_EmailPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var _email;
  var _password;
  bool isObsecure = true;

  String? emailValidationResult;

  Future<void> validateEmail(String value) async {
    print(value);
    if (value.isEmpty) {
      emailValidationResult = 'Please enter an email';
    } else {
      if (!Validations.isValidEmail(value)) {
        emailValidationResult = 'Email is not in the correct format';
      } else {
        final documentData = await AccountController.getDocumentIfItExists(
            'AccountHolder', value);
        print(documentData);

        if (documentData != null && documentData is Map<String, dynamic>) {
          if (documentData["IsActive"] == true) {
            emailValidationResult = "This email is already in use";
          } else {
            emailValidationResult = null; // Valid email
          }
        } else {
          emailValidationResult = null; // Valid email
        }
      }
    }
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
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 20, right: 10),
        child: Column(children: [
          Row(
            children: [
              Text(
                "Create account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.account_box_rounded,
                color: Colors.green,
                size: 40,
              ),
            ],
          ),
          SizedBox(height: 30),
          SizedBox(
              width: double.infinity,
              child: Text(
                "Please enter your email & password to sign up",
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
//                         if (value != null && value.isEmpty) {
//                           return 'Please enter an email';
//                         } else {
//                           String v;

//                           if (value != null && value is String) {
//                             v = value;
//                             if (!Validations.isValidEmail(v)) {
//                               return "Email is not in correct format";
//                             }

// return await FutureBuilder<Map<String, dynamic>?>(
//           future: await AccountController.getDocumentIfItExists(
//                                       'AccountHolder', v),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator(); // You can display a loading indicator while waiting for the result.
//             } else if (snapshot.hasError) {
//               return Text("An error occurred: ${snapshot.error}");
//             } else if (snapshot.hasData) {
//               Map<String, dynamic>? doc = snapshot.data;
//               if (doc != null && doc is Map<String, dynamic>) {
//                 if (doc["IsActive"] == true) {
//                   return "This email is already in use";
//                 }
//               }
//             }
//             return null; // Valid email
//           },
//         );

//                             // Map<String, dynamic>? doc;
//                             // (() async {
//                             //   await AccountController.getDocumentIfItExists(
//                             //           'AccountHolder', v)
//                             //       .then((value) {
//                             //     doc = value;
//                             //     print("azan");
//                             //   });
//                             // })();

//                             // Map<String, dynamic>? doc = null;
//                             //   await  AccountController.getDocumentIfItExists(
//                             //             'AccountHolder', v)
//                             //         .then((value) {
//                             //   doc = value;
//                             //   print("azan");
//                             //   print(value);
//                             // });
//                             // print("Usman");
//                             // print(documentData);
//                             // doc = documentData as Map<String, dynamic>?;
//                             // print(doc);

//                             // if (doc != null && doc is Map<String, dynamic>) {
//                             //   if (doc!["IsActive"] == true) {
//                             //     return "This email is already in use";
//                             //   }
//                             //   // Document exists, and you can access its data in the 'documentData' variable
//                             // }
//                           }
//                           return null;
//                         }
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email, color: Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter a password';
                        } else {
                          String v;

                          if (value != null && value is String) {
                            v = value;
                            if (!Validations.isValidPassword(v)) {
                              return "Password must be 6 character long";
                            }
                          }
                          return null;
                        }
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
                          prefixIcon: Icon(Icons.lock, color: Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ],
                ),
              )),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Widget_ElevatedButton(
                        text: "SignUp",
                        textColor: Colors.black,
                        backGroundColor: Colors.green,
                        borderColor: Colors.white,
                        callBack: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SignUp_NameScreen(
                            //             email: _email, password: _password)));
                            Get.to(
                                SignUp_NameScreen(
                                    email: _email, password: _password),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 500));
                          }
                        },
                      ),
                    ),
                  )))
        ]),
      ),
    ));
  }
}

class SignUp_NameScreen extends StatefulWidget {
  var email, password;
  SignUp_NameScreen({super.key, required this.email, required this.password});

  @override
  State<SignUp_NameScreen> createState() => _SignUp_NameScreenState();
}

class _SignUp_NameScreenState extends State<SignUp_NameScreen> {
  // var email, password;
  // _SignUp_NameScreenState({this.email, this.password});
  final _formKey = GlobalKey<FormState>();
  var _name;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 250,
          height: 50,
          child: Center(
              child: LinearProgressIndicator(
            minHeight: 10,
            value: 0.5,
            backgroundColor: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          )),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 20, right: 10),
        child: Column(children: [
          Row(
            children: [
              Text(
                "What is your name?",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.person_4_rounded,
                color: Colors.green,
                size: 40,
              ),
            ],
          ),
          SizedBox(height: 30),
          SizedBox(
              width: double.infinity,
              child: Text(
                "Enter your full legal name.",
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
                        if (value != null && value.isEmpty) {
                          print(widget.email);
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value;
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          hintText: "Name",
                          prefixIcon:
                              Icon(Icons.abc_rounded, color: Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ],
                ),
              )),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Widget_ElevatedButton(
                        text: "Continue",
                        textColor: Colors.black,
                        backGroundColor: Colors.green,
                        borderColor: Colors.white,
                        callBack: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            Get.to(
                                SignUp_CountryAndPhone(
                                    email: widget.email,
                                    password: widget.password,
                                    name: _name),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 500));
                          }
                        },
                      ),
                    ),
                  )))
        ]),
      ),
    ));
  }
}

class SignUp_CountryAndPhone extends StatefulWidget {
  var email, password, name;
  SignUp_CountryAndPhone(
      {super.key,
      required this.email,
      required this.password,
      required this.name});

  @override
  State<SignUp_CountryAndPhone> createState() => _SignUp_CountryAndPhoneState();
}

class _SignUp_CountryAndPhoneState extends State<SignUp_CountryAndPhone> {
  final _formKey = GlobalKey<FormState>();
  var _phone;
  late Country _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 250,
          height: 50,
          child: Center(
              child: LinearProgressIndicator(
            minHeight: 10,
            value: 0.8,
            backgroundColor: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          )),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: StreamBuilder<List<Country>>(
          stream: CountryController.getCountries(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.green,
              )); // Show a loading indicator while waiting for data.
            } else if (snapshot.data == null) {
              return Center(
                child: Text(
                    'Sorry Database has no country information. Contact support'),
              );
            } else {
              List<Country> countries = snapshot.data ?? [];
              List<DropdownMenuItem<Country>> dropDownList = [];
              for (Country c in countries) {
                var d = DropdownMenuItem(
                  child: SizedBox(
                    height: 30,
                    width: 50,
                    child: new Image.asset(
                        'icons/flags/png/' + c.iconCode + ".png",
                        package: 'country_icons'),
                  ),
                  value: c,
                );
                dropDownList.add(d);
              }
              return PhoneInput(
                  dropDownList: dropDownList,
                  email: widget.email,
                  password: widget.password,
                  name: widget.name,
                  selectedCountry: dropDownList[0].value);
              // return Container(
              //   margin: EdgeInsets.only(top: 40, left: 20, right: 10),
              //   child: Column(children: [
              //     Row(
              //       children: [
              //         SizedBox(
              //           width: 280,
              //           child: Text(
              //             "Where do you come from?",
              //             style: TextStyle(
              //                 fontSize: 20, fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         // SizedBox(width: 10),
              //         Icon(
              //           Icons.map_outlined,
              //           color: Colors.green,
              //           size: 40,
              //         ),
              //       ],
              //     ),
              //     SizedBox(height: 30),
              //     SizedBox(
              //         width: double.infinity,
              //         child: Text(
              //           "Enter your phone no and country",
              //           textAlign: TextAlign.start,
              //           style: TextStyle(fontSize: 13, color: Colors.black87),
              //         )),
              //     SizedBox(height: 30),
              //     Container(
              //         margin: EdgeInsets.only(right: 20),
              //         width: 400,
              //         child: Form(
              //           key: _formKey,
              //           child: Column(
              //             children: [
              //               TextFormField(
              //                 validator: (value) {
              //                   if (value != null && value.isEmpty) {
              //                     return "Please Enter a Phone number";
              //                   }
              //                   if (value != null && value is String) {
              //                     var v = value;
              //                     if (!Validations.isNumeric(v)) {
              //                       return "Phone is not in correct format";
              //                     }
              //                   }

              //                   return null;
              //                 },
              //                 onSaved: (value) {
              //                   _phone = value;
              //                 },
              //                 cursorColor: Colors.green,
              //                 decoration: InputDecoration(
              //                     hintText: "Phone Number",
              //                     prefixIcon: Container(
              //                         height: 50,
              //                         child: SingleChildScrollView(
              //                           child: DropdownButton(
              //                             borderRadius: BorderRadius.only(
              //                                 bottomLeft: Radius.circular(20),
              //                                 bottomRight: Radius.circular(20)),
              //                             items: dropDownList,
              //                             onChanged: (value) {},
              //                             menuMaxHeight: 400,
              //                             underline: Container(
              //                               height:
              //                                   0, // This makes the underline disappear
              //                             ),
              //                             iconEnabledColor: Colors.green,
              //                           ),
              //                         )),
              //                     focusedBorder: OutlineInputBorder(
              //                         borderSide:
              //                             BorderSide(color: Colors.green),
              //                         borderRadius: BorderRadius.circular(20)),
              //                     border: OutlineInputBorder(
              //                         borderRadius: BorderRadius.circular(20))),
              //               ),
              //             ],
              //           ),
              //         )),
              //     Expanded(
              //         child: Align(
              //             alignment: Alignment.bottomCenter,
              //             child: Padding(
              //               padding: const EdgeInsets.all(8),
              //               child: SizedBox(
              //                 width: double.infinity,
              //                 height: 40,
              //                 child: Widget_ElevatedButton(
              //                   text: "Continue",
              //                   textColor: Colors.black,
              //                   backGroundColor: Colors.green,
              //                   borderColor: Colors.white,
              //                   callBack: () {
              //                     if (_formKey.currentState?.validate() ??
              //                         false) {
              //                       _formKey.currentState?.save();
              //                       Get.to(
              //                           SignUp_Image(
              //                               email: widget.email,
              //                               password: widget.password,
              //                               name: widget.name,
              //                               phone: _phone,
              //                               country: _selectedCountry),
              //                           transition: Transition.rightToLeft,
              //                           duration: Duration(milliseconds: 500));
              //                     }
              //                   },
              //                 ),
              //               ),
              //             )))
              //   ]),
              // );
            }
          }),
    ));
  }
}

class PhoneInput extends StatefulWidget {
  var dropDownList;
  var email, password, name;
  var selectedCountry;
  PhoneInput(
      {required this.dropDownList,
      required this.email,
      required this.password,
      required this.name,
      required this.selectedCountry});

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  final _formKey = GlobalKey<FormState>();
  var _phone;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 10),
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              width: 280,
              child: Text(
                "Where do you come from?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(width: 10),
            Icon(
              Icons.map_outlined,
              color: Colors.green,
              size: 40,
            ),
          ],
        ),
        SizedBox(height: 30),
        SizedBox(
            width: double.infinity,
            child: Text(
              "Enter your phone no and country",
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
                      if (value != null && value.isEmpty) {
                        return "Please Enter a Phone number";
                      }
                      if (value != null && value is String) {
                        var v = value;
                        if (!Validations.isNumeric(v)) {
                          return "Phone is not in correct format";
                        }
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _phone = value;
                    },
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        prefixIcon: Container(
                            height: 50,
                            child: SingleChildScrollView(
                              child: DropdownButton(
                                value: widget.selectedCountry,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                items: widget.dropDownList,
                                onChanged: (value) {
                                  setState(() {
                                    widget.selectedCountry = value;
                                  });
                                },
                                menuMaxHeight: 400,
                                underline: Container(
                                  height:
                                      0, // This makes the underline disappear
                                ),
                                iconEnabledColor: Colors.green,
                              ),
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(20)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            )),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Widget_ElevatedButton(
                      text: "Continue",
                      textColor: Colors.black,
                      backGroundColor: Colors.green,
                      borderColor: Colors.white,
                      callBack: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          Get.to(
                              SignUp_Image(
                                  email: widget.email,
                                  password: widget.password,
                                  name: widget.name,
                                  phone: _phone,
                                  country: widget.selectedCountry),
                              transition: Transition.rightToLeft,
                              duration: Duration(milliseconds: 500));
                        }
                      },
                    ),
                  ),
                )))
      ]),
    );
    ;
  }
}

class SignUp_Image extends StatefulWidget {
  var email, password, name, phone, country;
  SignUp_Image(
      {super.key,
      required this.email,
      required this.password,
      required this.name,
      required this.country,
      required this.phone});

  @override
  State<SignUp_Image> createState() => _SignUp_Image();
}

class _SignUp_Image extends State<SignUp_Image> {
  Uint8List? _img;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: SizedBox(
                width: 250,
                height: 50,
                child: Center(
                    child: LinearProgressIndicator(
                  minHeight: 10,
                  value: 0.9,
                  backgroundColor: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                )),
              ),
              backgroundColor: Colors.white,
              shadowColor: Colors.white,
              leading: BackButton(color: Colors.black),
            ),
            body: Container(
              margin: EdgeInsets.only(top: 40, left: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 280,
                    child: Text(
                      "Take your picture",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        _img != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: MemoryImage(_img!),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.green[100],
                                child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.green,
                                ),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            // onPressed: selectImage(),
                            onPressed: () async {
                              Uint8List? img =
                                  await pickImage(ImageSource.gallery);
                              setState(() {
                                _img = img;
                              });
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.teal[300],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Widget_ElevatedButton(
                                text: "Continue",
                                textColor: Colors.black,
                                backGroundColor: Colors.green,
                                borderColor: Colors.white,
                                callBack: () {
                                  if (_img == null) {
                                    showCustomToast(
                                        context, "Please Select a Picture");
                                  } else {
                                    Get.to(
                                        SignUp_Pin(
                                          email: widget.email,
                                          password: widget.password,
                                          name: widget.name,
                                          phone: widget.phone,
                                          country: widget.country,
                                          img: _img,
                                        ),
                                        transition: Transition.rightToLeft,
                                        duration: Duration(milliseconds: 500));
                                  }
                                },
                              ),
                            ),
                          ))),
                ],
              ),
            )));
  }
}

// input pin

class SignUp_Pin extends StatefulWidget {
  var email, password, name, phone, country, img;
  SignUp_Pin(
      {super.key,
      required this.email,
      required this.password,
      required this.name,
      required this.country,
      required this.phone,
      required this.img});

  @override
  State<SignUp_Pin> createState() => _SignUp_PinState();
}

class _SignUp_PinState extends State<SignUp_Pin> {
  final _formKey = GlobalKey<FormState>();
  var _pin;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: SizedBox(
                width: 250,
                height: 50,
                child: Center(
                    child: LinearProgressIndicator(
                  minHeight: 10,
                  value: 1,
                  backgroundColor: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                )),
              ),
              backgroundColor: Colors.white,
              shadowColor: Colors.white,
              leading: BackButton(color: Colors.black),
            ),
            body: Container(
              margin: EdgeInsets.only(top: 40, left: 20, right: 10),
              child: Column(children: [
                Row(
                  children: [
                    SizedBox(
                      width: 280,
                      child: Text(
                        "Set your PIN code",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // SizedBox(width: 10),
                    Icon(
                      Icons.key,
                      color: Colors.green,
                      size: 40,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Add a four digit PIN to make your account secure. You may ask for a PIN when making a transaction",
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
                              if (value != null && value.isEmpty) {
                                return "Please Enter a PIN";
                              }
                              if (value != null && value is String) {
                                var v = value;
                                if (!Validations.isFourDigitLong(v)) {
                                  return "PIN must be 4 digit long";
                                }
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _pin = value;
                            },
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                                hintText: "Enter PIN",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(20)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: Widget_ElevatedButton(
                              text: "Continue",
                              textColor: Colors.black,
                              backGroundColor: Colors.green,
                              borderColor: Colors.white,
                              callBack: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _formKey.currentState?.save();

                                  Get.to(
                                      SignUp_OTP_Verification(
                                        email: widget.email,
                                        password: widget.password,
                                        name: widget.name,
                                        phone: widget.phone,
                                        country: widget.country,
                                        img: widget.img,
                                        pin: _pin,
                                      ),
                                      transition: Transition.rightToLeft,
                                      duration: Duration(milliseconds: 500));
                                }
                              },
                            ),
                          ),
                        )))
              ]),
            )));
  }
}

// OTP verification

class SignUp_OTP_Verification extends StatefulWidget {
  var email, password, name, phone, country, img, pin;
  var otp;
  SignUp_OTP_Verification({
    super.key,
    required this.email,
    required this.password,
    required this.name,
    required this.country,
    required this.phone,
    required this.img,
    required this.pin,
  }) {
    // Create a random number generator
    Random random = Random();

    // Generate a random integer between a specified range (e.g., 1 to 100)
    int min = 123456;
    int max = 999999;
    int randomInteger = min + random.nextInt(max - min + 1);
    otp = randomInteger.toString();
    sendOtpEmail(email, otp); // Call the sendOTP method in the constructor.
  }

  Future<void> sendOtpEmail(String recipientEmail, String otp) async {
    final smtpServer = gmail('azanalifarooqi@gmail.com', 'xjyq urjr uezs gppl');

    final message = Message()
      ..from = Address('azanalifarooqi@gmail.com', 'Quick Pall')
      ..recipients.add(recipientEmail)
      ..subject = 'OTP Verification'
      ..text = 'Your OTP is: $otp';

    try {
      final sendReport = await send(message, smtpServer);
      // print('Message sent: ${sendReport.sent}');
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  @override
  State<SignUp_OTP_Verification> createState() =>
      _SignUp_OTP_VerificationState();
}

class _SignUp_OTP_VerificationState extends State<SignUp_OTP_Verification> {
  final _formKey = GlobalKey<FormState>();
  bool validateOtp(String code) {
    if (code == widget.otp) {
      print("OTP verified");
      return true;
    } else {
      print("OTP not verified");
      return false;
    }
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
            body: Container(
              margin: EdgeInsets.only(top: 40, left: 20, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 280,
                        child: Text(
                          "OTP code verification",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // SizedBox(width: 10),
                      Icon(
                        Icons.key_sharp,
                        color: Colors.green,
                        size: 40,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                      width: double.infinity,
                      child: Text(
                        "We have sent you OTP on your email " +
                            widget.email +
                            ". Please enter code below to verify",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 20),
                      width: 400,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Please Enter a OTP Code";
                                }
                                if (value != null && value is String) {
                                  var v = value;
                                  if (!validateOtp(v)) {
                                    return "Incorrect OTP";
                                  }
                                }

                                return null;
                              },
                              onSaved: (value) {},
                              cursorColor: Colors.green,
                              decoration: InputDecoration(
                                  hintText: "Enter OTP",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                      borderRadius: BorderRadius.circular(20)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Widget_ElevatedButton(
                                text: "Continue",
                                textColor: Colors.black,
                                backGroundColor: Colors.green,
                                borderColor: Colors.white,
                                callBack: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _formKey.currentState?.save();
                                    String imgUrl =
                                        await AccountController.UploadImage(
                                            widget.img);
                                    if (imgUrl != "-1") {
// Display a loading indicator while the async function is executing
                                      showDialog(
                                        barrierDismissible: false,
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
                                                  CircularProgressIndicator(
                                                    color: Colors.green,
                                                  ),
                                                  SizedBox(height: 16.0),
                                                  Text("Signing up..."),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );

                                      AccountController.CreateAccount(
                                              AccountHolder(
                                                  IsActive: true,
                                                  Country: widget.country.name,
                                                  Email: widget.email,
                                                  Image: imgUrl,
                                                  Money: 0,
                                                  Name: widget.name,
                                                  Password: widget.password,
                                                  Phone: widget.country.code +
                                                      widget.phone,
                                                  Pin: widget.pin))
                                          .then((value) {
                                        // Close the loading indicator
                                        Navigator.of(context).pop();
                                        if (value) {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                // title: Text('Popup Card Title'),
                                                content: Card(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Container(
                                                        height: 300,
                                                        child: Column(
                                                          children: [
                                                            CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                radius: 80,
                                                                child: Icon(
                                                                  Icons.person,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 70,
                                                                )),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "Successfully Signed up",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                )),
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    Widget_ElevatedButton(
                                                                  text:
                                                                      "Continue",
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  backGroundColor:
                                                                      Colors
                                                                          .green,
                                                                  borderColor:
                                                                      Colors
                                                                          .white,
                                                                  callBack: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    // Get.off(
                                                                    // SignUp_NameScreen(
                                                                    //     email: _email, password: _password),
                                                                    // transition: Transition.rightToLeft,
                                                                    // duration: Duration(milliseconds: 500));
                                                                  },
                                                                ))
                                                          ],
                                                        ),
                                                      )
                                                      // Text(
                                                      //       'This is the content of the popup card.'),
                                                      ),
                                                ),
                                                // actions: <Widget>[
                                                //   TextButton(
                                                //     onPressed: () {
                                                //       Navigator.of(context).pop();
                                                //     },
                                                //     child: Text('Close'),
                                                //   ),
                                                // ],
                                              );
                                            },
                                          );
                                        } else {
                                          showCustomToast(context,
                                              "Error in signing up. Contact developer");
                                        }
                                      });
                                    } else {
                                      showCustomToast(context,
                                          "Error in Uploading image. Contact developer");
                                    }

                                    // Get.to(
                                    //     SignUp_OTP_Verification(
                                    //       email: widget.email,
                                    //       password: widget.password,
                                    //       name: widget.name,
                                    //       phone: widget.phone,
                                    //       country: widget.country,
                                    //       img: widget.img,
                                    //     ),
                                    //     transition: Transition.rightToLeft,
                                    //     duration: Duration(milliseconds: 500));
                                  }
                                },
                              ),
                            ),
                          )))
                ],
              ),
            )));
  }
}
