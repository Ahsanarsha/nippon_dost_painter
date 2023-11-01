import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<dynamic> sendLoginRequest(String primaryNumber) => apiProvider.postLoginRequest(primaryNumber);

  Future<dynamic> sendOtpRequest(String primaryNumber, String otp) => apiProvider.postOtpRequest(primaryNumber, otp);

  Future<dynamic> sendDashboardRequest() => apiProvider.postDashboardRequest();

  Future<dynamic> sendProfileRequest() => apiProvider.postProfileRequest();

  Future<dynamic> sendGiftRequest() => apiProvider.getGiftRequest();

  Future<dynamic> sendOrderScanHistoryRequest() => apiProvider.postOrderScanHistoryRequest();

  Future<dynamic> sendOrderScanSingleHistoryRequest(String orderId) => apiProvider.postOrderScanSingleHistoryRequest(orderId);

  Future<dynamic> sendCashScanHistoryRequest() => apiProvider.getCashHistoryRequest();

  Future<dynamic> sendPointsScanHistoryRequest() => apiProvider.getPointsHistoryRequest();

  Future<dynamic> sendQrScanRequest(String qrCode) => apiProvider.postQrScanRequest(qrCode);

  Future<dynamic> sendQrRedeemRequest(List<int> qrIds) => apiProvider.postQrRedeemRequest(qrIds);

  Future<dynamic> sendLogoutRequest() => apiProvider.getLogout();

  ///To send notes to database
  Future<dynamic> sendNoteSubmitRequest(String text, String filePath, bool sendFile) => apiProvider.postNotes(text, filePath, sendFile);

  ///To send Profile Image to database
  Future<dynamic> sendImageSubmitRequest(String imagePath) => apiProvider.postImage(imagePath);

  ///To get promotional Image
  Future<dynamic> sendPromotionalImageRequest() => apiProvider.getPromotionalImage();

  ///To send Firebase Token to database
  Future<dynamic> sendFirebaseTokenRequest(String firebaseToken) => apiProvider.postFirebaseToken(firebaseToken);

  ///To get details of Gift
  Future<dynamic> sendGiftDetailsRequest(int id) => apiProvider.getGiftDetails(id);

  ///To get details of Gift
  Future<dynamic> sendSupportHistoryRequest() => apiProvider.getSupportHistory();

  ///To get details of Gift
  Future<dynamic> postQrScanHistoryRequest(int pageNumber) => apiProvider.postQrScanHistoryRequest(pageNumber);




}
