import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/controllers/accountController.dart';
import 'package:quick_pall_local_repo/controllers/contactController.dart';
import 'package:quick_pall_local_repo/controllers/notificationController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:get/get.dart';
import 'package:quick_pall_local_repo/models/FriendsViewModel.dart';
import 'package:quick_pall_local_repo/pages/HomeScreen.dart';
import 'package:quick_pall_local_repo/utils/Validations.dart';
import 'package:quick_pall_local_repo/widgets/Buttons.dart';

class MoneyRequestScreen extends StatefulWidget {
  AccountHolder user;
  MoneyRequestScreen({super.key, required this.user});

  @override
  State<MoneyRequestScreen> createState() => _MoneyRequestScreenState();
}

class _MoneyRequestScreenState extends State<MoneyRequestScreen> {
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
            "Request from",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: ShowContactsScreen(
          user: widget.user,
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class ShowContactsScreen extends StatefulWidget {
  AccountHolder user;
  // GlobalKey<ScaffoldState> scaffoldKey;
  ShowContactsScreen({super.key, required this.user});
  // {super.key, required this.user, required this.scaffoldKey});
  @override
  State<ShowContactsScreen> createState() => _ShowContactsScreenState();
}

class _ShowContactsScreenState extends State<ShowContactsScreen> {
  // List<FriendsViewModel> friends = null;
  var friends = null;
  var filteredFriends = null;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUser();
    initListOfFriends();
  }

  void GetUser() async {
    AccountHolder? u;
    u = await AccountController.SignIn(widget.user.Email, widget.user.Password);
    setState(() {
      if (u != null && u is AccountHolder) widget.user = u;
    });
  }

  void initListOfFriends() async {
    var f = await ContactController.GetFriendsList(widget.user.Email) ?? [];
    if (f.isNotEmpty) {
      f.sort((a, b) => a.Name.compareTo(b.Name));
      friends = f;
      filteredFriends = f;
      print(friends[0].Name);
    }
    setState(() {
      friends = f;
      filteredFriends = f;
    });
  }

  void filterFriendsList(String query) {
    setState(() {
      filteredFriends = friends
          .where((friend) =>
              friend.Name.toLowerCase().contains(query.toLowerCase()) ||
              friend.Email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  // height: 200,
                  width: 300,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.grey[100],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onChanged: (query) => filterFriendsList(query),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: (friends == null)
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                  // child: Text("No History"),
                )
              : (friends.length == 0)
                  ? Center(
                      // child: CircularProgressIndicator(),
                      child: Text("No Contacts"),
                    )
                  : AzListView(
                      data: filteredFriends,
                      itemCount: filteredFriends.length,
                      itemBuilder: (context, index) {
                        print(friends[0].Name);
                        // return Text(friends[index].Name);
                        // return Dismissible(
                        //   key: Key(filteredFriends[index]
                        //       .Email), // Provide a unique key for each item
                        //   onDismissed: (direction) {
                        //     // Handle the item dismissal (e.g., remove the item from the list)
                        //     AccountController.DeleteFriend(
                        //         filteredFriends[index]);
                        //     setState(() {
                        //       filteredFriends.removeAt(index);
                        //     });

                        //     // Optional: Show a snackbar to undo the deletion
                        //   },
                        //   background: Container(
                        //     color: Colors.red,
                        //     alignment: Alignment.centerRight,
                        //     padding: EdgeInsets.only(right: 16.0),
                        //     child: Icon(
                        //       Icons.delete,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        //   child:
                        return InkWell(
                          onTap: () {
                            Get.to(
                                AmountToRequest(
                                    user: widget.user,
                                    friend: filteredFriends[index]),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 500));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      filteredFriends[index].Image),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      filteredFriends[index].Name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(filteredFriends[index].Email)
                                  ],
                                ),
                              ],
                            ),
                            // ),
                          ),
                        );
                      }),
        )
      ],
    ));
  }
}

class AmountToRequest extends StatefulWidget {
  AccountHolder user;
  FriendsViewModel friend;
  AmountToRequest({super.key, required this.friend, required this.user});

  @override
  State<AmountToRequest> createState() => _AmountToRequestState();
}

class _AmountToRequestState extends State<AmountToRequest> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _Amountcontroller = TextEditingController();

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
            "Amount to request",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.green),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      controller: _Amountcontroller,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return '    Please enter some amount';
                        }
                        // String v;

                        // if (value != null && value is String) {
                        //   v = value;
                        //   if (!Validations.isValidAmountToSend(v)) {
                        //     return "Amount can only contain numbers without spaces, commas or decimals";
                        //   }
                        //   if (!Validations.isHaveEnoughBalance(
                        //       amountToSend: v,
                        //       userBalance: widget.user.Money)) {
                        //     return "    You have not enough balance";
                        //   }
                        // }
                        return null;
                      },
                      onSaved: (value) {},
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Amount",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   "Your account balance is Rs. " +
                  //       widget.user.Money.toString(),
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 300,
                child: Widget_ElevatedButton(
                  text: "Continue",
                  textColor: Colors.black,
                  backGroundColor: Colors.green,
                  borderColor: Colors.white,
                  callBack: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      Get.to(
                          RequestNow(
                              user: widget.user,
                              friend: widget.friend,
                              amountToSend: _Amountcontroller.text),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 500));
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class RequestNow extends StatefulWidget {
  AccountHolder user;
  FriendsViewModel friend;
  String amountToSend;
  RequestNow(
      {super.key,
      required this.user,
      required this.friend,
      required this.amountToSend});

  @override
  State<RequestNow> createState() => _RequestNowState();
}

class _RequestNowState extends State<RequestNow> {
  final _formKeyReason = GlobalKey<FormState>();
  final _formKeyPin = GlobalKey<FormState>();
  TextEditingController _Reasoncontroller = TextEditingController();
  TextEditingController _Pincontroller = TextEditingController();

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
            "Request Now",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Requested From",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(widget.friend.Image),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.friend.Name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.friend.Email,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Requested amount",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Rs. " + widget.amountToSend,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 300,
                  child: Widget_ElevatedButton(
                    text: "Send Request",
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                          await NotificationController.SendMoneyRequest(
                              senderEmail: widget.user.Email,
                              recieverEmail: widget.friend.Email,
                              requestedAmount: widget.amountToSend);

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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        "Cannot send request. Contact Developer"),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        Navigator.of(context).pop();
                        Get.to(HomeScreen(user: widget.user),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 500));
                      }

                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return PinEntryModal();
                      //   },
                      // );

                      // Get.to(
                      //     SendNow(
                      //         user: widget.user,
                      //         friend: widget.friend,
                      //         amountToSend: "_Amountcontroller.text"),
                      //     transition: Transition.rightToLeft,
                      //     duration: Duration(milliseconds: 500));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
