import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/controllers/accountController.dart';
import 'package:quick_pall_local_repo/controllers/contactController.dart';
import 'package:quick_pall_local_repo/controllers/notificationController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:quick_pall_local_repo/models/AddFriendViewModel.dart';
import 'package:get/get.dart';
import 'package:quick_pall_local_repo/widgets/Buttons.dart';

class SearchContactScreen extends StatefulWidget {
  AccountHolder user;
  AddFriendViewModel friend;
  SearchContactScreen({super.key, required this.friend, required this.user});

  @override
  State<SearchContactScreen> createState() => _SearchContactScreenState();
}

class _SearchContactScreenState extends State<SearchContactScreen> {
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
            "Searched Contact",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.friend.Image),
                radius: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.friend.Name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                widget.friend.Email,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 25,
              ),
              Text("Quick Pall Account"),
              SizedBox(
                height: 35,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              (widget.friend.IsAlreadyFriend)
                  ? Text("This account holder is already in your contacts")
                  : Text("This account holder is not in your contacts"),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: (!widget.friend.IsAlreadyFriend)
                      ? Widget_ElevatedButton(
                          text: "Add to contacts",
                          textColor: Colors.black,
                          backGroundColor: Colors.green,
                          borderColor: Colors.white,
                          callBack: () async {
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
                                        // Text("Please Wait..."),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            // bool status = await ContactController.AddContact(
                            //   widget.user.Email,
                            //   widget.friend.Email,
                            // );
                            bool status = await NotificationController
                                .SendFriendRequestNotification(
                              widget.user.Email,
                              widget.friend.Email,
                            );

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
                                          Text(
                                              "Cannot add contact. Contact Developer"),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              Navigator.of(context).pop();

                              Get.back();
                            }
                          },
                        )
                      : Widget_ElevatedButton(
                          text: "Delete Contact",
                          textColor: Colors.black,
                          backGroundColor: Colors.green,
                          borderColor: Colors.white,
                          callBack: () async {
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
                                        // Text("Please Wait..."),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            bool status = await ContactController.DeleteContact(
                              widget.user.Email,
                              widget.friend.Email,
                            );

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
                                          Text(
                                              "Cannot add contact. Contact Developer"),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              Navigator.of(context).pop();

                              Get.back();
                            }
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
