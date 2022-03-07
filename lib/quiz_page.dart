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
//boolToShow == list of boolean (true , false etc etc )
  List<bool?> boolToShow = List.generate(8, (index) => Random().nextBool());
//boolCheckList == list of falses
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
          // if tyhe current page is 0, show below container
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.white.withOpacity(0.2), BlendMode.dstATop),
                  image: AssetImage("images/journey.png"),
                ),
              ),
              child: Container(
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
                      (index) => Container(
                        color: tileInfoList[index].color,
                        child: _customListTile(
                            title: tileInfoList[index].title,
                            color: tileInfoList[index].color),
                      ),
                    ),
                    Spacer(),
                  ],
                )),
              ),
            )
          : currentPage == 1
              // if current page == 1 show this container
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
                        // geenrate a list based on the len of boolCheckList
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
                    mainAxisAlignment: MainAxisAlignment.center,
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

// widget for LisTile. takes title and color
  Widget _customListTile({required String title, required Color color}) =>
      ListTile(
        title: Text(title),
        tileColor: color,
        onTap: () {
          if (color == Colors.red) {
            // print('Yes, this is Red');
            score = 1;
          } else {
            // print('OMG THIS IS NOT RED');
            score = 0;
          }
          setState(() {
            // setState means to reset the build
            // once tapped, it goes to next page by adding 1 to currentPage
            currentPage += 1;
          });
        },
      );
}
