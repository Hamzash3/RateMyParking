import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_parking/adapters_items/post_timeline_card.dart';
import 'package:rate_my_parking/models/post_model_entity.dart';

import '../helpers/view_utils.dart';
import '../network/dio_client.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  bool _isLoading = true;
  final bool _isLoadingBottom = false;
  final List<PostModelData> _postsList = [];
  final ScrollController _scrollController = ScrollController();
  String _licenseNumber="";

  @override
  void didChangeDependencies() {
    final  Object? arg = ModalRoute.of(context)?.settings.arguments;
   if(_licenseNumber.isEmpty) {
     _licenseNumber = arg as String;
     _getPostJobs();
   }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    /*WidgetsBinding.instance.addObserver(this);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        if (!_isLoadingBottom) {
          _isLoadingBottom = true;
          setState(() {});
        }
      }
    });*/
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
  Map<String, dynamic> _getQueryParams() {
    Map<String, String> queryParams = {
      'license_id': _licenseNumber,
    };
    return queryParams;
  }
  void _getPostJobs() async {
        setState(() {
          _isLoading = true;
        });
        var response = await DioClient().getPostsByLicenseId(_getQueryParams()).catchError((exception){
          ViewUtils().showToast(exception.toString());
        });
        if(response!=null) {
          if (response.error!) {
            ViewUtils().showToast(response.message!);
          } else {
            if(response.data!=null) {
              _postsList.addAll(response.data!);
            }
          }
        }
        _isLoading = false;
        setState(() {});
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[20],
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        iconSize: 20.0,
        onPressed: () {
          _goBack(context);
        },
      ),
        title: Text(_licenseNumber),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isLoading
                ? Expanded(
                  child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator())),
                )
                : Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _postsList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, i) {
                      return PostCard(
                          postModel: _postsList[i],
                          onCallback: (onClick) {
                            if (onClick.compareTo("details")==0) {
                              _moveToDetails(_postsList[i].id);
                            }
                          });
                    },
                  ),
                ),
            _isLoadingBottom
                ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: CircularProgressIndicator()),
            )
                : const SizedBox(width: 1),

          ],
        ),
      ),
    );
  }

  _goBack(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(context);
    //exit(0);
  }
  _moveToDetails(int? id) async {
    Navigator.of(context).pushNamed(ViewUtils.postDetailRoute,
        arguments: id.toString());
  }
}
