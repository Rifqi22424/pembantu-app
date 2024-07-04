import 'package:flutter/material.dart';

loadingUserProfile() {
  return SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(
          height: 355,
          width: double.maxFinite,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 231, 231, 231)),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 24, right: 24, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(255, 231, 231, 231)),
                  ),
                  Container(
                    height: 24,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(255, 231, 231, 231)),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                width: 220,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 20,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromARGB(255, 231, 231, 231))),
                    SizedBox(width: 4),
                    Container(
                        height: 20,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromARGB(255, 231, 231, 231))),
                    SizedBox(width: 4),
                    Container(
                        height: 20,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromARGB(255, 231, 231, 231))),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromARGB(255, 231, 231, 231))),
              SizedBox(height: 16),
              Container(
                  height: 30,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromARGB(255, 231, 231, 231))),
              SizedBox(height: 20),
              Container(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromARGB(255, 231, 231, 231))),
                    Container(
                        height: 40,
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromARGB(255, 231, 231, 231))),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
        Column(
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
            ),
          ],
        ),
        Column(
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
            ),
          ],
        ),
      ],
    ),
  );
}
