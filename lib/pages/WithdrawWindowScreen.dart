import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_pall_local_repo/controllers/transactionController.dart';
import 'package:quick_pall_local_repo/controllers/withDrawController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:quick_pall_local_repo/widgets/Buttons.dart';
import 'package:get/get.dart';

class WithdrawWindowScreen extends StatefulWidget {
  AccountHolder user;
  WithdrawWindowScreen({required this.user});

  @override
  State<WithdrawWindowScreen> createState() => _WithdrawWindowScreenState();
}

class _WithdrawWindowScreenState extends State<WithdrawWindowScreen> {
  final String userEmail = "frazpk15@gmail.com";

  final String collectionName = "withdrawWindow";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OpenWindow();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Your custom function or logic here
          WithDrawController.CloseWithDrawWindow(widget.user.Email);
          // Perform any action you want when the back button is pressed
          // Return true to allow back navigation, or false to prevent it
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                WithDrawController.CloseWithDrawWindow(widget.user.Email);

                Get.back();
              },
            ),
            leadingWidth: 35,
            title: Text(
              "Withdraw",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: StreamBuilder<DocumentSnapshot>(
              stream: WithDrawController.GetIncomingRequestStream(
                  widget.user.Email),
              builder: (context, snapshot) {
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  // If document doesn't exist or data is not yet available
                  return Center(
                    child: Text(
                      "No incoming withdraw request",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ); // You can replace this with a loading indicator
                }

                var data = snapshot.data!.data() as Map<String, dynamic>;

                // Check the "IsActive" property
                bool isOpen = data['IsOpen'];

                if (isOpen) {
                  var data = snapshot.data;
                  return Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Are you sure to withdraw ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Rs. " + data!["Amount"],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Widget_OutlinedButton(
                                    text: "No",
                                    // backGroundColor: Colors.green,
                                    // borderColor: Colors.white,
                                    textColor: Colors.black,
                                    callback: () {
                                      WithDrawController.CloseWithDrawWindow(
                                          widget.user.Email);
                                      WithDrawController.DeleteIncomingRequest(
                                          widget.user.Email);
                                      Get.back();
                                    }),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 100,
                                child: Widget_ElevatedButton(
                                    text: "Yes",
                                    backGroundColor: Colors.green,
                                    borderColor: Colors.white,
                                    textColor: Colors.black,
                                    callBack: () {
                                      WithDrawController.CloseWithDrawWindow(
                                          widget.user.Email);
                                      WithDrawController.DeleteIncomingRequest(
                                          widget.user.Email);
                                      TransactionController.MakeTransaction(
                                          RecieverEmail: widget.user.Email,
                                          SenderEmail: "Admin",
                                          TransactionType: "Withdraw",
                                          Amount: data!["Amount"],
                                          Reason: "Cash Withdraw");
                                      widget.user.Money -
                                          int.parse(data!["Amount"]);
                                      Get.back();
                                    }),
                              ),
                            ],
                          )
                        ]),
                  );
                } else {
                  return Center(
                    child: Text(
                      "No incoming withdraw request",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void OpenWindow() async {
    await WithDrawController.OpenWithDrawWindow(widget.user.Email);
  }
}
