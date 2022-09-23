import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import '../helpers/session.dart';
import '../helpers/view_utils.dart';
import '../network/dio_client.dart';

class SignUpScreenPage extends StatefulWidget {
  const SignUpScreenPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpScreenPageState();
  }
}

class SignUpScreenPageState extends State<SignUpScreenPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tecEmailController =
      TextEditingController(text: '');
  final TextEditingController _tecPasswordController =
      TextEditingController(text: '');
  final TextEditingController _tecLicenseController =
      TextEditingController(text: '');
  final TextEditingController _tecAddressController =
      TextEditingController(text: '');
 bool _isLoading = false;
  @override
  void initState() {
    super.initState();
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
                    start: const Offset(0, 100),
                    top: Offset(screenWidth / 2, 160),
                    end: Offset(screenWidth, 100),
                  ),
                ],
              ),
              child: Container(
                color: Colors.white,
                height: 160,
                child: Stack(children: [
                  Center(
                    child: SizedBox(
                        height: 100, child: Image.asset("assets/logo.png")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: IconButton(onPressed: (){_goBack();}, icon: const Icon(Icons.arrow_back,color: Colors.blue,)),
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Center(
                        child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _tecEmailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email can't be empty";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration:  InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(color: Colors.white70,fontSize: 12),
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _tecLicenseController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "License ID can't be empty";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "License ID",
                        hintStyle: const TextStyle(color: Colors.white70,fontSize: 12),
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _tecAddressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Address can't be empty";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration:  InputDecoration(
                        hintText: "Address",
                        hintStyle: const TextStyle(color: Colors.white70,fontSize: 12),
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
                    const SizedBox(height: 10),
                   TextFormField(
                            controller: _tecPasswordController,  validator: (value) {
                            if (value!.isEmpty) {
                              return "Password can't be empty";
                            } else if (value.length<6) {
                              return "Password should be at least 6 characters";
                            }
                            return null;
                          },
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration:  InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white70,fontSize: 12),
                              hintText: "Password",
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
                    const SizedBox(height: 10),
                    _isLoading ?
                    const CircularProgressIndicator(
                       color: Colors.white,
                    ) :SizedBox(
                      width: 200,
                      height: 43,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ))),
                        onPressed: () {
                          _signUp();
                        },
                        child: const Center(
                            child: Text("SignUp",
                                style:
                                TextStyle(color: Colors.blue, fontSize: 18))),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Map<String, dynamic> _getQueryParams() {
    Map<String, String> queryParams = {
      'email': _tecEmailController.text,
      'password': _tecPasswordController.text,
      'address': _tecAddressController.text,
      'license_id': _tecLicenseController.text,
    };
    return queryParams;
  }
  _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      var userAccount = await DioClient().signUp(_getQueryParams()).catchError((exception){
      ViewUtils().showToast(exception.toString());
      });
      if(userAccount!=null) {
        if (userAccount.error!) {
          ViewUtils().showToast(userAccount.message!);
        } else {
          ViewUtils().showToast(userAccount.message!);
          if(userAccount.data?.accessToken!=null) {
            userAccount.data?.accessToken = "Bearer ${userAccount.data?.accessToken}";
          }
          await Session().setAccount(userAccount.data);
          await Session().setPassword(_tecPasswordController.text);
         _goBackWithStatus();
        }
      }
      setState(() {
        _isLoading = false;
      });
    }
  }
  _goBackWithStatus() {
    Navigator.pop(context,true);
  }
  _goBack() {
    Navigator.of(context).pop(context);
  }
}
