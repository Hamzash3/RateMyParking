import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import '../helpers/session.dart';
import '../helpers/view_utils.dart';
import '../network/dio_client.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenPageState();
  }
}

class LoginScreenPageState extends State<LoginScreenPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _tecEmailController = TextEditingController(text: '');
  final TextEditingController _tecPasswordController = TextEditingController(text: '');

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
                    start: const Offset(0, 150),
                    top: Offset(screenWidth / 2, 200),
                    end: Offset(screenWidth, 150),
                  ),
                ],
              ),
              child: Container(
                color: Colors.white,
                height: 200,
                child: Stack(children: [
                  Center(
                    child: SizedBox(
                        height: 130, child: Image.asset("assets/logo.png")),
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
                      const Center(child: Text("Login", style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
                      const SizedBox(height: 10),
                      /*Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white,width: 0.5),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.blue,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
                            child: TextFormField(
                              controller: _tecEmailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email can't be empty";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),

                          )),*/
                      TextFormField(
                        controller: _tecEmailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email can't be empty";
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
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
                        controller: _tecPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't be empty";
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: InputDecoration(
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
                            _login();
                          },
                          child: const Center(
                              child: Text("Login",
                                  style:
                                  TextStyle(color: Colors.blue, fontSize: 18))),
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: (){
                          _moveToSignUp();
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Don't have an account ?", style: TextStyle(color: Colors.white60),),
                              Text("SIGN UP", style: TextStyle(color: Colors.white),)
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
    );
  }
  _goBackWithStatus() {
    Navigator.pop(context,true);
  }
  _moveToSignUp() async {
    Navigator.of(context)
        .pushNamed(ViewUtils.signUpRoute).then((status) {
          try {
            if (status as bool) {
              _goBackWithStatus();
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
  Map<String, dynamic> _getQueryParams() {
    Map<String, String> queryParams = {
      'email': _tecEmailController.text,
      'password': _tecPasswordController.text,
    };
    return queryParams;
  }
  _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      var userAccount = await DioClient().login(_getQueryParams()).catchError((exception){
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
  _goBack() {
    Navigator.of(context).pop(context);
  }
}
