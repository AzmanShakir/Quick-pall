// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_pall_local_repo/controllers/contactController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:quick_pall_local_repo/models/NotificationViewModel.dart';
import 'package:quick_pall_local_repo/widgets/Buttons.dart';

class RespondToFriendRequest extends StatefulWidget {
  NotificationViewModel notification;
  AccountHolder user;
  var isAlreadyFriend;
  RespondToFriendRequest(
      {super.key, required this.notification, required this.user});
  @override
  State<RespondToFriendRequest> createState() => _RespondToFriendRequestState();
}

class _RespondToFriendRequestState extends State<RespondToFriendRequest> {
  @override
  void initState() {
    // TODO: implement initState
    IsAlreadyFriend();
  }

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
            "Friend Request",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.green),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.notification.Image),
                    radius: 40,
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   notification.Amount,
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.notification.Name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   notification.FromEmail,
                  //   style: TextStyle(color: Colors.black87),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    // height: 200,
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text("Sender"),
                        Expanded(
                            child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            widget.notification.Name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text("Email"),
                        Expanded(
                            child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            widget.notification.FromEmail,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text("Date"),
                        Expanded(
                            child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            DateFormat("yyyy-MM-dd")
                                .format(widget.notification.createdAt)
                                .toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Row(
                    //   children: [
                    //     Text("Transaction Id"),
                    //     Expanded(
                    //         child: Align(
                    //       alignment: Alignment.topRight,
                    //       child: Text(
                    //         notification.Id,
                    //         style: TextStyle(
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ))
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 300,
                          child: (widget.isAlreadyFriend == null)
                              ? Widget_ElevatedButton(
                                  text: "Accept Request",
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
                                    print("No issue");
                                    bool status =
                                        await ContactController.AddContact(
                                      widget.user.Email,
                                      widget.notification.FromEmail,
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
                                                      backgroundColor:
                                                          Colors.red,
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
                                  text: "Request Accepted",
                                  textColor: Colors.black,
                                  backGroundColor: Colors.grey,
                                  borderColor: Colors.green,
                                  callBack: () {
                                    // loading while async function exec
                                    // showDialog(
                                    //   barrierDismissible: false,
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return AlertDialog(
                                    //       content: Container(
                                    //         height: 200,
                                    //         child: Column(
                                    //           mainAxisSize: MainAxisSize.min,
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.center,
                                    //           crossAxisAlignment:
                                    //               CrossAxisAlignment.center,
                                    //           children: [
                                    //             CircularProgressIndicator(
                                    //               color: Colors.green,
                                    //             ),
                                    //             SizedBox(height: 16.0),
                                    //             // Text("Please Wait..."),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    // );
                                    // bool status =
                                    //     await ContactController.DeleteContact(
                                    //   widget.user.Email,
                                    //   widget.notification.FromEmail,
                                    // );

                                    // if (status == false) {
                                    //   Navigator.of(context).pop();
                                    //   showDialog(
                                    //     // barrierDismissible: false,
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return AlertDialog(
                                    //         content: Container(
                                    //           height: 200,
                                    //           child: Column(
                                    //             mainAxisSize: MainAxisSize.min,
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment.center,
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment.center,
                                    //             children: [
                                    //               CircleAvatar(
                                    //                   backgroundColor:
                                    //                       Colors.red,
                                    //                   radius: 80,
                                    //                   child: Icon(
                                    //                     Icons.close,
                                    //                     color: Colors.black,
                                    //                     size: 70,
                                    //                   )),
                                    //               SizedBox(height: 16.0),
                                    //               Text(
                                    //                   "Cannot delete contact. Contact Developer"),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       );
                                    //     },
                                    //   );
                                    // } else {
                                    //   Navigator.of(context).pop();

                                    //   Get.back();
                                    // }
                                  },
                                )),
                    )
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void IsAlreadyFriend() async {
    widget.isAlreadyFriend = await ContactController.GetFriend(
        widget.user.Email, widget.notification.FromEmail);

    print("it is " + widget.isAlreadyFriend.toString());
    setState(() {});
  }
}
