import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                //ทำให้ส่วนของcontainerอยู่ข้างล่างเสมอ
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
                      Text(input, style: TextStyle(fontSize: 16.0),),
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
    print('Hello $num');

    setState(() {
      if(num == -1){
        if (input.length > 0)
        input = input.substring(0, input.length-1);
      }else{
        input = input + '$num'; //input = '$input$num';
      }

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
