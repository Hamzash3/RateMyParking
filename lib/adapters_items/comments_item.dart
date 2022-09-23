import 'package:flutter/material.dart';

import '../helpers/view_utils.dart';
import '../models/sub_models/post_comment_entity.dart';

class CommentItem extends StatelessWidget {
  final PostCommentEntity commentModel;

  const CommentItem(
      {required this.commentModel, required this.onCallback, super.key});

  final Function(String onClick) onCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCallback("details");
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 2),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(ViewUtils().getNullableString(commentModel.comment),
                    style: const TextStyle(color: Colors.black45, fontSize: 12)),
              ),
            ),
            const SizedBox(height: 2,),
             Align(
              alignment:Alignment.bottomRight,
              child: Text(ViewUtils().getNullableString(commentModel.createdAt),
                  style: const TextStyle(color: Colors.black45, fontSize: 12)),
            )
          ],
        )),
      ),
    );
  }
}
