import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nippon_dost/components/txt_field.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';

class DateDropdownController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  void setNewDate() {
    showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2021, 11),
      lastDate: DateTime(2101),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      selectedDate.value = pickedDate;
    });
  }
}

class DateDropdown extends GetResponsiveView<DateDropdownController> {
  @override
  Widget builder() {
    DateDropdownController _ddc = Get.put(DateDropdownController());

    return Container(
      // padding: EdgeInsets.all(0.02.sw),
      width: 0.40.sw,
      height: 0.05.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.elliptical(0.03.sw, 0.03.sw)),
      ),
      child: Obx(
        () => InkWell(
          onTap: () {
            _ddc.setNewDate();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                DateFormat('dd-MM-yyyy').format(_ddc.selectedDate.value),
                style: TextStyle(
                  color: top_banner_color,
                ),
              ),
              Image.asset(calendar),
            ],
          ),
        ),
      ),
    );
  }
}
