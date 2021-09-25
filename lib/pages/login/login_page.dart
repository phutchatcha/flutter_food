import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_food/pages/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var input = '';

  void _showDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "ERROR!",
            style: TextStyle(color: Colors.black),
          ),
          content: Text("Invalid PIN. Please try again!"),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.pink.shade100,
              Colors.blue.shade100,
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
                      ),
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        'Enter PIN to login',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for(int i=0;i<input.length;i++)
                              Icon(Icons.circle,size: 30,color: Colors.indigo.shade400,),
                            for(int i=0;i<6-input.length;i++)
                              Icon(Icons.circle,size: 30,color: Colors.indigo.shade200,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                //color: Colors.pink,
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
                          child: LoginButton(
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

  void _handleClickButton(int num) {
    print('Press $num');

    setState(() {
      if(num == -1){
        if (input.length > 0)
        input = input.substring(0, input.length-1);
      }else{
        input = input + '$num'; //input = '$input$num';
      }
      if (input.length == 6) {
        if (input == '123456') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => homePage(),
            ),
          );
        }
        else {
          _showDialog();
          input = '';
        }
      }
      print('$input');
    });
  }
}

class LoginButton extends StatelessWidget {
  final int number;
  final Function(int) onClick;

  const LoginButton({
    required this.number,
    required this.onClick, //ส่งพารามิเตอร์มาเมื่อปุ่มถูกกด
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //ทำให้ปุ่มกดได้
      customBorder: CircleBorder(),
      onTap:number == -2 ? null : () => onClick(number),
      child: Container(
          width: 80.0,
          height: 80.0,
          decoration: number == -2
              ? null
              : BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2.0),
                ),
          child: Center(
            child: number >= 0
                ? Text(
                    '$number', //number.toString()
                    style: Theme.of(context).textTheme.headline6,
                  )
                : (number == -1
                    ? Icon(
                        Icons.backspace_outlined,
                        size: 28.0,
                      )
                    : SizedBox.shrink()),
          )),
    );
  }
}
