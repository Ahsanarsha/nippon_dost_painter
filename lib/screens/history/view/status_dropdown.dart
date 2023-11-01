import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';

class StatusItem {
  int value;
  String name;
  StatusItem(this.value, this.name);
}

class StatusDropdownController extends GetxController {
  List<StatusItem> dropdownItems = [
    StatusItem(1, 'pending'.tr),
    StatusItem(1, 'delivered'.tr),
    StatusItem(2, 'received'.tr),
  ];
  List<DropdownMenuItem<StatusItem>>? dropdownMenuItems;
  Rx<StatusItem>? selectedItem;

  void initController() {
    dropdownMenuItems = buildDropdownMenuItems();
    selectedItem = dropdownMenuItems![0].value!.obs;
  }

  void setSelectedItem() {}

  List<DropdownMenuItem<StatusItem>> buildDropdownMenuItems() {
    List<DropdownMenuItem<StatusItem>> items = [];

    for (StatusItem statusItem in dropdownItems) {
      items.add(
        DropdownMenuItem(
          child: Text(statusItem.name),
          value: statusItem,
        ),
      );
    }
    return items;
  }
}

class StatusDropdown extends GetResponsiveView<StatusDropdownController> {
  @override
  Widget builder() {
    StatusDropdownController _dc = Get.put(StatusDropdownController());
    _dc.initController();

    return Container(
      padding: EdgeInsets.all(0.015.sw),
      width: 0.40.sw,
      height: 0.05.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.elliptical(0.03.sw, 0.03.sw)),
      ),
      child: Obx(
        () => DropdownButton<StatusItem>(
          isExpanded: true,
          dropdownColor: Colors.white,
          icon: Image.asset(downward_arrow),
          underline: SizedBox(),
          focusColor: Colors.white,
          style: TextStyle(color: top_banner_color),
          value: _dc.selectedItem!.value,
          items: _dc.dropdownMenuItems,
          onChanged: (item) {
            _dc.selectedItem!.value = item!;
          },
        ),
      ),
    );
  }
}
