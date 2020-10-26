import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meal/detail.dart';

void main() {
  runApp(MyApp());
}

class Meals {
  final String strMeal;
  final String strMealThumb;
  final String strCategory;
  final String strArea;
  final String strTags;

  Meals(this.strMeal, this.strCategory, this.strArea, this.strTags,
      this.strMealThumb);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Meals"),
        ),
        body: MealPage(),
      ),
    );
  }
}

class MealPage extends StatefulWidget {
  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  Future<List<Meals>> getMeals() async {
    var data = await http
        .get("https://www.themealdb.com/api/json/v1/1/search.php?f=c");

    var jsonData = json.decode(data.body);

    var mealData = jsonData['meals'];
    List<Meals> meals = [];
    for (var data in mealData) {
      Meals mealItem = Meals(data['strMealThumb'], data['strCategory'],
          data['strMeal'], data['strArea'], data['strTags']);
      meals.add(mealItem);
    }
    return meals;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getMeals(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Meals meals = Meals(
                        snapshot.data[index].strMeal,
                        snapshot.data[index].strMealThumb,
                        snapshot.data[index].strCategory,
                        snapshot.data[index].strArea,
                        snapshot.data[index].strTags,
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MealsDetail(meals: meals)));
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                snapshot.data[index].strMeal == null
                                    ? Image.network(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR0w3ybznCr9bcpVdZA2N_y5KbZpyBHVax4IQ&usqp=CAU",
                                        height: 100,
                                        width: 100,
                                      )
                                    : Image.network(
                                        snapshot.data[index].strMeal,
                                        height: 100,
                                        width: 100,
                                      ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(5)),
                                    snapshot.data[index].strCategory == null
                                        ? Text("Sorry Don't have Category")
                                        : Text(
                                            snapshot.data[index].strCategory),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(5)),
                                    snapshot.data[index].strMealThumb == null
                                        ? Text("Sorry Don't have Meal")
                                        : Text(
                                            snapshot.data[index].strMealThumb),
                                  ],
                                )
                              ],
                            ),

                            //Padding(padding: EdgeInsets.all(8)),

                            //Text(snapshot.data[index].description)
                          ],
                        ),
                      ),
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
