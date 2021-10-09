import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple.shade100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    child: Image.asset('assets/images/XuKai.jpg'),
                  )),
              SizedBox(height: 15.0),
              Text(
                'Phutchatcha Napalai',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 5.0),
              Text(
                'Napalai_p@silpakorn.edu',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}