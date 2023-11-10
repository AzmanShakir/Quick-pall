import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/Controllers/accountController.dart';
import 'package:quick_pall_local_repo/pages/AccountScreen.dart';
import 'package:quick_pall_local_repo/viewModels/TransactionsViewModel.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  var _currentTabIndex = 0;

  var _tabs = [
    Home(),
    Center(
      child: Text("COnatcts"),
    ),
    AccountScreen()
  ];

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
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _transactionsList = [];
  @override
  void initState() {
    super.initState();
    setTransactionList();
  }

  var _accountBalance = "0";
  // var _transactionsList = [
  //   TransactionsViewModel(
  //       Name: "Name",
  //       Image: "Image",
  //       Money: "Money",
  //       dateTime: DateTime.now(),
  //       transactionType: "transactionType"),
  //   TransactionsViewModel(
  //       Name: "Name",
  //       Image: "Image",
  //       Money: "Money",
  //       dateTime: DateTime.now(),
  //       transactionType: "transactionType"),
  //   TransactionsViewModel(
  //       Name: "Name",
  //       Image: "Image",
  //       Money: "Money",
  //       dateTime: DateTime.now(),
  //       transactionType: "transactionType"),
  //   TransactionsViewModel(
  //       Name: "Name",
  //       Image: "Image",
  //       Money: "Money",
  //       dateTime: DateTime.now(),
  //       transactionType: "transactionType"),
  //   TransactionsViewModel(
  //       Name: "Name",
  //       Image: "Image",
  //       Money: "Money",
  //       dateTime: DateTime.now(),
  //       transactionType: "transactionType"),
  //   TransactionsViewModel(
  //       Name: "Name",
  //       Image: "Image",
  //       Money: "Money",
  //       dateTime: DateTime.now(),
  //       transactionType: "transactionType"),
  //   TransactionsViewModel(
  //       Name: "Name",
  //       Image: "Image",
  //       Money: "Money",
  //       dateTime: DateTime.now(),
  //       transactionType: "transactionType"),
  //   TransactionsViewModel(
  //       Name: "Name",
  //       Image: "Image",
  //       Money: "Money",
  //       dateTime: DateTime.now(),
  //       transactionType: "transactionType")
  // ];
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
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
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
                    width: 30,
                  ),
                  //Request
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
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
                    width: 30,
                  ),
                  //withdraw
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
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
              Expanded(
                  child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: Colors.green,
                    ),
                  ],
                ),
                onPressed: () {},
              )),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              // height: 200,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            _transactionsList[index].Name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(DateFormat("yyyy-MM-dd")
                              .format(_transactionsList[index].dateTime)
                              .toString())
                        ],
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            _transactionsList[index].Money,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(_transactionsList[index].transactionType)
                        ],
                      ))
                    ],
                  );
                  // return Text("Azan");
                },
                itemCount: _transactionsList.length,
                itemExtent: 70,
              ),
            ),
          ),
        )
      ],
    ));
  }

  void setTransactionList() async {
    var x =
        await AccountController.GetTransactionsList("azanalifarooqi@gmail.com");
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
}
