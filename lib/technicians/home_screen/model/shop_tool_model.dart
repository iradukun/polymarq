class ShopToolsModel {
  ShopToolsModel({
    required this.price,
    required this.status,
  });

  final String price;
  final String status;
}

List<ShopToolsModel> shop = [
  ShopToolsModel(price: '05.3', status: 'No Negotiable'),
  ShopToolsModel(price: '02.7', status: 'No Negotiable'),
  ShopToolsModel(price: '05.3', status: 'No Negotiable'),
  ShopToolsModel(price: '11.4', status: 'Negotiable'),
  ShopToolsModel(price: '20.8', status: 'Negotiable'),
  ShopToolsModel(price: '05.9', status: 'Negotiable'),
  ShopToolsModel(price: '14.5', status: 'Negotiable'),
  ShopToolsModel(price: '05.3', status: 'No Negotiable'),
  ShopToolsModel(price: '37.0', status: 'No Negotiable'),
  ShopToolsModel(price: '05.8', status: 'Negotiable'),
  ShopToolsModel(price: '98.3', status: 'Negotiable'),
  ShopToolsModel(price: '50.3', status: 'Negotiable'),
  ShopToolsModel(price: '28.5', status: 'No Negotiable'),
  ShopToolsModel(price: '12.3', status: 'No Negotiable'),
  ShopToolsModel(price: '05.3', status: 'No Negotiable'),
];

class CalenderModel {
  CalenderModel({required this.date, required this.day});

  final String date;
  final String day;
}

List<CalenderModel> calender = [
  CalenderModel(date: '31', day: 'M'),
  CalenderModel(date: '1', day: 'T'),
  CalenderModel(date: '2', day: 'W'),
  CalenderModel(date: '3', day: 'TH'),
  CalenderModel(date: '4', day: 'F'),
];
