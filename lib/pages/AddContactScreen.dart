import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_pall_local_repo/controllers/accountController.dart';
import 'package:quick_pall_local_repo/controllers/contactController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:quick_pall_local_repo/models/AddFriendViewModel.dart';
import 'package:quick_pall_local_repo/pages/SearchContactScreen.dart';
import 'package:quick_pall_local_repo/utils/Validations.dart';
import 'package:quick_pall_local_repo/widgets/Buttons.dart';

class AddContactScreen extends StatefulWidget {
  AccountHolder user;
  AddContactScreen({super.key, required AccountHolder this.user});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _EmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            "Add Contact",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Account Holder Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: TextFormField(
                    controller: _EmailController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter Email';
                      }
                      String v;

                      if (value != null && value is String) {
                        v = value;
                        if (!Validations.isValidEmail(v)) {
                          return "Please enter a valid email";
                        }
                      }
                      return null;
                    },
                    onSaved: (value) {},
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
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 300,
                  child: Widget_ElevatedButton(
                    text: "Search",
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.green,
                                    ),
                                    SizedBox(height: 16.0),
                                    Text("Searching..."),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        AddFriendViewModel? friend =
                            await ContactController.GetAccountHolderAsContact(
                                widget.user.Email, _EmailController.text);
                        if (friend == null) {
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      Text("Account Holder not found"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (friend != null &&
                            friend is AddFriendViewModel) {
                          Navigator.of(context).pop();

                          Get.to(
                              SearchContactScreen(
                                user: widget.user,
                                friend: friend,
                              ),
                              transition: Transition.rightToLeft,
                              duration: Duration(milliseconds: 500));
                        }
                      }
                    },
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
