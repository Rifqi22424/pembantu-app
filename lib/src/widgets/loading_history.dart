import 'package:flutter/material.dart';

ListView loadingData() {
  return ListView.builder(
    shrinkWrap: true,
    padding: EdgeInsets.zero,
    itemCount: 12,
    itemBuilder: (context, index) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
            width: 400,
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 231, 231, 231))),
                SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 20,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromARGB(255, 231, 231, 231))),
                    SizedBox(height: 4),
                    Container(
                        height: 15,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromARGB(255, 231, 231, 231))),
                  ],
                ),
                Spacer(),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    height: 15,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(255, 231, 231, 231))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(height: 1, thickness: 1, color: Color(0xffF1F1F1)),
          ),
        ],
      );
    },
  );
}
