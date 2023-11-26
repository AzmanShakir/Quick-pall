// import 'dart:js_util';

import 'package:avoid_keyboard/avoid_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quick_pall_local_repo/controllers/notificationController.dart';
import 'package:quick_pall_local_repo/controllers/transactionController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:quick_pall_local_repo/models/NotificationViewModel.dart';
import 'package:quick_pall_local_repo/pages/HomeScreen.dart';
import 'package:quick_pall_local_repo/utils/Validations.dart';
import 'package:quick_pall_local_repo/widgets/Buttons.dart';

class ResponfToMoneyRequest extends StatefulWidget {
  NotificationViewModel notification;
  AccountHolder user;

  ResponfToMoneyRequest(
      {super.key, required this.user, required this.notification});

  @override
  State<ResponfToMoneyRequest> createState() => _ResponfToMoneyRequestState();
}

class _ResponfToMoneyRequestState extends State<ResponfToMoneyRequest> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _Reasoncontroller = TextEditingController();

  TextEditingController _Pincontroller = TextEditingController();

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
            "Requested",
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.notification.Amount,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.notification.Name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.notification.FromEmail,
                    style: TextStyle(color: Colors.black87),
                  ),
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
                    Row(
                      children: [
                        Text("Amount requested"),
                        Expanded(
                            child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            widget.notification.Amount,
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
                        Text("Requested from"),
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
                    SizedBox(
                      height: 30,
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 300,
                        child: Widget_ElevatedButton(
                            text: "Send Now",
                            backGroundColor: Colors.green,
                            borderColor: Colors.white,
                            textColor: Colors.black,
                            callBack: () async {
                              showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => AvoidKeyboard(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      height: 600,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Enter Reason",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    maxLength: 60,

                                                    // textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                    controller:
                                                        _Reasoncontroller,
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Please provide reason';
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (value) {},
                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Enter Reason",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Enter 4-digit pin",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  TextFormField(
                                                    maxLength: 4,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    // textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                    controller: _Pincontroller,
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Please provide Pin';
                                                      }
                                                      if (value != null &&
                                                          value is String) {
                                                        var v = value;
                                                        if (!Validations
                                                            .isFourDigitLong(
                                                                v)) {
                                                          return "Please Enter 4 digits";
                                                        }
                                                        if (!(v ==
                                                            widget.user.Pin)) {
                                                          return "Pin is not correct";
                                                        }
                                                      }
                                                      return null;
                                                    },
                                                    obscureText: true,
                                                    onSaved: (value) {},
                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Enter Pin",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: SizedBox(
                                                width: 300,
                                                child: Widget_ElevatedButton(
                                                  text: "Send",
                                                  textColor: Colors.black,
                                                  backGroundColor: Colors.green,
                                                  borderColor: Colors.white,
                                                  callBack: () async {
                                                    if (_formKey.currentState
                                                            ?.validate() ??
                                                        false) {
                                                      _formKey.currentState
                                                          ?.save();

                                                      if (widget.user.Money >=
                                                          int.parse(widget
                                                              .notification
                                                              .Amount)) {
                                                        showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              content:
                                                                  Container(
                                                                height: 200,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CircularProgressIndicator(
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            16.0),
                                                                    Text(
                                                                        "Sending..."),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        bool status = await TransactionController.SendMoney(
                                                            SenderEmail: widget
                                                                .user.Email,
                                                            RecieverEmail: widget
                                                                .notification
                                                                .FromEmail,
                                                            reason:
                                                                _Reasoncontroller
                                                                    .text,
                                                            amountToSend: widget
                                                                .notification
                                                                .Amount);

                                                        await NotificationController
                                                            .MoneySentNotification(
                                                                senderEmail:
                                                                    widget.user
                                                                        .Email,
                                                                recieverEmail: widget
                                                                    .notification
                                                                    .FromEmail,
                                                                amount: widget
                                                                    .notification
                                                                    .Amount);
                                                        if (status == false) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          showDialog(
                                                            // barrierDismissible: false,
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                content:
                                                                    Container(
                                                                  height: 200,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      CircleAvatar(
                                                                          backgroundColor: Colors
                                                                              .red,
                                                                          radius:
                                                                              80,
                                                                          child:
                                                                              Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                Colors.black,
                                                                            size:
                                                                                70,
                                                                          )),
                                                                      SizedBox(
                                                                          height:
                                                                              16.0),
                                                                      Text(
                                                                          "Cannot Send"),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          Navigator.of(context)
                                                              .pop();

                                                          widget.user
                                                              .Money = widget
                                                                  .user.Money -
                                                              int.parse(widget
                                                                  .notification
                                                                  .Amount);
                                                          Get.offAll(
                                                              HomeScreen(
                                                                user:
                                                                    widget.user,
                                                              ),
                                                              transition:
                                                                  Transition
                                                                      .rightToLeft,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500));
                                                        }
                                                      } else {
                                                        showDialog(
                                                          // barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              content:
                                                                  Container(
                                                                height: 200,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .red,
                                                                        radius:
                                                                            80,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              70,
                                                                        )),
                                                                    SizedBox(
                                                                        height:
                                                                            16.0),
                                                                    Text(
                                                                        "You have not enough balance"),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }

                                                      // Get.to(
                                                      //     SendNow(
                                                      //         user: widget.user,
                                                      //         friend: widget.friend,
                                                      //         amountToSend:
                                                      //             _Amountcontroller.text),
                                                      //     transition:
                                                      //         Transition.rightToLeft,
                                                      //     duration:
                                                      //         Duration(milliseconds: 500));
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
                                ),
                              );

                              // TransactionController.DeleteTransaction(
                              //     model.TransactionReference, model);

                              // Get.back();
                            }),
                      ),
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
}
