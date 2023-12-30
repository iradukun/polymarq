class ProductModel {

  ProductModel({
    required this.image,
    required this.name,
  });
  final String image;
  final String name;
}

List<ProductModel> product = [
  ProductModel(
    image: 'assets/images/tool1.png',
    name: 'Screw Removal',
  ),
  ProductModel(
    image: 'assets/images/tool2.png',
    name: 'Specialty Drivers',
  ),
  ProductModel(
    image: 'assets/images/tool3.png',
    name: 'Wrenches',
  ),
  ProductModel(
    image: 'assets/images/tool4.png',
    name: 'Wrench Sets',
  ),
  ProductModel(
    image: 'assets/images/tool5.png',
    name: 'Processing',
  ),
  ProductModel(
    image: 'assets/images/tool6.png',
    name: 'Screw Removal',
  ),
];
