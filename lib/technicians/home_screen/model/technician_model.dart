import 'package:polymarq/technicians/home_screen/model/Job_list_model.dart' as jobList;

class TechnicianModel {

  TechnicianModel({
    required this.job,
    required this.companyName,
    required this.image,
    required this.days,
    required this.hours,
    required this.distance,
    this.jobData,
  });
  final String job;
  final String companyName;
  final String image;
  final String days;
  final String hours;
  final String distance;
  final jobList.Data? jobData;
}

List<TechnicianModel> techs = [
  TechnicianModel(
      job: 'Electronic repair',
      companyName: 'Electricity Regulatory Commission (NERC)',
      image: 'assets/images/electronic_repair.png',
      days: '25',
      hours: '10',
      distance: '12',
  ),
  TechnicianModel(
      job: 'Laboratory Technician',
      companyName: 'St. Nicholas Hospital',
      image: 'assets/images/hospital.png',
      days: '11',
      hours: '5',
      distance: '2',
  ),
  TechnicianModel(
      job: 'Automotive Technician',
      companyName: 'carmart.ng',
      image: 'assets/images/cart_mart.png',
      days: '5',
      hours: '10',
      distance: '8',
  ),
  TechnicianModel(
      job: 'Laboratory Technician',
      companyName: 'St. Nicholas Hospital',
      image: 'assets/images/hospital.png',
      days: '25',
      hours: '10',
      distance: '12',
  ),
];
