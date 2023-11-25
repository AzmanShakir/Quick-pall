import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_pall_local_repo/controllers/accountController.dart';
import 'package:quick_pall_local_repo/controllers/notificationController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  AccountHolder user;
  NotificationScreen({super.key, required this.user});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var Notifications = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUser();
    initListOfNotifications();
  }

  void GetUser() async {
    AccountHolder? u;
    u = await AccountController.SignIn(widget.user.Email, widget.user.Password);
    setState(() {
      if (u != null && u is AccountHolder) widget.user = u;
    });
  }

  void initListOfNotifications() async {
    var f =
        await NotificationController.GetAllNotifications(widget.user.Email) ??
            [];

    if (f.isNotEmpty) {
      // Sort by DateTime field createdAt
      // f.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      // Notifications = f;
      // print(friends[0].Name);
    }

    setState(() {
      Notifications = f;
    });
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
            "Notifications",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Container(
            child: (Notifications == null)
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                    // child: Text("No History"),
                  )
                : (Notifications.length == 0)
                    ? Center(
                        // child: CircularProgressIndicator(),
                        child: Text("No Notifications"),
                      )
                    : ListView.builder(
                        itemCount: Notifications.length,
                        itemBuilder: (context, index) {
                          return (!Notifications[index].IsClicked)
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, top: 10.0),
                                  child: Container(
                                    color: Colors.black12,
                                    child: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: InkWell(
                                        onTap: () async {
                                          await NotificationController
                                              .SetNotificationClicked(
                                                  Notifications[index]);
                                        },
                                        child: Dismissible(
                                          key: Key(Notifications[index]
                                              .Id), // Provide a unique key for each item
                                          onDismissed: (direction) {
                                            // Handle the item dismissal (e.g., remove the item from the list)
                                            Notifications.DeleteNotification(
                                                Notifications[index]);
                                            setState(() {
                                              Notifications.removeAt(index);
                                            });
                                          },
                                          background: Container(
                                            color: Colors.red,
                                            alignment: Alignment.centerRight,
                                            padding:
                                                EdgeInsets.only(right: 16.0),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                      Notifications[index]
                                                          .Image),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Notifications[index].Name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(Notifications[index]
                                                            .NotificationType +
                                                        " " +
                                                        Notifications[index]
                                                            .Amount),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(DateFormat(
                                                            "yyyy-MM-dd")
                                                        .format(
                                                            Notifications[index]
                                                                .createdAt)
                                                        .toString())
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10.0),
                                  child: Dismissible(
                                    key: Key(Notifications[index]
                                        .Id), // Provide a unique key for each item
                                    onDismissed: (direction) {
                                      // Handle the item dismissal (e.g., remove the item from the list)
                                      Notifications.DeleteNotification(
                                          Notifications[index]);
                                      setState(() {
                                        Notifications.removeAt(index);
                                      });
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(right: 16.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                Notifications[index].Image),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Notifications[index].Name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(Notifications[index]
                                                      .NotificationType +
                                                  " " +
                                                  Notifications[index].Amount),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(DateFormat("yyyy-MM-dd")
                                                  .format(Notifications[index]
                                                      .createdAt)
                                                  .toString())
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                        },
                      )),
      ),
    );
  }
}
