import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_parking/models/post_details_entity.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../adapters_items/comments_item.dart';
import '../helpers/session.dart';
import '../helpers/view_utils.dart';
import '../models/sub_models/post_comment_entity.dart';
import '../models/user_account_entity.dart';
import '../network/dio_client.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return DetailScreenState();
  }
}

class DetailScreenState extends State<DetailScreen>
    with WidgetsBindingObserver {
  bool _isLoading = true;
  bool _isLoadingBottom = false;
  bool _isMessageSending = false;
  bool _isCommentSendEnable = false;
  final List<PostCommentEntity> _commentsList = [];
  final ScrollController _scrollController = ScrollController();
  //final _itemController = ItemScrollController();
  UserAccountData? _userAccount;
  String _postId = "";
  PostDetailsData _postDetailsData = PostDetailsData();
  final TextEditingController _tecCommentController =
      TextEditingController(text: '');

  void _getUserAccount() async {
    if (!mounted) return;
    _userAccount = await Session().getAccount();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    final Object? arg = ModalRoute.of(context)?.settings.arguments;
    if(_postId.isEmpty) {
      _postId = arg as String;
      _getPostDetails();
    }
    super.didChangeDependencies();
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        if (!_isLoadingBottom) {
          _isLoadingBottom = true;
          setState(() {});
        }
      }
    });
    _getUserAccount();
  }

  Map<String, dynamic> _getQueryParams() {
    Map<String, String> queryParams = {
      'post_id': _postId,
    };
    return queryParams;
  }
  Map<String, dynamic> _getQueryParamsForComment() {
    Map<String, String> queryParams = {
      'post_id': _postId,
      'comment': _tecCommentController.text,
    };
    return queryParams;
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
  _checkLoginForText(){
    if(_userAccount==null)
    {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            _moveToLogin();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Do you want to login for comment ? ",
                style: TextStyle(color: Colors.black54),
              ),
              Text(
                "Click here !!!",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
      );
    }
    else
    {
      return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _tecCommentController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _isCommentSendEnable = true;
                    });
                  } else {
                    setState(() {
                      _isCommentSendEnable = false;
                    });
                  }
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10),
                  hintText: "Comment",
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(40.0)),
                    borderSide:
                    BorderSide(color: Colors.black12, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(40.0)),
                    borderSide:
                    BorderSide(color: Colors.black12, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(40.0)),
                    borderSide:
                    BorderSide(color: Colors.black12, width: 1.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            if(!_isMessageSending)
                _isCommentSendEnable
                    ? FloatingActionButton(
                  onPressed: () {
                    _addPostComment();
                  },
                  mini: true,
                  child: const Icon(Icons.send),
                )
                    : const SizedBox(
                  height: 5,
                )
              else
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }
  }

  void _getPostDetails() async {
    setState(() {
      _isLoading = true;
    });
    var response = await DioClient().getPostDetail(_getQueryParams()).catchError((exception){
      ViewUtils().showToast(exception.toString());
    });
    if(response!=null) {
      if (response.error!) {
        ViewUtils().showToast(response.message!);
      } else {
        if(response.data!=null) {
          _postDetailsData = response.data!;
          if(response.data!.comments!=null) {
            _commentsList.addAll(response.data!.comments!);
          }
        }
      }
    }
    _isLoading = false;
    setState(() {});
  }
  void _addPostComment() async {
    setState(() {_isMessageSending=true;});
    var response = await DioClient().writeComment(_getQueryParamsForComment()).catchError((exception){
      ViewUtils().showToast(exception.toString());
    });
    if(response!=null) {
      if (response.error!) {
        ViewUtils().showToast(response.message!);
      } else {
        _tecCommentController.text='';
        _isCommentSendEnable=false;
        if(response.data!=null) {
           _commentsList.insert(0,response.data!);
        }
      }
    }
    _isMessageSending=false;
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            _goBack(context);
          },
        ),
        title: const Text("Details"),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()))
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 150,
                              child: CachedNetworkImage(
                                imageUrl:ViewUtils().getNullableFileUrl(_postDetailsData.image),
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children:  [
                              const Text("License ID:",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(ViewUtils().getNullableString(_postDetailsData.licenseId),
                                    style: const TextStyle(
                                        color: Colors.black45, fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text("Location:",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(ViewUtils().getNullableString(_postDetailsData.address),
                                    style: const TextStyle(
                                        color: Colors.black45, fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      ViewUtils().getNullableDouble(_postDetailsData.rating).toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: SmoothStarRating(
                                    allowHalfRating: true,
                                    onRatingChanged: (v) {},
                                    starCount: 5,
                                    rating: ViewUtils().getNullableDouble(_postDetailsData.rating),
                                    size: 20.0,
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    spacing: 0.0),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(ViewUtils().getNullableString(_postDetailsData.description),
                            style: const TextStyle(color: Colors.black45, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Comments",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          ScrollablePositionedList.builder(
                           /* itemScrollController: _itemController,*/
                            itemCount: _commentsList.length,
                            scrollDirection: Axis.vertical,
                            //physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return CommentItem(
                                  commentModel: _commentsList[i],
                                  onCallback: (onClick) {
                                    if (kDebugMode) {
                                      print(onClick);
                                    }
                                  });
                            },
                          ),
                          _isLoadingBottom
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child:
                                      Center(child: CircularProgressIndicator()),
                                )
                              : const SizedBox(width: 1),
                        ],
                      ),
                    ),
                  ),
                ),
                _checkLoginForText(),
              ],
            ),
    );
  }

 /* Future _scrollToCounter() async {
  *//*  _itemController.scrollTo(
        index: 19, duration: const Duration(seconds: 1), alignment: 0.5);*//*
  }*/

  _goBack(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(context);
  }
}
