import 'package:flutter/material.dart';
import 'package:flutter_food/pages/home/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Colors.purple.shade100,
              Colors.green.shade200,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 100.0,
                        color: Colors.deepPurple.shade300,
                      ),
                      Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.deepPurple.shade300,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Enter PIN to login',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 80.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < input.length; i++)
                            Container(
                              margin: EdgeInsets.all(4.0),
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade300,
                                  shape: BoxShape.circle),
                            ),
                          for (var i = input.length; i < 6; i++)
                            Container(
                              margin: EdgeInsets.all(4.0),
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade200,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                //color: Colors.pinkAccent,
                child: Column(
                  children: [
                    [1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9],
                    [-2, 0, -1],
                  ].map((row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: item == -2
                              ? LoginButton(
                            number: item,
                            onClick: _handleClickButton,
                          )
                              : LoginButton(
                            number: item,
                            onClick: _handleClickButton,
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String password = '123456';
  var input = '';
  void _handleClickButton(int num)async {
    setState(() {
      if (num == -1) {
        if (input.length > 0) {
          input = input.substring(0, input.length - 1);
        }
      } else {
        input = '$input$num'; //ตัวเลขที่กดเข้ามา
      }
      if (input.length == 6) {
        //call API
        _api();
      }
    });
  }
  void _api() async {
    var url = Uri.parse('https://cpsu-test-api.herokuapp.com/login');
    var response = await http.post(url, body: {
      'pin': input
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      String status = jsonBody['status'];
      String? message = jsonBody['message'];
      bool data = jsonBody['data'];

      print('STATUS: $status');
      print('MESSAGE: $message');
      print('DATA: $data');
      if (data) {
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else {
        _showMaterialDialog('ERROR', 'Invalid PIN. Please try again.');
        setState(() {
          input = '';
        });
      }
    }
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


class LoginButton extends StatelessWidget {
  final int number;
  final Function(int) onClick;

  const LoginButton({
    required this.number,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: number == -2 ? null : () => onClick(number),

      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: number == -2
            ? null
            : BoxDecoration(
            shape: BoxShape.circle,

            color: Colors.white24),
        child: Center(
          child: number >= 0
              ? Text(
            number.toString(),
            style: Theme.of(context).textTheme.headline6,
          )
              : (number == -1
              ? Icon(
            Icons.backspace_outlined,
            size: 24.0,
          )
              : SizedBox.shrink()), //ว่าง
        ),
      ),
    );
  }
}