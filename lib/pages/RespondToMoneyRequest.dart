import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_pall_local_repo/models/NotificationViewModel.dart';
import 'package:quick_pall_local_repo/widgets/Buttons.dart';

class ResponfToMoneyRequest extends StatelessWidget {
  NotificationViewModel notification;
  ResponfToMoneyRequest({super.key, required this.notification});

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
                    backgroundImage: NetworkImage(notification.Image),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    notification.Amount,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    notification.Name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    notification.FromEmail,
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
                        // Text(getTransactionText()),
                        Expanded(
                            child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            notification.Amount,
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
                        // Text(getSenderOrRecieverText()),
                        Expanded(
                            child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            notification.Name,
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
                            notification.FromEmail,
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
                                .format(notification.createdAt)
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
                    Row(
                      children: [
                        Text("Transaction Id"),
                        Expanded(
                            child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            notification.Id,
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
                    Align(
                      alignment: Alignment.center,
                      child: Widget_ElevatedButton(
                          text: "Delete",
                          backGroundColor: Colors.green,
                          borderColor: Colors.white,
                          textColor: Colors.black,
                          callBack: () {
                            // TransactionController.DeleteTransaction(
                            //     model.TransactionReference, model);

                            Get.back();
                          }),
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
