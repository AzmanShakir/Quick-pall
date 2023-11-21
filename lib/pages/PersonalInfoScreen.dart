import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_pall_local_repo/controllers/accountController.dart';
import 'package:quick_pall_local_repo/controllers/countryController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:quick_pall_local_repo/models/Country.dart';
import 'package:quick_pall_local_repo/pages/HomeScreen.dart';
import 'package:quick_pall_local_repo/utils/PickImage.dart';
import 'package:quick_pall_local_repo/utils/Validations.dart';
import 'package:quick_pall_local_repo/widgets/Buttons.dart';

class PersonalInfoScreen extends StatefulWidget {
  AccountHolder user;
  PersonalInfoScreen({super.key, required this.user});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  Uint8List? _img;
  var _phone;
  late Country _selectedCountry;
  late final TextEditingController _Namecontroller =
      TextEditingController(text: widget.user.Name);
  var isImageChange = false;
  var isCountryChanges = false;
  final _formKey = GlobalKey<FormState>();
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
            "Personal Info",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Stack(
                    children: [
                      _img != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: MemoryImage(_img!),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.green[100],
                              // child: Icon(
                              //   Icons.person,
                              //   size: 100,
                              //   color: Colors.green,
                              // ),
                              backgroundImage: NetworkImage(widget.user.Image),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          // onPressed: selectImage(),
                          onPressed: () async {
                            print(_img);
                            print("azan");
                            Uint8List? img =
                                await pickImage(ImageSource.gallery);
                            setState(() {
                              _img = img;
                              if (_img != null) isImageChange = true;
                              print(_img);
                            });
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Colors.green,
                            weight: 100,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Full Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 10),
                  child: TextFormField(
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // _name = value;
                      },
                      controller: _Namecontroller,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        hintText: "Name",
                        // prefixIcon: Icon(Icons.abc_rounded, color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(40)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey), // Change the color here
                          borderRadius: BorderRadius.circular(40),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    widget.user.Email,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Phone Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Text(
                      widget.user.Phone,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Widget_ElevatedButton(
                        text: "Update",
                        textColor: Colors.black,
                        backGroundColor: Colors.green,
                        borderColor: Colors.white,
                        callBack: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.green,
                                        ),
                                        SizedBox(height: 16.0),
                                        Text("Updating..."),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            AccountHolder UpdatedUser;
                            if (isImageChange) {
                              var imgUrl =
                                  await AccountController.UploadImage(_img!);

                              UpdatedUser = AccountHolder(
                                  Country: widget.user.Country,
                                  Email: widget.user.Email,
                                  Image: imgUrl,
                                  Money: widget.user.Money,
                                  Name: _Namecontroller.text,
                                  Password: widget.user.Password,
                                  Phone: widget.user.Phone,
                                  IsActive: widget.user.IsActive,
                                  CreatedAt: widget.user.CreatedAt,
                                  UpdatedAt: widget.user.UpdatedAt,
                                  Pin: widget.user.Pin);
                            } else {
                              UpdatedUser = AccountHolder(
                                  Country: widget.user.Country,
                                  Email: widget.user.Email,
                                  Image: widget.user.Image,
                                  Money: widget.user.Money,
                                  Name: _Namecontroller.text,
                                  Password: widget.user.Password,
                                  Phone: widget.user.Phone,
                                  CreatedAt: widget.user.CreatedAt,
                                  UpdatedAt: widget.user.UpdatedAt,
                                  IsActive: widget.user.IsActive,
                                  Pin: widget.user.Pin);
                            }

                            bool status = true;
                            await AccountController.UpdateUser(
                                OldData: widget.user, NewData: UpdatedUser);
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                          Text("Invalid Credentials"),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              Navigator.of(context).pop();
                              Get.offAll(
                                  HomeScreen(
                                    user: UpdatedUser,
                                  ),
                                  transition: Transition.rightToLeft,
                                  duration: Duration(milliseconds: 500));
                            }
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
  }

  SelectUserCountry(List<DropdownMenuItem<Country>> dropDownList) {
    // if (isCountryChanges) return;
    for (int i = 0; i < dropDownList.length; i++) {
      var c = dropDownList[i].value;
      if (c != null && c is Country) if (c.name == widget.user.Country) {
        _selectedCountry = c;
        return c;
      }
    }
  }
}
