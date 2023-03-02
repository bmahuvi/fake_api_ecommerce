import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductsShimmer extends StatelessWidget {
  const ProductsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Flexible(
                      child: Column(
                    children: [
                      buildContainer(height: 12, rightPadding: 0),
                      buildContainer(height: 8, rightPadding: 20),
                      buildContainer(height: 5, rightPadding: 80),
                      const Spacer(),
                      buildContainer(height: 12, rightPadding: 0)
                    ],
                  )),
                ))
              ],
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  Container buildContainer(
      {required double height, required double rightPadding}) {
    return Container(
      height: height,
      margin: EdgeInsets.fromLTRB(0, 8, rightPadding, 8),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
    );
  }
}
