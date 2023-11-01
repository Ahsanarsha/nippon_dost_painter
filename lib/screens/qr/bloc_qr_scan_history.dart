import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nippon_dost/resources/repoitory.dart';
import 'package:nippon_dost/screens/qr/viewmodel_qr_scan_history.dart';

enum EnumsQrScanHistory {
  fetchHistory,
}

class BlocQrScanHistoryScreen {
  ViewModelQrScanHistory viewModel = ViewModelQrScanHistory();

  // STATE CONTROLLER
  final stateController = StreamController<Object>();

  StreamSink<Object> get stateSink => stateController.sink;

  Stream<Object> get stateStream => stateController.stream;

  // EVENTS CONTROLLER
  final eventController = StreamController<Object>();

  StreamSink<Object> get eventSink => eventController.sink;

  BlocQrScanHistoryScreen(context) {
    eventController.stream.listen((event) {
      switch (event) {
        case EnumsQrScanHistory.fetchHistory:
          _fetchData();
          break;
      }
    });
  }

  _fetchData() async {
    viewModel.qrHistoryList = viewModel.qrHistoryList + await Repository().postQrScanHistoryRequest(viewModel.pageNumber);
    viewModel.qrHistoryList.forEach((element) {
      viewModel.rowList.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Expanded(
                child: Center(
                    child: Text(
              '${element.serioalNo}',
              style: TextStyle(fontSize: 12.0),
            )))),
            DataCell(Expanded(
                child: Center(
                    child: Text(
              '${element.qrCode}',
              style: TextStyle(fontSize: 12.0),
            )))),
            DataCell(Expanded(
                child: Center(
                    child: Text(
              '${element.batchNo}',
              style: TextStyle(fontSize: 12.0),
            )))),
            DataCell(Expanded(
                child: Center(
                    child: Text(
              '${element.points}',
              style: TextStyle(fontSize: 12.0),
            )))),
            DataCell(Expanded(
                child: Center(
                    child: Text(
              '${element.balancePoints}',
              style: TextStyle(fontSize: 12.0),
            )))),
          ],
        ),
      );
    });
    _update();
  }

  _update() {
    stateSink.add(viewModel.qrHistoryList);
  }
}
