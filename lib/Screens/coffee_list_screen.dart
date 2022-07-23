import 'package:coffee_shop/Models/Coffee.dart';
import 'package:coffee_shop/Screens/coffee_details_screen.dart';
import 'package:flutter/material.dart';

class CoffeeListScreen extends StatefulWidget {

  final double initialPage;
  CoffeeListScreen({
    required this.initialPage
  });

  @override
  _CoffeeListScreenState createState() => _CoffeeListScreenState();
}

class _CoffeeListScreenState extends State<CoffeeListScreen> {

  List<Coffee> coffeeList = [];
  late PageController coffeeNameController, coffeeImageController;
  late double currentCoffee, currentCoffeeName;
  int milliseconds = 650;

  @override
  void initState() {
    currentCoffee = widget.initialPage;
    currentCoffeeName = widget.initialPage;
    coffeeNameController = PageController(initialPage: widget.initialPage.toInt());
    coffeeNameController.addListener(() {
      setState(() {
        currentCoffeeName = coffeeNameController.page!;
      });
    });
    coffeeImageController = PageController(initialPage: widget.initialPage.toInt(), viewportFraction: 0.35);
    coffeeImageController.addListener(changeItemListener);
    coffeeList = CoffeeList().list();
    super.initState();
  }

  void changeItemListener(){
    if(coffeeImageController.offset < -50){
      coffeeImageController.removeListener(changeItemListener);
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      currentCoffee = coffeeImageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.brown),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 120,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              duration: Duration(milliseconds: 500),
              builder: (context, value, child){
                return Transform.translate(
                  offset: Offset(0 * value, -100 * value),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: PageView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          controller: coffeeNameController,
                          scrollDirection: Axis.horizontal,
                          itemCount: coffeeList.length,
                          itemBuilder: (context, index){
                            return Opacity(
                              opacity: (1 - (index - currentCoffeeName).abs()).clamp(0, 1),
                              child: Hero(
                                tag: coffeeList[index].price,
                                child: Material(
                                  child: Text(
                                    '${coffeeList[index].name}',
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            );
                          },
                        )
                      ),
                      Expanded(
                        flex: 4,
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: milliseconds),
                          child: Text(
                            '₹ ${coffeeList[currentCoffee.toInt()].price}',
                            style: TextStyle(fontSize: 22),
                            key: Key(coffeeList[currentCoffee.toInt()].name),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: coffeeImageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (page){
                if(page < coffeeList.length){
                  coffeeNameController.animateToPage(page, duration: Duration(milliseconds: milliseconds), curve: Curves.easeOut);
                }
              },
              itemCount: coffeeList.length,
              itemBuilder: (context, index) {
                if(index == 0){
                  return SizedBox.shrink();
                }
                double value = -0.4 * (currentCoffee - index + 1) +1;
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        reverseTransitionDuration: Duration(milliseconds: 150),
                        transitionDuration: Duration(milliseconds: milliseconds),
                        pageBuilder: (context, animation, secondaryAnimation){
                          return FadeTransition(
                            opacity: animation,
                            child: CoffeeDetailsScreen(coffee: coffeeList[index-1]),
                          );
                        }
                      )
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(
                            0.0,
                            MediaQuery.of(context).size.height / 2.6 * (1 - value).abs()
                        )
                        ..scale(value),
                      child: Opacity(
                        opacity: value.clamp(0, 1),
                        child: Hero(
                          tag: coffeeList[index-1].name,
                          child: Image.asset(coffeeList[index-1].image, fit: BoxFit.fitHeight)
                        ),
                      )
                    ),
                  ),
                );
              }
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            top: MediaQuery.of(context).size.height * 0.82,
            height: MediaQuery.of(context).size.height * 0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    spreadRadius: 45
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    coffeeNameController.dispose();
    coffeeImageController.dispose();
    super.dispose();
  }
}