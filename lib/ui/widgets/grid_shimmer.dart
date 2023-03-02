import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridShimmer extends StatelessWidget {
  final int? itemCount;
  const GridShimmer({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: itemCount ?? 6,
        itemBuilder: (BuildContext context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 8,
                    width: 100,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 100,
        ),
      ),
    );
  }
}
