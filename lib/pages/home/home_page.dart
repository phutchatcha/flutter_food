import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/pages/home/foodpage.dart';
import 'package:flutter_food/pages/home/profilepage.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _subPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _subPageIndex == 0 ? Text('FOOD') : Text('PROFILE'),
        backgroundColor: Colors.deepPurple.shade200,
      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade200,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        child: Image.asset('assets/images/XuKai.jpg'),
                      )),
                  Text(
                    'Phutchatcha Napalai',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  Text(
                    'Napalai_p@silpakorn.edu',
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: _subPageIndex == 0
                  ? _buildDrawerItem(
                  Icon(Icons.fastfood, color: Colors.purple.shade300),
                  Text(
                    'Food',
                    style: TextStyle(color: Colors.purple.shade300),
                  ))
                  : _buildDrawerItem(Icon(Icons.fastfood), Text('Food')),
              onTap: () => _showSubPage(0),
            ),
            ListTile(
              title: _subPageIndex == 1
                  ? _buildDrawerItem(
                  Icon(Icons.person, color: Colors.purple.shade300),
                  Text(
                    'Profile',
                    style: TextStyle(color: Colors.purple.shade300),
                  ))
                  : _buildDrawerItem(Icon(Icons.person), Text('Profile')),
              onTap: () => _showSubPage(1),
            ),
          ],
        ),
      ),
      body: Container(
        child: _buildSubPage(),
      ),
    );
  }

  _showSubPage(int index) {
    setState(() {
      _subPageIndex = index;
    });
    Navigator.of(context).pop();
  }

  _buildSubPage() {
    switch (_subPageIndex) {
      case 0: // home page
        return FoodPage();
      case 1:
        return ProfilePage();
      default:
        return SizedBox.shrink();
    }
  }

  Row _buildDrawerItem(Widget icon, Widget title) {
    return Row(
      children: [icon, SizedBox(width: 8.0), title],
    );
  }
}