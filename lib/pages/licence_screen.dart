import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:rate_my_parking/models/user_account_entity.dart';

import '../helpers/session.dart';
import '../helpers/view_utils.dart';

class LicenceScreenPage extends StatefulWidget {
  const LicenceScreenPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LicenceScreenPageState();
  }
}

class LicenceScreenPageState extends State<LicenceScreenPage> {
  final TextEditingController _tecSearchController =
      TextEditingController(text: '');
   UserAccountData? _userAccount;

  @override
  void initState() {
    super.initState();
    _getUserAccount();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: ProsteBezierCurve(
                position: ClipPosition.bottom,
                list: [
                  BezierCurveSection(
                    start: const Offset(0, 150),
                    top: Offset(screenWidth / 2, 250),
                    end: Offset(screenWidth, 150),
                  ),
                ],
              ),
              child: Container(
                color: Colors.white,
                height: 250,
                child: Stack(children: [
                  Center(
                    child: SizedBox(
                        height: 130, child: Image.asset("assets/logo.png")),
                  ),
                  _checkLoginForLogout()
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: _tecSearchController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white70,fontSize: 12),
                            hintText: "Enter License Number",
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10.0),
                        child: FloatingActionButton(
                            onPressed: () {
                              if (_tecSearchController.text.isNotEmpty) {
                                _moveToHome(_tecSearchController.text);
                              } else {
                                ViewUtils().showToast("Enter license number");
                              }
                            },
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.blue,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 66,
                    width: 250,
                    child: InkWell(
                        onTap: () {
                          _moveToAddPostScreen();
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 6.0),
                              child: Center(
                                  child: Text("Rate My Parking",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18))),
                            ))),
                  ),
                  const SizedBox(height: 15),
                  _checkLoginForText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
/*
  _moveToHome(String licenseNumber) async {
    Navigator.of(context).pushNamedAndRemoveUntil(
        ViewUtils.homeRoute,
        arguments: licenseNumber,
        (Route<dynamic> route) => false);
  }*/
  _moveToHome(String licenseNumber) async {
    Navigator.of(context).pushNamed(
        ViewUtils.homeRoute,
        arguments: licenseNumber).then((value) {
      _getUserAccount();
    });
  }

  _moveToLogin() async {
    Navigator.of(context).pushNamed(ViewUtils.loginRoute).then((status) {
      try {
        if (status as bool) {
          _getUserAccount();
        }
      }
      catch(exception)
      {
        if (kDebugMode) {
          print(exception);
        }
      }
    });
  }
  _moveToAddPostScreen() async {
    Navigator.of(context).pushNamed(ViewUtils.addPostRoute).then((value) {
      _getUserAccount();
    });
  }

  _checkLoginForText(){
    if(_userAccount==null)
      {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: InkWell(
            onTap: () {
              _moveToLogin();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Do you want to ",
                  style: TextStyle(color: Colors.white60),
                ),
                Text(
                  "Login?",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
      }
    else
      {
        return const SizedBox();
      }
  }
  _checkLoginForLogout(){
    if(_userAccount!=null)
      {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: IconButton(onPressed: (){
              _logout();
            }, icon: const Icon(Icons.logout,color: Colors.blue,)),
          ),
        );
      }
    else
      {
        return const SizedBox();
      }
  }

  void _getUserAccount() async {
    if (!mounted) return;
    _userAccount = await Session().getAccount();
    setState(() {});
  }

  void _logout() {
    Session().logout();
    setState(() {
      _userAccount=null;
    });
  }


}
