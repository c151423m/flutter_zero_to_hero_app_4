import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Quiz Page'),
      ),
      body: Container(
        width: double.infinity,
        child: (Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Select the red Square"),
            _customListTile(title: 'Red', color: Colors.red),
            _customListTile(title: 'Blue', color: Colors.blue),
            _customListTile(title: 'Green', color: Colors.green),
            _customListTile(title: 'Orange', color: Colors.orange)
          ],
        )),
      ),
    );
  }

  Widget _customListTile({required String title, required Color color}) =>
      ListTile(
        title: Text(title),
        tileColor: color,
        onTap: () {
          print(title);
        },
      );
}
