import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/domain/Entity/category_entity.dart';
import 'package:e_commerce_app/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget categoryItem(context, CategoryObject catModel) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 150,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! categoryImage
          SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width / 4,
            child: CachedNetworkImage(
              imageUrl: catModel.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade800,
                highlightColor: Colors.grey.shade700,
                child: Container(
                  color: Colors.black,
                  width: 100,
                  height: 100,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
              ),
            ),
          ),
          //! catText
          15.pw,
          Text(
            catModel.name,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Expanded(child: SizedBox()),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        ],
      ),
    ),
  );
}
