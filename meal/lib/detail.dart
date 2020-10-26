import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/main.dart';

class MealsDetail extends StatelessWidget {
  final Meals meals;
  const MealsDetail({Key key, this.meals}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meals Details"),
      ),
      body: Container(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(8)),
            meals.strMeal == null
                ? Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTKfaZhbCD28BohOC2ktAN1nY_GOPLaiiOxAA&usqp=CAU",
                    height: 200,
                  )
                : Image.network(
                    meals.strMeal,
                    height: 300,
                  ),
            Padding(padding: EdgeInsets.all(5)),
            meals.strMealThumb == null
                ? Text("Don't have Meals")
                : Text(meals.strMealThumb),
            meals.strCategory == null
                ? Text("Don't have Category")
                : Text(meals.strCategory),
            meals.strArea == null
                ? Text("Don't have Area")
                : Text(meals.strArea),
            meals.strTags == null
                ? Text("Don't have Tags")
                : Text(meals.strTags),
          ],
        ),
      )),
    );
  }
}
