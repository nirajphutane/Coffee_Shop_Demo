import 'package:coffee_shop/Models/Coffee.dart';
import 'package:coffee_shop/Screens/coffee_list_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  int initPosition = 1;
  List<Coffee> coffeeList = [];

  @override
  void initState() {
    coffeeList = CoffeeList().list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onVerticalDragUpdate: (details){
            if(details.primaryDelta! < -10){
              Navigator.of(context).push(
                PageRouteBuilder(
                  reverseTransitionDuration: Duration(milliseconds: 100),
                  transitionDuration: Duration(milliseconds: 300),
                  pageBuilder: (context, animation, secondaryAnimation){
                    return FadeTransition(
                      opacity: animation,
                      child: CoffeeListScreen(),
                    );
                  }
                )
              );
            }
          },
          child: Stack(
            children: [
              SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0X8FFA89276),
                        Colors.white
                      ]
                    )
                  ),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                right: 0,
                left: 0,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Hero(
                  tag: coffeeList[initPosition].name,
                  child: Image.asset(coffeeList[initPosition].image),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.32,
                right: 0,
                left: 0,
                bottom: 70,
                child: Hero(
                  tag: coffeeList[initPosition+1].name,
                  child: Image.asset(coffeeList[initPosition+1].image, fit: BoxFit.cover),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.8,
                right: 0,
                left: 0,
                height: MediaQuery.of(context).size.height,
                child: Hero(
                  tag: coffeeList[initPosition+2].name,
                  child: Image.asset(coffeeList[initPosition+2].image, fit: BoxFit.cover),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.52 ,
                right: 0,
                left: 0,
                height: 140,
                child: Image.asset('assets/images/app_icons/logo.png'),
              ),
            ],
          ),
        )
    );
  }
}
