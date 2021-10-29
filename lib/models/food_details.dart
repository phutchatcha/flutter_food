
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_item.dart';

class FoodDetail extends StatefulWidget {
  static const routeName = '/details';
  const FoodDetail({Key? key}) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    var foods = ModalRoute.of(context)!.settings.arguments as FoodItem;

    return Scaffold(
      appBar: AppBar(
        title: Text('${foods.name}'),
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: Container(

        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              AspectRatio(
                aspectRatio: 3 / 2,
                child: Image.network(
                  foods.image,
                  fit: BoxFit.cover,
                ),
                /*child: Image.asset(
                'assets/images/${foodItem.image}',
                fit: BoxFit.cover,
              ),*/
              ),
              //SizedBox(height: 20.0),
              Padding(padding: const EdgeInsets.all(5.0),
              child: Text(
                'ชื่อเมนู: ${foods.name}',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              ),
              Padding(padding: const EdgeInsets.all(0.0),
              child: Text(
                'ราคา: ${foods.price} บาท',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
