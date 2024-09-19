import 'package:flutter/material.dart';

class LoadingListWidget extends StatelessWidget {
  final double? loadingWidth;
  final double? loadingHeight;
  const LoadingListWidget({
    this.loadingHeight = 50,
    this.loadingWidth = 50,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 9.5),
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 13,
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 10,
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 10,
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
