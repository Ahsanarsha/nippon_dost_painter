import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

final List<Tab> localizedHistoryTabs = <Tab>[
  Tab(
    child: Text('order_history'.tr),
  ),
  Tab(
    child: Text('points_redemption_history'.tr),
  ),
  Tab(
    child: Text('cash_redemption_history'.tr),
  ),
];