import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:polymarq/technicians/home_screen/model/tool_category.dart';

final toolCatergoryItemProvider = StateProvider<ToolCategory?>((ref) => null);

final toolPageProvider = StateProvider((ref) => 1);