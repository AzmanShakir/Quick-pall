import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/controllers/accountController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';

class AccountScreen extends StatefulWidget {
  AccountHolder user;
  AccountScreen({super.key, required this.user});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.user.Image),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.Name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.user.Email)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.person_2_outlined),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Personal Info",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.keyboard_arrow_right_outlined)))
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.security_outlined),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Security",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.keyboard_arrow_right_outlined)))
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Logout",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  void GetUser() async {
    AccountHolder? u;
    u = await AccountController.SignIn(widget.user.Email, widget.user.Password);
    setState(() {
      if (u != null && u is AccountHolder) widget.user = u;
    });
  }
}
