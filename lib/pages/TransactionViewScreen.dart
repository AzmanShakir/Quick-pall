import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_pall_local_repo/Controllers/accountController.dart';
import 'package:quick_pall_local_repo/controllers/transactionController.dart';
import 'package:quick_pall_local_repo/viewModels/TransactionsViewModel.dart';
import 'package:quick_pall_local_repo/widgets/Buttons.dart';

class TransactionViewScreen extends StatelessWidget {
  TransactionsViewModel model;
  TransactionViewScreen({super.key, required this.model});

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
            model.transactionType,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
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
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(model.Image),
                      radius: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      model.Money,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      model.Name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      model.Email,
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
                          Text(getTransactionText()),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              model.Money,
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
                          Text(getSenderOrRecieverText()),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              model.Name,
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
                              model.Email,
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
                                  .format(model.dateTime)
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
                              model.TransactionReference,
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
                      Text("Reason"),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                model.Reason,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Widget_ElevatedButton(
                            text: "Delete",
                            backGroundColor: Colors.green,
                            borderColor: Colors.white,
                            textColor: Colors.black,
                            callBack: () {
                              TransactionController.DeleteTransaction(
                                  model.TransactionReference, model);
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
      ),
    );
  }

  String getTransactionText() {
    if (model.transactionType == "Sent") return "You Sent";
    if (model.transactionType == "Recieve") return "You Recieved";
    if (model.transactionType == "Withdraw") return "You WithDrawed";
    return "";
  }

  String getSenderOrRecieverText() {
    if (model.transactionType == "Sent") return "To";
    if (model.transactionType == "Recieve") return "From";
    if (model.transactionType == "Withdraw") return "Withdraw from";
    return "";
  }
}
