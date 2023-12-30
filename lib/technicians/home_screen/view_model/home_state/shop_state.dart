import 'package:equatable/equatable.dart';
import 'package:polymarq/technicians/home_screen/model/tool_category.dart';


abstract class ShopToolState extends Equatable {
  const ShopToolState();

  @override
  List<Object> get props => [];
}

class ShopToolInitial extends ShopToolState {}

/// login state
class ShopToolCategoryLoading extends ShopToolState {}

class ShopToolCategoryLoaded extends ShopToolState {
  const ShopToolCategoryLoaded( {required this.data});
  final List<ToolCategory> data;
  @override
  List<Object> get props => [];
}

class ShopToolCategoryFailure extends ShopToolState {
  const ShopToolCategoryFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class ShopToolCategorySuccess extends ShopToolState {
  const ShopToolCategorySuccess({required this.message, required this.data});
  final String message;
  final List<ToolCategory> data;
  @override
  List<Object> get props => [message];
}
