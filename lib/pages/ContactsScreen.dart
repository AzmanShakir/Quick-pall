import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/controllers/accountController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:get/get.dart';
import 'package:quick_pall_local_repo/models/FriendsViewModel.dart';

class ContactsScreen extends StatefulWidget {
  AccountHolder user;
  GlobalKey<ScaffoldState> scaffoldKey;
  ContactsScreen({super.key, required this.user, required this.scaffoldKey});
  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  // List<FriendsViewModel> friends = null;
  var friends = null;
  var filteredFriends = null;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initListOfFriends();
  }

  void initListOfFriends() async {
    var f = await AccountController.GetFriendsList(
            "aliazanaliazanazanali@outlook.com") ??
        [];
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
              )),
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
                        return Dismissible(
                          key: Key(filteredFriends[index]
                              .Email), // Provide a unique key for each item
                          onDismissed: (direction) {
                            // Handle the item dismissal (e.g., remove the item from the list)
                            AccountController.DeleteFriend(
                                filteredFriends[index]);
                            setState(() {
                              filteredFriends.removeAt(index);
                            });

                            // Optional: Show a snackbar to undo the deletion
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
                          ),
                        );
                      }),
        )
      ],
    ));
  }
}
