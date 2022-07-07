class Coffee{
  final String name, image;
  final double price;

  Coffee({
    required this.name,
    required this.image,
    required this.price
  });
}

class CoffeeList {

  List<Coffee> list(){
    return [
      // Coffee(name: 'Caramel Macchiato',             image: 'assets/images/coffee_images/1_Caramel_Macchiato.png',             price: 20),
      Coffee(name: 'Caramel Cold Drink',            image: 'assets/images/coffee_images/2_Caramel_Cold_Drink.png',            price: 30),
      Coffee(name: 'Iced Coffee Mocha',             image: 'assets/images/coffee_images/3_Iced_Coffee_Mocha.png',             price: 50),
      Coffee(name: 'Caramelized Pecan Latte',       image: 'assets/images/coffee_images/4_Caramelized_Pecan_Latte.png',       price: 70),
      Coffee(name: 'Toffee Nut Latte',              image: 'assets/images/coffee_images/5_Toffee_Nut_Latte.png',              price: 100),
      Coffee(name: 'Cappuccino',                    image: 'assets/images/coffee_images/6_Cappuccino.png',                    price: 120),
      Coffee(name: 'Toffee Nut Iced Latte',         image: 'assets/images/coffee_images/7_Toffee_Nut_Iced_Latte.png',         price: 150),
      Coffee(name: 'Americano',                     image: 'assets/images/coffee_images/8_Americano.png',                     price: 175),
      Coffee(name: 'Vietnamese-Style Iced Coffee',  image: 'assets/images/coffee_images/9_Vietnamese-Style_Iced_Coffee.png',  price: 210),
      Coffee(name: 'Black Tea Latte',               image: 'assets/images/coffee_images/10_Black_Tea_Latte.png',              price: 240),
      Coffee(name: 'Classic Irish Coffee',          image: 'assets/images/coffee_images/11_Classic_Irish_Coffee.png',         price: 280),
      Coffee(name: 'Toffee Nut Crunch Latte',       image: 'assets/images/coffee_images/12_Toffee_Nut_Crunch_Latte.png',      price: 300),
    ];
  }
}