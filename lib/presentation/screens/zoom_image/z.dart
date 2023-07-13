import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ZoomImage extends StatelessWidget {
  final String image;
  final int imageId;
  const ZoomImage({
    super.key,
    required this.image,
    required this.imageId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CachedNetworkImage(
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade700,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          imageUrl: image,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
