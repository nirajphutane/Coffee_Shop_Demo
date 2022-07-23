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
          actions: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                IconButton(
                  icon: Icon(Icons.add_card_sharp, color: Colors.brown),
                  onPressed: () { },
                ),
              ],
            ),
            SizedBox(width: 10)
          ],
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

            const SizedBox(height: 50),

            Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.75,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5)],
                    ),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(Icons.add, size: 25),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
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
                              '₹ ${widget.coffee.price}',
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
                ),
              ],
            ),

            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset('assets/images/coffee_size_icons/taza_s.png', width: 40, height: 40,),
                  const SizedBox(width: 25),
                  Image.asset('assets/images/coffee_size_icons/taza_m.png', width: 40, height: 40,),
                  const SizedBox(width: 25),
                  Image.asset('assets/images/coffee_size_icons/taza_l.png', width: 40, height: 40,),
                ],
              ),
            ),

            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Hot/Warm', style: TextStyle(color: Colors.brown, fontSize: 18)),
                  const SizedBox(width: 25),
                  Text('Cold/Ice', style: TextStyle(color: Colors.grey, fontSize: 18)),
                ],
              ),
            ),
          ],
        )
    );
  }
}
