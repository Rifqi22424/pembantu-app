import 'package:flutter/material.dart';

loadingUserList() {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 231, 231, 231)),
            ),
            SizedBox(width: 16),
            SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 24,
                      width: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 231, 231, 231))),
                  SizedBox(height: 10),
                  Container(
                      height: 24,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 231, 231, 231))),
                  SizedBox(height: 10),
                  Container(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 20,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromARGB(255, 231, 231, 231))),
                        Container(
                            height: 14,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromARGB(255, 231, 231, 231))),
                        Container(
                            height: 14,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromARGB(255, 231, 231, 231))),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      height: 20,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 231, 231, 231))),
                  SizedBox(height: 10),
                  Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 231, 231, 231))),
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Divider(
          thickness: 2,
          color: Color(0xFFF5F5F5),
        ),
      )
    ],
  );
}
