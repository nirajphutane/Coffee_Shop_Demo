import 'package:coffee_shop/Models/Coffee.dart';
import 'package:flutter/material.dart';

class CoffeeListScreen extends StatefulWidget {

  @override
  _CoffeeListScreenState createState() => _CoffeeListScreenState();
}

class _CoffeeListScreenState extends State<CoffeeListScreen> {

  List<Coffee> coffeeList = [];
  late PageController nameController, imageController;
  late double initialPage = 2, currentItem, currentName;
  
  @override
  void initState() {
    currentItem = initialPage;
    currentName = initialPage;
    nameController = PageController(initialPage: initialPage.toInt());
    nameController.addListener(() {
      setState(() {
        currentName = nameController.page!;
      });
    });
    imageController = PageController(initialPage: initialPage.toInt(), viewportFraction: 0.35);
    imageController.addListener(changeItemListener);
    coffeeList = CoffeeList().list();
    super.initState();
  }

  void changeItemListener(){
    if(imageController.offset < -50){
      imageController.removeListener(changeItemListener);
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      currentItem = imageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.brown,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 120,
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: nameController,
                    scrollDirection: Axis.horizontal,
                    itemCount: coffeeList.length,
                    itemBuilder: (context, index){
                      return Opacity(
                        opacity: (1 - (index - currentName).abs()).clamp(0, 1),
                        child: Text(
                          '${coffeeList[index].name}',
                          maxLines: 2,
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        )
                      );
                    },
                  )
                ),
                Expanded(
                  flex: 4,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 150),
                    child: Text(
                      'Rs. ${coffeeList[currentItem.toInt()].price}',
                      style: TextStyle(fontSize: 22),
                      key: Key(coffeeList[currentItem.toInt()].name),
                    ),
                  ),
                )
              ],
            )
          ),

          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: imageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (page){
                if(page < coffeeList.length){
                  nameController.animateToPage(page, duration: Duration(milliseconds: 150), curve: Curves.easeOut);
                }
              },
              // itemCount: coffeeList.length + 1,
              itemCount: coffeeList.length,
              itemBuilder: (context, index) {
                if(index == 0){
                  return SizedBox.shrink();
                }
                double value = -0.4 * (currentItem - index + 1) +1;
                return Padding(
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
                        tag: coffeeList[index].name,
                        child: Image.asset(coffeeList[index-1].image, fit: BoxFit.fitHeight)
                      ),
                    )
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
    nameController.dispose();
    imageController.dispose();
    super.dispose();
  }
}
