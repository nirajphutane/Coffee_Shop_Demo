import 'package:coffee_shop/Models/Coffee.dart';
import 'package:coffee_shop/Screens/coffee_list_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  int initPosition = 0;
  List<Coffee> coffeeList = [];
  double hide = 1;

  @override
  void initState() {
    coffeeList = CoffeeList().list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onVerticalDragUpdate: (details) async {
            if(details.primaryDelta! < -10){
              setState(() {
                hide = 0;
              });
              await Navigator.of(context).push(
                PageRouteBuilder(
                  reverseTransitionDuration: Duration(milliseconds: 300),
                  transitionDuration: Duration(milliseconds: 650),
                  pageBuilder: (context, animation, secondaryAnimation){
                    return FadeTransition(
                      opacity: animation,
                      child: CoffeeListScreen(initialPage: initPosition+3),
                    );
                  }
                )
              );
              setState(() {
                hide = 1;
              });
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

              AnimatedPositioned(
                top: hide == 1 ? 170.0 : 130.0,
                left: 00,
                right: 00,
                bottom: 400,
                duration: Duration(milliseconds: 150),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 150),
                  opacity: hide,
                  child: Image.asset(
                    coffeeList[initPosition].image,
                  ),
                ),
              ),

              Positioned(
                top: 80,
                left: 40,
                right: 40,
                height: MediaQuery.of(context).size.height * 0.80,
                child: Hero(
                  tag: coffeeList[initPosition+1].name,
                  child: Image.asset(coffeeList[initPosition+1].image, fit: BoxFit.contain),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.40,
                left: 0,
                right: 0,
                bottom: 0,
                child: Hero(
                  tag: coffeeList[initPosition+2].name,
                  child: Image.asset(coffeeList[initPosition+2].image, fit: BoxFit.cover),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.80,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height,
                child: Hero(
                  tag: coffeeList[initPosition+3].name,
                  child: Image.asset(coffeeList[initPosition+3].image, fit: BoxFit.cover),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.60 ,
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
