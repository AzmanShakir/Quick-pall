import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/Controllers/accountController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:quick_pall_local_repo/pages/AccountScreen.dart';
import 'package:quick_pall_local_repo/pages/ContactsScreen.dart';
import 'package:quick_pall_local_repo/pages/Sign-InScreen.dart';
import 'package:quick_pall_local_repo/pages/TransactionViewScreen.dart';
import 'package:quick_pall_local_repo/viewModels/TransactionsViewModel.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  AccountHolder user;
  HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  var _currentTabIndex = 0;
  var _tabs;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    // Access widget properties in the initState method
    _tabs = [
      Home(user: widget.user),
      ContactsScreen(
        scaffoldKey: _scaffoldKey,
        user: widget.user,
      ),
      AccountScreen(
        user: widget.user,
      ),
    ];
  }

  //[
  //   Home(widget.user),
  //   Center(
  //     child: Text("COnatcts"),
  //   ),
  //   AccountScreen()
  // ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: Image.asset("assets/images/logo.png"),
          leadingWidth: 35,
          title: Text(
            'Quick Pall',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_on_outlined,
                  color: Colors.black,
                ))
          ],
        ),
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: _tabs[_currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 18,
          unselectedFontSize: 15,
          iconSize: 30,
          currentIndex: _currentTabIndex,
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.house_outlined,
                color: Colors.black,
              ),
              icon: Icon(
                Icons.house_outlined,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.contacts_outlined,
                  color: Colors.black,
                ),
                icon: Icon(Icons.contacts_outlined),
                label: "Contacts"),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.person_2_outlined,
                  color: Colors.black,
                ),
                icon: Icon(Icons.person_2_outlined),
                label: "Account"),
          ],
          selectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  AccountHolder user;
  Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _accountBalance;
  var _transactionsList = null;
  @override
  void initState() {
    super.initState();
    setTransactionList();
    UpdateUserData();
    _accountBalance = widget.user.Money.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.green),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                _accountBalance,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              Text(
                "Account Balance",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Send
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.send_outlined,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Send",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  //Request
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.download_outlined,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Request",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  //withdraw
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          child: IconButton(
                              iconSize: 30,
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Withdraw",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(
                "Transaction History",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                // height: 200,
                child: (_transactionsList == null)
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                        // child: Text("No History"),
                      )
                    : (_transactionsList.length == 0)
                        ? Center(
                            // child: CircularProgressIndicator(),
                            child: Text("No History"),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  await Get.to(
                                      TransactionViewScreen(
                                          model: _transactionsList[index]),
                                      transition: Transition.rightToLeft,
                                      duration: Duration(milliseconds: 500));
                                  setState(() {
                                    setTransactionList();
                                  });
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          _transactionsList[index].Image),
                                      radius: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          _transactionsList[index].Name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(DateFormat("yyyy-MM-dd")
                                            .format(_transactionsList[index]
                                                .dateTime)
                                            .toString())
                                      ],
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          _transactionsList[index].Money,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(_transactionsList[index]
                                            .transactionType)
                                      ],
                                    ))
                                  ],
                                ),
                              );
                              // return Text("Azan");
                            },
                            itemCount: _transactionsList.length,
                            itemExtent: 70,
                          )),
          ),
        )
      ],
    ));
  }

  void setTransactionList() async {
    var x = await AccountController.GetTransactionsList(widget.user.Email);
    print(x);
    if (x != null && x is List<TransactionsViewModel>) {
      _transactionsList = x;
    }
    print("setStateAzan");
    print(_transactionsList.length);
    print("setStateAzan");
    setState(() {
      if (x != null && x is List<TransactionsViewModel>) {
        _transactionsList = x;
      }
    });
  }

  void UpdateUserData() async {
    var u =
        await AccountController.SignIn(widget.user.Email, widget.user.Password);

    setState(() {
      if (u != null && u is AccountHolder) {
        widget.user = u;
      }
    });
  }
}
