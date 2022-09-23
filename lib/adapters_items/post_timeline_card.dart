import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_parking/helpers/view_utils.dart';
import 'package:rate_my_parking/models/post_model_entity.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class PostCard extends StatelessWidget {
  final PostModelData postModel;

  const PostCard(
      {required this.postModel, required this.onCallback, super.key});

  final Function(String onClick) onCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCallback("details");
      },
      child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: Padding(
            padding:  const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 150,
                    child: CachedNetworkImage(
                      imageUrl:
                      ViewUtils().getNullableFileUrl(postModel.image),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text("License ID:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(ViewUtils().getNullableString(postModel.licenseId),
                          style:
                              const TextStyle(color: Colors.black45, fontSize: 16)),
                    ),
                    const Icon(
                      Icons.arrow_circle_right_rounded,
                      color: Colors.blue,
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
                        child:  Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            ViewUtils().getNullableString(postModel.rating.toString()),
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
                          rating: ViewUtils().getNullableDouble(postModel.rating),
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
                Text(ViewUtils().getNullableString(postModel.description),
                  style: const TextStyle(color: Colors.black45, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children:[
                    const Icon(
                      Icons.comment,
                      color: Colors.black45,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("Comments",
                        style: TextStyle(color: Colors.black45, fontSize: 16)),
                    Expanded(
                      child: Text(ViewUtils().getNullableString(postModel.commentsCount.toString()),
                          textAlign: TextAlign.right,
                          style:
                              const TextStyle(color: Colors.black45, fontSize: 16)),
                    ),
                  ],
                ),
              ],
            )),
          )),
    );
  }
}
