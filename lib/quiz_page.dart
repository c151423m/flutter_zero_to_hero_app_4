import 'dart:math';

import 'package:flutter/material.dart';

class TileInfo {
  String title;
  Color color;

  TileInfo({required this.title, required this.color});
}

List<TileInfo> tileInfoList = [
  TileInfo(title: 'Red', color: Colors.red),
  TileInfo(title: 'Green', color: Colors.green),
  TileInfo(title: 'Blue', color: Colors.blue),
  TileInfo(title: 'Orange', color: Colors.orange),
];

int score = 0;

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // if 0, show the first question page. if not , go to next question
  int currentPage = 0;

  List<bool?> boolToShow = List.generate(8, (index) => Random().nextBool());
  List<bool?> boolCheckList = List.generate(8, (index) => false);

  @override
  Widget build(BuildContext context) {
    bool everythingIsFine = true;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Quiz Page'),
      ),
      body: currentPage == 0
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.04), BlendMode.dstATop),
                  image: AssetImage("images/journey.png"),
                ),
              ),
              child: (Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Select the red Square",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Spacer(),
                  ...List.generate(
                    tileInfoList.length,
                    (index) => _customListTile(
                        title: tileInfoList[index].title,
                        color: tileInfoList[index].color),
                  ),
                  Spacer(),
                ],
              )),
            )
          : currentPage == 1
              ? Container(
                  width: double.infinity,
                  child: (Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Check Only the 'Yes' tile",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Spacer(),
                      ...List.generate(
                        boolCheckList.length,
                        (index) {
                          for (int i = 0; i < boolCheckList.length; i++) {
                            if (boolToShow[i] != boolCheckList[i]) {
                              everythingIsFine = false;
                            }
                          }
                          return CheckboxListTile(
                            value: boolCheckList[index],
                            onChanged: (valueBool) {
                              setState(() {
                                boolCheckList[index] = valueBool;
                              });
                            },
                            title: Text(boolToShow[index]! ? "Yes" : "No"),
                            tileColor: boolToShow[index] == boolCheckList[index]
                                ? Colors.green
                                : Colors.red,
                          );
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (everythingIsFine) {
                              score += 1;
                            }
                            currentPage += 1;
                            print(currentPage);
                          });
                        },
                        child: Text("Click Me"),
                      ),
                      Spacer(),
                    ],
                  )),
                )
              : Container(
                  child: Column(
                    children: [
                      Image.asset('images/commute.png'),
                      Center(
                        child: Text(
                          'Score $score',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _customListTile({required String title, required Color color}) =>
      ListTile(
        title: Text(title),
        tileColor: color,
        onTap: () {
          if (color == Colors.red) {
            print('Yes, this is Red');
            score = 1;
            print(score);
          } else {
            print('OMG THIS IS NOT RED YOU TWAT');
            score = 0;
          }
          setState(() {
            // setState meands to reset the build
            currentPage += 1;
          });
        },
      );
}
