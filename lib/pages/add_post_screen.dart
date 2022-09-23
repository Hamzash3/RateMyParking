import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:rate_my_parking/network/dio_client.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'dart:io' as io;
import '../helpers/session.dart';
import '../helpers/view_utils.dart';
import 'package:location/location.dart' as loc;

import '../models/user_account_entity.dart';

class AddPostScreenPage extends StatefulWidget {
  const AddPostScreenPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddPostScreenPageState();
  }
}

class AddPostScreenPageState extends State<AddPostScreenPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tecLicenseIDController =
      TextEditingController(text: '');
  final TextEditingController _tecCommentController =
      TextEditingController(text: '');
  double _rating = 3.0;
  String? _imagePath;
  Position? _currentLocation;
  String _currentAddress = "";
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = true;
  UserAccountData? _userAccount;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getUserAccount();
       _getCurrentLocation();
    });

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: _isLoading
            ? SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(child: CircularProgressIndicator(color: Colors.white,)))
            :Column(
          children: <Widget>[
            ClipPath(
              clipper: ProsteBezierCurve(
                position: ClipPosition.bottom,
                list: [
                  BezierCurveSection(
                    start: const Offset(0, 80),
                    top: Offset(screenWidth / 2, 120),
                    end: Offset(screenWidth, 80),
                  ),
                ],
              ),
              child: Container(
                color: Colors.white,
                height: 120,
                child: Stack(children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 80, child: Image.asset("assets/logo.png")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: IconButton(
                        onPressed: () {
                          _goBack();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.blue,
                        )),
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
                      "Add Post",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Expanded(
                          child: Text("Select Image",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.white,
                          mini: true,
                          heroTag: "gallery_job",
                          onPressed: () {
                            _onImageButtonPressed(ImageSource.gallery);
                          },
                          tooltip: 'Pick Image from gallery',
                          child: const Icon(
                            Icons.photo,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.white,
                          mini: true,
                          heroTag: "camera_job",
                          onPressed: () {
                            _onImageButtonPressed(ImageSource.camera);
                          },
                          tooltip: 'Pick Image from Camera',
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Align(
                      alignment: Alignment.topLeft,
                      child: _getImageFromPath(),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "License ID",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _tecLicenseIDController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
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
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                        ),
                        Flexible(
                          child: Text(
                            _currentAddress,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Comment",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _tecCommentController,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      minLines: null,
                      maxLines: null,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
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
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Rating",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: SmoothStarRating(
                              allowHalfRating: true,
                              onRatingChanged: (v) {
                                setState(() {
                                  _rating =
                                      double.parse((v).toStringAsFixed(1));
                                });
                              },
                              starCount: 5,
                              rating: _rating,
                              size: 30.0,
                              color: Colors.amber,
                              borderColor: Colors.amber,
                              spacing: 0.0),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    size: 17,
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    _rating.toString(),
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 200,
                      height: 43,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ))),
                        onPressed: () {
                          _addPost();
                        },
                        child: const Center(
                            child: Text("Add Post",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 18))),
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

  Future<void> _onImageButtonPressed(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _imagePath = pickedFile?.path;
      });
    } catch (e) {
      ViewUtils().showToast(e.toString());
    }
  }

  _getImageFromPath() {
    if (_imagePath != null) {
      return kIsWeb
          ? Image.network(_imagePath!, height: 100)
          : Image.file(
              io.File(_imagePath!),
              height: 100,
            );
    } else {
      return const SizedBox();
    }
  }

  _getCurrentLocation() async {
    setState(() {
      _isLoading=true;
    });
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ViewUtils().showToast('Location services are disabled.');
      var location = loc.Location();
      var isServiceEnable= await location.requestService();
      if(!isServiceEnable)
      {
        setState(() {
          _isLoading=false;
        });
        return Future.error('Location services are disabled.');
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ViewUtils().showToast('Location permissions are denied.');
        setState(() {
          _isLoading=false;
        });
        return Future.error('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ViewUtils().showToast(
          'Location permissions are permanently denied, we cannot request permissions.');
      setState(() {
        _isLoading=false;
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    _currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _getCurrentLocationAddress();
  }

  _goBack() {
    Navigator.of(context).pop(context);
  }

  _getCurrentLocationAddress() async {
    if (_currentLocation != null) {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      if (placeMarks.first.name != null) {
        _currentAddress =
            "${placeMarks.first.name!} ${placeMarks.first.street!} ${placeMarks.first.subLocality!} ${placeMarks.first.locality!} ,${placeMarks.first.country!}";
      }
    } else {
      _currentAddress = "";
    }
    setState(() {
      _currentAddress;
      _isLoading=false;
    });
  }

  Map<String, dynamic> _getQueryParams() {
    Map<String, dynamic> queryParams = {
      'description': _tecCommentController.text,
      'address': _currentAddress,
      'rating': _rating,
      'latitude': _currentLocation!.latitude,
      'longitude': _currentLocation!.longitude,
      'license_id': _tecLicenseIDController.text
    };
    return queryParams;
  }

  void _addPost() async {
    if (_formKey.currentState!.validate()) {
      if(_userAccount!=null) {
        setState(() {
          _isLoading=true;
        });
        var response =
        await DioClient().addPost(_getQueryParams(), _imagePath!).catchError((
            exception) {
          ViewUtils().showToast(exception.toString());
        });

        setState(() {
          _isLoading=false;
        });
        if (response != null) {
          if (response.error!) {
            ViewUtils().showToast(response.message!);
          } else {
            ViewUtils().showToast(response.message!);
            _goBack();
          }
        }
      }
      else
        {
          ViewUtils().showToast("You need to login first !!!");
          _moveToLogin();
        }
    }
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

  void _getUserAccount() async {
    if (!mounted) return;
    _userAccount = await Session().getAccount();
  }
}
