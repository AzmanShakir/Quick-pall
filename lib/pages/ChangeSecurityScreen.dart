import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_pall_local_repo/controllers/accountController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:quick_pall_local_repo/pages/HomeScreen.dart';
import 'package:quick_pall_local_repo/utils/Validations.dart';
import 'package:quick_pall_local_repo/widgets/Buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeSecurityScreen extends StatefulWidget {
  AccountHolder user;
  ChangeSecurityScreen({super.key, required AccountHolder this.user});

  @override
  State<ChangeSecurityScreen> createState() => _ChangeSecurityScreenState();
}

class _ChangeSecurityScreenState extends State<ChangeSecurityScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isRememberMeSwicth = false;
  bool isObsecurePassword = true;
  bool isObsecurePin = true;
  late final TextEditingController _Passwordcontroller =
      TextEditingController(text: widget.user.Password);
  late final TextEditingController _Pincontroller =
      TextEditingController(text: widget.user.Pin);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSwitchValue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          leadingWidth: 35,
          title: Text(
            "Security",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Remember Me",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          // Current state of the switch
                          value: isRememberMeSwicth,
                          // Callback when the switch is toggled
                          onChanged: (value) async {
                            // Set the state based on the new value
                            setState(() {
                              isRememberMeSwicth = value;
                            });
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            if (isRememberMeSwicth) {
                              prefs.setString('Email', widget.user.Email);
                              prefs.setString('Password', widget.user.Password);
                            } else {
                              var email = prefs.getString("Email") ?? "null";
                              if (email != "null") {
                                prefs.remove("Email");
                                prefs.remove("Password");
                              }
                            }
                          },
                          // Custom color when the switch is turned on
                          activeColor: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )),
                ),
                TextFormField(
                  controller: _Passwordcontroller,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter a password';
                    }
                    String v;

                    if (value != null && value is String) {
                      v = value;
                      if (!Validations.isValidPassword(v)) {
                        return "Password must be 6 character long";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {},
                  obscureText: isObsecurePassword,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(
                            isObsecurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isObsecurePassword
                                  ? isObsecurePassword = false
                                  : isObsecurePassword = true;
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )),
                ),
                TextFormField(
                  controller: _Pincontroller,
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
                  onSaved: (value) {},
                  obscureText: isObsecurePin,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(
                            isObsecurePin
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isObsecurePin
                                  ? isObsecurePin = false
                                  : isObsecurePin = true;
                            });
                          }),
                      hintText: "Pin",
                      prefixIcon: Icon(Icons.key, color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Widget_ElevatedButton(
                        text: "Update",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.green,
                                        ),
                                        SizedBox(height: 16.0),
                                        Text("Updating..."),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            AccountHolder UpdatedUser;
                            UpdatedUser = AccountHolder(
                                Country: widget.user.Country,
                                Email: widget.user.Email,
                                Image: widget.user.Image,
                                Money: widget.user.Money,
                                Name: widget.user.Name,
                                Password: _Passwordcontroller.text,
                                Phone: widget.user.Phone,
                                CreatedAt: widget.user.CreatedAt,
                                UpdatedAt: widget.user.UpdatedAt,
                                IsActive: widget.user.IsActive,
                                Pin: _Pincontroller.text);

                            bool status = await AccountController.UpdateUser(
                                OldData: widget.user, NewData: UpdatedUser);
                            if (status == false) {
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
                                          Text("Cannot Update"),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              Navigator.of(context).pop();

                              Get.offAll(
                                  HomeScreen(
                                    user: UpdatedUser,
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
        )),
      ),
    );
  }

  void setSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String Email = prefs.getString('Email') ?? "null";
    if (Email != "null") {
      setState(() {
        isRememberMeSwicth = true;
      });
    }
  }
}
