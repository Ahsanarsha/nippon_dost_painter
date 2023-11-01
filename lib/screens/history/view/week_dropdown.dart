import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';

class WeekItem {
  int value;
  String name;
  WeekItem(this.value, this.name);
}

class WeekDropdownController extends GetxController {
  List<WeekItem> dropdownItems = [
    WeekItem(1, 'current_week'),
    WeekItem(2, 'previous_week'),
  ];
  List<DropdownMenuItem<WeekItem>>? dropdownMenuItems;
  Rx<WeekItem>? selectedItem;

  void initController() {
    dropdownMenuItems = buildDropdownMenuItems();
    selectedItem = dropdownMenuItems![0].value!.obs;
  }

  void setSelectedItem() {}

  List<DropdownMenuItem<WeekItem>> buildDropdownMenuItems() {
    List<DropdownMenuItem<WeekItem>> items = [];

    for (WeekItem weekItem in dropdownItems) {
      items.add(
        DropdownMenuItem(
          child: Text(weekItem.name.tr),
          value: weekItem,
        ),
      );
    }
    return items;
  }
}

class WeekDropdown extends GetResponsiveView<WeekDropdownController> {
  @override
  Widget builder() {
    WeekDropdownController _dc = Get.put(WeekDropdownController());
    _dc.initController();

    return Container(
      padding: EdgeInsets.all(0.02.sw),
      width: 0.40.sw,
      height: 0.05.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.elliptical(0.03.sw, 0.03.sw)),
      ),
      child: Obx(
        () => DropdownButton<WeekItem>(
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
