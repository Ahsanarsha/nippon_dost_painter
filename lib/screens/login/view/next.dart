import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/controllers/text_field_controller.dart';
import 'package:nippon_dost/models/my_notification_model.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/screens/app_widgets/loading_widget.dart';
import 'package:nippon_dost/screens/login/bloc/login_bloc.dart';
import 'package:nippon_dost/services/notification_sp_services.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class Next extends StatefulWidget {
  const Next({Key? key}) : super(key: key);

  @override
  _NextState createState() => _NextState();
}

class _NextState extends State<Next> {
  @override
  Widget build(BuildContext context) {
    TextFieldController _tfc = Get.put(TextFieldController());

    return Container(
      margin: EdgeInsets.only(top: 0.04.sh),
      height: 0.06.sh,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadow_color.withOpacity(0.18),
            blurRadius: 10,
            offset: Offset(0.42, 7.99), // Shadow position
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: main_color,
          padding: EdgeInsets.symmetric(vertical: 0.015.sh),
          fixedSize: Size.fromWidth(0.60.sw),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sm),
          ),
        ),
        child: Text(
          'next'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sm,
          ),
        ),
        onPressed: () async {
          FocusScope.of(context).unfocus();

          if (_tfc.tec.text.isEmpty) {
            _tfc.setError('* ' + 'phone_number_required'.tr);
            _tfc.change(false);
          } else if (_tfc.tec.text.length >12 && _tfc.tec.text.length<11) {
            _tfc.setError('* ' + 'phone_number_must_be_valid'.tr);
            _tfc.change(false);
          } else {
            _tfc.setError('');
            _tfc.change(true);
            loadingWidget(context);
            await loginBloc.loginRequest(_tfc.tec.text.trim());
            Get.back();
            if (loginBloc.loginModel.success != true) {
              Get.snackbar(
                'sorry'.tr,
                '${'mobile_number'.tr} ${loginBloc.loginModel.message}',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: main_color,
                colorText: Colors.white,
              );
            } else {
              loginBloc.setPhoneNumber(_tfc.tec.text.trim());
              Get.toNamed(Routes.Otp,);
            }
          }
        },
      ),
    );
  }
}
