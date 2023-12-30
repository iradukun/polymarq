class SearchModel {

  SearchModel({
    required this.job,
    required this.companyName,
    required this.image,
    required this.status,
    required this.statusText,
    required this.duration,
    required this.days,
    required this.distance,
  });
  final String job;
  final String companyName;
  final String image;
  final String status;
  final String statusText;
  final String duration;
  final String days;
  final String distance;
}

List<SearchModel> search = [
  SearchModel(
      job: 'Electronic repair',
      companyName: 'Electricity Regulatory Commission (NERC)',
      image: 'assets/images/electronic_repair.png',
      days: '32',
      distance: '23',
      duration: '12',
      status: 'assets/icons/verified.svg',
      statusText: 'Payment Verified +32/H',
  ),
  SearchModel(
      job: 'Laboratory Technician',
      companyName: 'St. Nicholas Hospital',
      image: 'assets/images/hospital.png',
      status: 'assets/icons/unverified.svg',
      days: '12',
      distance: '1',
      duration: '7',
      statusText: 'Payment not verified',
  ),
  SearchModel(
      job: 'Automotive Technician',
      companyName: 'carmart.ng',
      image: 'assets/images/cart_mart.png',
      status: 'assets/icons/verified.svg',
      days: '5',
      distance: '2',
      duration: '5',
      statusText: 'Payment Verified +32/H',
  ),
  SearchModel(
      job: 'Laboratory Technician',
      companyName: 'St. Nicholas Hospital',
      image: 'assets/images/hospital.png',
      status: 'assets/icons/unverified.svg',
      days: '32',
      distance: '23',
      duration: '12',
      statusText: 'Payment not verified',
  ),
];
