import 'package:flutter/material.dart';
import 'package:flutter_food/models/api_result.dart';
import 'package:flutter_food/pages/home/foodlistpage.dart';
import 'package:flutter_food/pages/home/orderpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_food/models/food_item.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int _selectedBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _selectedBottomNavIndex == 0
              ? FoodListPage() : OrderPage()),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: 'Your Order'),
        ],
        currentIndex: _selectedBottomNavIndex,
        fixedColor: Colors.green.shade400,
        //สีปุ่มที่เลือก
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _fetchFoods,
        child: Icon(Icons.add,),
        backgroundColor: Colors.deepPurple.shade300,
      ),*/
    );
  }

  void _test() async {
    var url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
    var response = await http.get(url); //await >> then

    if (response.statusCode == 200) {
      //ดึงค่า response.body(เป็น String) ออกมา
      Map<String, dynamic> jsonBody = json.decode(response.body);
      //json.decode แปลง json(String) >> dart,list
      String status = jsonBody['status'];
      String? message = jsonBody['message'];
      List<dynamic> data = jsonBody['data'];

     // print('STATUS: $status');
     // print('MESSAGE: $message');
      //print('data: $data');

      //element คือ map แต่ละตัวใน list
      var foodList = data.map((element) =>
          FoodItem(
            id: element['id'],
            name: element['name'],
            price: element['price'],
            image: element['image'],
          )).toList();

      /*data.forEach((element) {
      FoodItem(
        id: element['id'],
        name: element['name'],
        price: element['price'],
        image: element['image'],
      );
    });*/
    }
    /*_fetchFoods() async {
    try {
      var list = (await _fetch('foods')) as List<dynamic>;
      var foodList = list.map((item) => FoodItem.fromJson(item)).toList();
      print('Number of foods: ${foodList.length}');
    } catch (e) {
      var msg = 'ERROR: $e';
      print(msg);
    }
  }*/
    /* Future<dynamic> _fetch(String endPoint) async {
    var url = Uri.parse('https://cpsu-test-api.herokuapp.com/$endPoint');
    final response = await http.get(url);

    if (response.statusCode == 200) {//ดึงค่า response.body ออกมา
      Map<String, dynamic> jsonBody = json.decode(response.body);

      var result = ApiResult.fromJson(jsonBody);

      print('STATUS: $result.status');
      print('Message: $result.message');
      print('Data: $result.data');

      if (result.status == 'ok') {
        return result.data;
      } else {
        throw Exception(result.message);
      }*/
/*print(jsonBody['status']);
      print(jsonBody['data']);
      if (jsonBody['status'] == 'ok') {
        return jsonBody['data'];
      } else {
        throw Exception(jsonBody['message']);
      }*/
    /*  else {
      throw Exception('Server connection failed!');

  }*/
  }
}
