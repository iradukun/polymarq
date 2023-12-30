import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/technicians/home_screen/model/accepted_job_model.dart';
import 'package:polymarq/technicians/home_screen/model/all_tools_model.dart';
import 'package:polymarq/technicians/home_screen/model/bank_model.dart';
import 'package:polymarq/technicians/home_screen/model/count_model.dart';
import 'package:polymarq/technicians/home_screen/model/job_request_model.dart';
import 'package:polymarq/technicians/home_screen/model/notification_model.dart';
import 'package:polymarq/technicians/home_screen/model/tool_category.dart';
import 'package:polymarq/technicians/home_screen/model/tool_model.dart';
import 'package:polymarq/technicians/home_screen/repository/home_repository_impl.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/provider.dart';

final getCategoryProvider = FutureProvider.autoDispose
    .family<List<ToolCategory>, String>((ref, query) async {
  final page = ref.watch(toolCategoryPage);

  final res =
      await ref.watch(homeRepositoryProvider).getToolsCategory(page: page);
  final rawData = Map<String, dynamic>.from(res.data as Map);

  final data = List<Map<String, dynamic>>.from(
    rawData['data'] as List<dynamic>,
  );

  final toolList = data.map(ToolCategory.fromJson).toList();
  return toolList;
});

final getCurrentUsercategoryProvider = FutureProvider.autoDispose
    .family<List<ToolCategory>, String>((ref, query) async {
  final page = ref.watch(toolCategoryPage);

  final res = await ref
      .watch(homeRepositoryProvider)
      .getCurrentUserToolsCategory(page: page);
  final rawData = Map<String, dynamic>.from(res.data as Map);

  final data = List<Map<String, dynamic>>.from(
    rawData['data'] as List<dynamic>,
  );

  final toolList = data.map(ToolCategory.fromJson).toList();
  return toolList;
});
final getJobRequestProvider = FutureProvider.autoDispose((
  ref,
) async {
  final res = await ref.watch(homeRepositoryProvider).getJobRequest();
  final rawData = Map<String, dynamic>.from(res.data as Map);

  final data = List<Map<String, dynamic>>.from(
    rawData['data'] as List<dynamic>,
  );
  print(data);
  final jobRequest = data.map(JobRequestModel.fromJson).toList();
  print('job$jobRequest');
  return jobRequest;
});

final getBankProvider = FutureProvider.autoDispose((
  ref,
) async {
  final res = await ref.watch(homeRepositoryProvider).getBanks();
  final rawData = Map<String, dynamic>.from(res.data as Map);

  final data = List<Map<String, dynamic>>.from(
    rawData['data'] as List<dynamic>,
  );
  print(data);
  final bank = data.map(BankModel.fromJson).toList();
  print('bank$bank');
  return bank;
});
final getAcceptedJobProvider = FutureProvider.autoDispose((
  ref,
) async {
  final res = await ref.watch(homeRepositoryProvider).getAcceptedJobs();
  final rawData = Map<String, dynamic>.from(res.data as Map);

  final data = List<Map<String, dynamic>>.from(
    rawData['data'] as List<dynamic>,
  );
  print(data);
  final jobRequest = data.map(AcceptedJobModel.fromJson).toList();
  print('job$jobRequest');
  return jobRequest;
});

final toolCategoryPage = StateProvider((ref) => 1);

final getAllToolProvider = FutureProvider.autoDispose
    .family<List<AllToolsModel>, String>((ref, query) async {
  final page = ref.watch(allToolsPage);

  final res = await ref.watch(homeRepositoryProvider).getAllTools(
        page: page,
      );
  final rawData = Map<String, dynamic>.from(res.data as Map);
  debugPrint('allraw $rawData');

  final data = List<Map<String, dynamic>>.from(
    rawData['data'] as List<dynamic>,
  );

  final allToolList = data.map(AllToolsModel.fromJson).toList();
  return allToolList;
});

final getNotificationCategoryPage = StateProvider((ref) => 1);

final getNotificationToolProvider = FutureProvider.autoDispose((
  ref,
) async {
  final page = ref.watch(getNotificationCategoryPage);

  final res = await ref.watch(homeRepositoryProvider).getNotification(
        page: page,
      );
  final rawData = Map<String, dynamic>.from(res.data as Map);
  debugPrint('allraw $rawData');

  final data = List<Map<String, dynamic>>.from(
    rawData['data'] as List<dynamic>,
  );

  final notificationList = data.map(NotificationModel.fromJson).toList();
  return notificationList;
});

final allToolsPage = StateProvider((ref) => 1);

final getToolProvider = FutureProvider.autoDispose
    .family<List<AllToolsModel>, String>((ref, uuid) async {
  final page = ref.watch(toolCategoryPage);

  final res =
      await ref.watch(homeRepositoryProvider).getTools(page: page, uuid: uuid);
  final rawData = Map<String, dynamic>.from(res.data as Map);
  debugPrint('raw $rawData');
  final data = List<Map<String, dynamic>>.from(
    rawData['data'] as List<dynamic>,
  );

  debugPrint('data $data');
  final toolList = data.map(AllToolsModel.fromJson).toList();
  return toolList;
});

final getMyToolProvider = FutureProvider.autoDispose
    .family<List<AllToolsModel>, String>((ref, uuid) async {
  final page = ref.watch(toolCategoryPage);

  final res = await ref
      .watch(homeRepositoryProvider)
      .getMyTools(page: page, uuid: uuid);
  final rawData = Map<String, dynamic>.from(res.data as Map);
  debugPrint('raw $rawData');
  final data = List<Map<String, dynamic>>.from(
    rawData['data'] as List<dynamic>,
  );

  debugPrint('data $data');
  final toolList = data.map(AllToolsModel.fromJson).toList();
  return toolList;
});
final getToolsProvider = FutureProvider.autoDispose<List<Tool>>((ref) async {
  final category = ref.watch(toolCatergoryItemProvider);
  final homeRepo = ref.watch(homeRepositoryProvider);
  final page = ref.watch(toolPageProvider);
  final res = await homeRepo.getOtherTools(page: page, uuid: category!.uuid!);
  final rawData = Map<String, dynamic>.from(res.data as Map);

  // ignore: avoid_dynamic_calls
  final data = rawData['data'] as List<dynamic>;
  final toolList =
      List<Map<String, dynamic>>.from(data).map(Tool.fromJson).toList();
  return toolList;
});

final getMyToolCountProvider = FutureProvider.autoDispose((ref) async {
  final res = await ref.watch(homeRepositoryProvider).myToolCount();
  debugPrint('data ${res.data}');
  final rawData = Map<String, dynamic>.from(res.data as Map);
  debugPrint('allraw $rawData');

  final count = CountModel.fromJson(rawData);

  print('my tool $count');
  return count;
});

final getOtherToolCountProvider = FutureProvider.autoDispose((ref) async {
  final res = await ref.watch(homeRepositoryProvider).otherToolCount();
  debugPrint('data ${res.data}');
  final rawData = Map<String, dynamic>.from(res.data as Map);
  debugPrint('allraw $rawData');

  final count = CountModel.fromJson(rawData);

  print('other tool $count');
  return count;
});


