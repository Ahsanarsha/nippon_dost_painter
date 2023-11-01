import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/components/navbar.dart';
import 'package:nippon_dost/models/qr_scan_history_model.dart';
import 'package:nippon_dost/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:nippon_dost/screens/qr/bloc_qr_scan_history.dart';
import 'package:nippon_dost/utils/app_colors.dart';

import '../../routes/app_pages.dart';
import '../../utils/app_images.dart';

class QrScanHistoryScreen extends StatelessWidget {
  QrScanHistoryScreen({Key? key}) : super(key: key);

  late BlocQrScanHistoryScreen bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocQrScanHistoryScreen(context);
    bloc.eventSink.add(EnumsQrScanHistory.fetchHistory);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary_color,
        foregroundColor: Colors.black,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            width: Get.width * 0.80,
            height: Get.height * 0.10,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                nippon_logo,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(question_circle),
            onPressed: () => {
              if (appBarPage != 'support_chat')
                {
                  if (appBarPage == 'notifications' || appBarPage == 'settings')
                    Get.back(),
                  Get.toNamed(Routes.SupportChat),
                  appBarPage = 'support_chat',
                }
            },
          ),
          IconButton(
              icon: Image.asset(settings),
              onPressed: () => {
                    if (appBarPage != 'settings')
                      {
                        if (appBarPage == 'notifications' ||
                            appBarPage == 'support_chat')
                          Get.back(),
                        Get.toNamed(Routes.Settings),
                        appBarPage = 'settings',
                      },
                  }),
          IconButton(
              icon: Image.asset(bell),
              onPressed: () => {
                    if (appBarPage != 'notifications')
                      {
                        if (appBarPage == 'settings' ||
                            appBarPage == 'support_chat')
                          Get.back(),
                        Get.toNamed(Routes.Notifications),
                        appBarPage = 'notifications',
                      }
                  }),
        ],
      ),
      //bottomNavigationBar: NavBar(),
      body: WillPopScope(
        onWillPop: () async {
          dashboardBloc.refreshDataWithBack();
          return true;
        },
        child: StreamBuilder<Object>(
            stream: bloc.stateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    _totalScans(context),
                    //_dataList(context),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _dataTable(context),
                          for (var items in bloc.viewModel.qrHistoryList)
                            _rowItem(label: items, context: context),
                        ],
                      ),
                      scrollDirection: Axis.horizontal,
                    ),
                    TextButton(onPressed: (){
                      bloc.viewModel.pageNumber++;
                      bloc.eventSink.add(EnumsQrScanHistory.fetchHistory);

                    }, child: Text('Load More History'))
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  _totalScans(context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff02418C),
              Color(0xff022147),
            ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bloc.viewModel.qrHistoryList.length.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Total Number of QR Code Scans',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Text(
            'QR Code Scan History',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  _dataTable(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        dataColumn(label: 'Sr.', context: context),
        dataColumn(label: 'QR Code', context: context),
        dataColumn(label: 'Batch no', context: context),
        dataColumn(label: 'QR Points', context: context),
        dataColumn(label: 'Gift name', context: context),
        dataColumn(label: 'Points Redeemed', context: context),
        dataColumn(label: 'Balance Points', context: context),
        dataColumn(label: 'Date', context: context),
      ],
      // rows:  bloc.viewModel.rowList
    );
  }

  dataColumn({required String label, required BuildContext context}) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12.0,
                color: Color(0xff03428D),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  _rowItem({required Data label, required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        itemData(
            label: label.serioalNo == null ? '-' : label.serioalNo.toString(),
            context: context),
        itemData(
            label: label.qrCode == null ? '-' : label.qrCode.toString(),
            context: context),
        itemData(
            label: label.batchNo == null ? '-' : label.batchNo.toString(),
            context: context),
        itemData(
            label: label.points == null ? '-' : label.points.toString(),
            context: context),
        itemData(
            label: label.giftName == null ? '-' : label.giftName.toString(),
            context: context),
        itemData(
            label: label.pointRedemption == null
                ? '-'
                : label.pointRedemption.toString(),
            context: context),
        itemData(
            label: label.balancePoints == null
                ? '-'
                : label.balancePoints.toString(),
            context: context),
        itemData(
            label: DateFormat('dd-MMM-yyyy HH:mm a')
                .format(DateTime.parse(label.createdAt.toString()).toLocal()),
            context: context),
      ],
      // rows:  bloc.viewModel.rowList
    );
  }

  itemData({required String label, required BuildContext context}) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
