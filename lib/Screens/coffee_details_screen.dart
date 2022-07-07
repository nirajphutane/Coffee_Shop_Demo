import 'package:coffee_shop/Models/Coffee.dart';
import 'package:flutter/material.dart';

class CoffeeDetailsScreen extends StatefulWidget {

  final Coffee coffee;
  CoffeeDetailsScreen({required this.coffee});

  @override
  _CoffeeDetailsScreenState createState() => _CoffeeDetailsScreenState();
}

class _CoffeeDetailsScreenState extends State<CoffeeDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: Colors.brown),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: widget.coffee.price,
              child: Material(
                child: Text(
                  widget.coffee.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: widget.coffee.name,
                      child: Image.asset(widget.coffee.image, fit: BoxFit.fitHeight)
                    )
                  ),

                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.05,
                    bottom: 0,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: 0.0),
                      builder: (context, value, child){
                        return Transform.translate(
                          offset: Offset(-100 * value, 150 * value),
                          child: child!
                        );
                      },
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        '${widget.coffee.price}',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                              spreadRadius: 20
                            )
                          ]
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
