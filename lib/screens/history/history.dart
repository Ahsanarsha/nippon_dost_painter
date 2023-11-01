import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/screens/history/bloc/cash_history_bloc.dart';
import 'package:nippon_dost/screens/history/view/cash_history.dart';
import 'package:nippon_dost/screens/history/view/points_history.dart';
import 'package:nippon_dost/screens/history/view/order_history.dart';
import 'package:nippon_dost/screens/qr/qr_scan_history_screen.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'bloc/order_scan_history_bloc.dart';
import 'bloc/points_history_bloc.dart';
class HistoryTabsController extends GetxController
    with SingleGetTickerProviderMixin {
  DateTimeRange? filterDate;
  DateTime? startingDate;
  DateTime? endingDate;
  final RxInt tabIndex = 0.obs;



   List<Tab> historyTabs = <Tab>[
    Tab(
      child: Text('order_history'.tr),
    ),
    Tab(
      child: Text('points_redemption_history'.tr),
    ),
    Tab(
      child: Text('cash_redemption_history'.tr),
    ),
     Tab(
       child: Text('Qr Code Scan History'),
     ),
  ];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    // getHistory();
    tabController = TabController(vsync: this, length: historyTabs.length + 1);
  }

  getHistory()async{
    await orderScanHistoryBloc.orderScanHistoryRequest();
    await pointsHistoryBloc.pointsHistoryRequest();
    await cashHistoryBloc.cashHistoryRequest();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void changeTabIndex(int index) {
   if(index == 3){
     Get.to(QrScanHistoryScreen());
   }else {
     tabIndex.value = index;
   }
  }
}

class History extends GetResponsiveView<HistoryTabsController> {

  @override
  Widget builder() {
    HistoryTabsController _htc = Get.put(HistoryTabsController());
    _htc.getHistory();
    _htc.historyTabs = <Tab>[
      Tab(
        child: Text('order_history'.tr),
      ),
      Tab(
        child: Text('points_redemption_history'.tr),
      ),
      Tab(
        child: Text('cash_redemption_history'.tr),
      ),
      Tab(
        child: Text('Qr Code Scan History'),
      ),
    ];

    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          width: 1.0.sw,
          height: 0.25.sh,
          decoration: BoxDecoration(
            color: top_banner_color,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                top_banner_gradient_begin, //Begin
                top_banner_gradient_end, //End
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 1.0.sw,
                height: 0.15.sh,
                padding: EdgeInsets.symmetric(vertical: 0.01.sh, horizontal: 0.05.sw),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 0.40.sw,
                          child: Text(
                            'history'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sm,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // WeekDropdown(),
                        Row(
                          children: [


                            IconButton(
                              onPressed: ()async{
                                if(_htc.tabIndex.value==0)
                                await orderScanHistoryBloc.orderScanHistoryRequest();
                                if(_htc.tabIndex.value==1)
                                  await pointsHistoryBloc.pointsHistoryRequest();
                                if(_htc.tabIndex.value==2)
                                  await cashHistoryBloc.cashHistoryRequest();
                              }, icon: Icon(Icons.refresh, color: Colors.white,size: 30),),
                          Obx(()=> orderScanHistoryBloc.showFiltered.value? IconButton(
                             onPressed: ()async{
                               hideFilterData();
                             },
                             icon: Image.asset('assets/images/clear_filter.png', scale:3.5,),
                             // icon: Icon(Icons.update_rounded, color: Colors.white, size: 30,),
                           ) :  IconButton(
                              onPressed: ()async{
                                print('button clicked');
                               await showCalender();
                              }, icon: Icon(Icons.filter_list_alt, color: Colors.white, size: 30,),
                              // Text('Filter Date', style: TextStyle(
                              //   color: Colors.white,
                              //   fontSize: 20.sm,
                              //   fontWeight: FontWeight.w500,
                              // ),
                            ),)
                          ],
                        ),

                        // Container(
                        //   width: 0.40.sw,
                        //   height: 0.05.sh,
                        // )
                      ],
                    ),
                    // Obx(
                    //   () => Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: <Widget>[
                    //       _htc.tabIndex.value == 1
                    //           ? StatusDropdown()
                    //           : Container(
                    //               width: 0.40.sw,
                    //               height: 0.05.sh,
                    //             ),
                    //       DateDropdown(),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              TabBar(
                labelColor: Colors.white,
                tabs: _htc.historyTabs,
                controller: _htc.tabController,
                onTap: (index) {
                  _htc.changeTabIndex(index);
                },
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.transparent,
              )
            ],
          ),
        ),
        Flexible(
          child: TabBarView(
            controller: _htc.tabController,
            children: <Widget>[
              OrderHistory(),
              PointsHistory(),
              CashHistory(),
            ],
          ),
        ),
      ],
    );
  }

  void hideFilterData(){
    orderScanHistoryBloc.showFiltered.value = false;
    pointsHistoryBloc.showFiltered.value = false;
    cashHistoryBloc.showFiltered.value = false;
    Fluttertoast.showToast(
        msg: "All History Data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1
    );
  }

  Future<Widget> showCalender() async{
    var responseWidget = await showDialog(
        barrierColor: Colors.white,
        context: Get.context!,
        builder: (context) => SfDateRangePicker(
          allowViewNavigation: false,
          view: DateRangePickerView.month,
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,

          monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
        )
    );
    return Scaffold(
      appBar: mainAppBar,
      // body: responseWidget,
      body: Text('am here'),
      // body: showDialog(
      //     barrierColor: Colors.white,
      //     context: Get.context!,
      //     builder: (context) => SfDateRangePicker(
      //       allowViewNavigation: false,
      //       view: DateRangePickerView.month,
      //       onSelectionChanged: _onSelectionChanged,
      //       selectionMode: DateRangePickerSelectionMode.range,
      //
      //       monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
      //     )
      // ),
    );

  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      print('date is PickerDate range');
      print(args.value.startDate);
      // controller.startingDate = DateTime.parse(DateFormat('dd/MM/yyyy').format(args.value.startDate));
      if(args.value.startDate!=null && args.value.endDate!=null){
        controller.startingDate = DateTime.parse(args.value.startDate.toString());
        controller.endingDate = DateTime.parse(args.value.endDate!.toString());
        // controller.endingDate = DateTime.parse(DateFormat('dd/MM/yyyy').format(args.value.startDate));
        orderScanHistoryBloc.filterData(startDate: controller.startingDate!, endDate: controller.endingDate!);
        pointsHistoryBloc.filterData(startDate: controller.startingDate!, endDate: controller.endingDate!);
        cashHistoryBloc.filterData(startDate: controller.startingDate!, endDate: controller.endingDate!);
        Get.back();
      }

    } else if (args.value is DateTime) {
      print('date is DateTime');
    } else if (args.value is List<DateTime>) {
      print('date is List of DateTime');
    } else {
      print('Date format is not handled');
    }
  }
}
