// import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'dart:io';

import 'package:http/http.dart'
    show Client, MultipartFile, MultipartRequest, Response;
import 'package:nippon_dost/models/qr_scan_history_model.dart';
import 'package:nippon_dost/models/update_profile_response_model.dart';
import 'package:nippon_dost/resources/models/dashboard_model.dart';
import 'package:nippon_dost/resources/models/error_model.dart';
import 'package:nippon_dost/resources/models/gift_details_model.dart';
import 'package:nippon_dost/resources/models/gift_model.dart';
import 'package:nippon_dost/resources/models/logout_model.dart';
import 'package:nippon_dost/resources/models/order_scan_history_model.dart';
import 'package:nippon_dost/resources/models/otp_model.dart';
import 'package:nippon_dost/resources/models/profile_model.dart';
import 'package:nippon_dost/resources/models/qr_redeem_model.dart';
import 'package:nippon_dost/resources/models/qr_scan_model.dart';
import 'package:nippon_dost/resources/models/support_model.dart';
import 'dart:convert';

import 'cache_manager.dart';
import 'models/FCM Response Model.dart';
import 'models/cash_redeem_history_model.dart';
import 'models/login_model.dart';
import 'models/order_scan_single_history_model.dart';
import 'models/points_redeem_history_model.dart';
import 'models/pormotional_image_model.dart';
import 'models/support_history_model.dart';
import 'models/support_response_model.dart';
import 'urls.dart';

class ApiProvider with CacheManager {
  Client client = Client();

  String? get id => getId();

  String? get pn => getNumber();

  String? get token => getToken();

  String? get fcm => getFCM();

  postLoginRequest(String primaryNumber) async {
    print("Call Login API");
    print( '$baseUrl'+'login');
    final response = await client.post(
      Uri.parse(baseUrl + 'login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'primary_number': primaryNumber,
      }),
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      print(response.body.toString());
      // If the call to the server was successful, parse the JSON
      return loginModelFromJson(response.body);
    } else {
      return errorModelFromJson('${response.body}');
    }
  }

  postOtpRequest(String primaryNumber, String otp) async {
    print("Call OTP API");
    try {
      final response = await client.post(
        Uri.parse(baseUrl + 'otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'primary_number': primaryNumber,
          'otp': otp,
        }),
      );
      print(
          response.statusCode == 200 ? 'Status: OK' : response.body.toString());
      var body = json.decode(response.body);
      if (body['success'] == true) {
        // If the call to the server was successful, parse the JSON
        return otpModelFromJson(response.body);
      } else {
        return errorModelFromJson(response.body);
      }
    } catch (e) {
      print('in catch path');
      return errorModelFromJson('{success:false, message:' '}');
    }
  }

  postDashboardRequest() async {
    print("Call Dashboard API");
    try {
      final response = await client.post(
        Uri.parse(baseUrl + 'dashboard'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$token',
        },
        encoding: Encoding.getByName("utf-8"),
        body: jsonEncode({
          'primary_number': pn,
        }),
      );
      print('got db resposne');
      print(response.body);
      print(
          response.statusCode == 200 ? 'Status: OK' : response.body.toString());
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        return dashboardModelFromJson(response.body);
      } else {
        return errorModelFromJson(response.body);
      }
    } catch (e) {
      print('got error');
      print(e);
    }
  }

  postProfileRequest() async {
    print("Call Profile API");
    final response = await client.post(
      Uri.parse(baseUrl + 'profile'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode({
        'primary_number': pn,
      }),
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return profileModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  getGiftRequest() async {
    print("Call Gift API with id " + id.toString());
    //Gift API updated now will take painter id in the link
    final response = await client.get(
      Uri.parse(baseUrl + 'gift/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      // If the call to the server was successful, parse the JSON

      return giftModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  postOrderScanHistoryRequest() async {
    print("Call Oder Scan History API");
    print('calling order scan history with phone number ' + pn.toString());

    final response = await client.post(
      Uri.parse(baseUrl + 'qr-scan-history'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode({
        'primary_number': pn,
      }),
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return orderScanHistoryModelFromJson(response.body);
    } else {
      throw Exception('Error - ${response.body.toString()}');
      // return errorModelFromJson(response.body);
    }
  }

  postOrderScanSingleHistoryRequest(String orderId) async {
    print("Call Oder Scan Single History API with order ID " + orderId);
    final response = await client.post(
      Uri.parse(baseUrl + 'qr-scan-single-history'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode({
        'order_id': orderId,
      }),
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      print('history object data');
      print(response.body);
      // If the call to the server was successful, parse the JSON
      return orderScanSingleHistoryModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  getCashHistoryRequest() async {
    print("Call Cash History API");
    final response = await client.get(
      Uri.parse(baseUrl + 'cash-redeemtion/' + id!),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      // If the call to the server was successful, parse the JSON
      return cashRedeemHistoryModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  getPointsHistoryRequest() async {
    print("Call Points History API with id ");
    //id is temporarily set to 1
    final response = await client.get(
      Uri.parse(baseUrl + 'point-redeemtion/' + id.toString()),
      //checked and not working
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      // If the call to the server was successful, parse the JSON
      return pointsRedeemHistoryModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  postQrScanRequest(String qrCode) async {
    print("Call Qr Scan API");
    print(qrCode);
    final response = await client.post(
      Uri.parse(baseUrl + 'qr-scan'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode({
        'qr_code': qrCode,
      }),
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    print('qr API response : ' + response.body);
    if (body['success'] == true) {
      // If the call to the server was successful, parse the JSON
      return qrScanModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  postQrScanHistoryRequest(int pageNumber) async {
    print(baseUrl + 'token-history');
    print("Call Qr Scan History API");
    print(id);

    final response = await client.post(
      Uri.parse(baseUrl + 'token-history?page=${pageNumber}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode({
        'painter_id': '$id',
      }),
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    print('qr History API response : ' + response.body);
    if (body['success'] == true) {
      // If the call to the server was successful, parse the JSON
      QrScanHistoryModel model = QrScanHistoryModel();
      model = QrScanHistoryModel.fromJson(body);
      print('QR HISTORY ${body}');
      return model.qrhistory!.data;
    } else {
      //return errorModelFromJson(response.body);
    }
  }

  postQrRedeemRequest(List<int> qrIds) async {
    print("Call Qr Redeem API");
    final response = await client.post(
      Uri.parse(baseUrl + 'qr-redeemed'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode({"id": id, "qr_ids": qrIds, "primary_number": pn}),
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      // If the call to the server was successful, parse the JSON
      return qrRedeemModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  getLogout() async {
    print("Call Logout API");
    final response = await client.get(
      Uri.parse(baseUrl + 'logout'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      // If the call to the server was successful, parse the JSON

      return logoutModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  ///API call to upload the entered note to the database
  postNotes(String note, String noteFilePath, bool sendFile) async {
    print("Call Post Notes API");
    var response;
    if (!sendFile) {
      //Note only API request
      response = await client.post(
        Uri.parse(baseUrl + 'support'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$token',
        },
        encoding: Encoding.getByName("utf-8"),
        body: jsonEncode({
          "message": note,
          "id": id,
        }),
      );
    } else {
      //API calling with a file
      print("note " + note);
      print("file path " + noteFilePath);
      var request = MultipartRequest(
        'POST',
        Uri.parse(baseUrl + 'support'),
      );
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      });
      if (noteFilePath.isNotEmpty || noteFilePath != '')
        request.files.add(await MultipartFile.fromPath('file[]', noteFilePath));
      request.fields['message'] = note;
      request.fields['id'] = id!;
      var streamResponse = await request.send();
      response = await Response.fromStream(streamResponse);
    }

    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      print('got success message from post notes');
      print(body);
      // If the call to the server was successful, parse the JSON
      return supportResponseModelFromJson(response.body);
    } else {
      print('got failure message from post notes');
      print(body);
      return errorModelFromJson(response.body);
    }
  }

  //Update Profile Call
  postImage(String imagePath) async {
    var request = MultipartRequest(
      'POST',
      Uri.parse(baseUrl + 'update-profile'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    });
    request.files.add(await MultipartFile.fromPath('painter_img', imagePath));
    request.fields['primary_number'] = pn!;
    print("Call Post Profile Image API");
    var streamResponse = await request.send();
    var response = await Response.fromStream(streamResponse);
    print(response.statusCode == 200 ? 'Status: OK' : response.body);
    var body = json.decode(response.body);
    if (body['success'] == true) {
      // If the call to the server was successful, parse the JSON
      return updateProfileResponseFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  //Get Promotional Image Call
  getPromotionalImage() async {
    // String baseUrl = 'https://catsofttech.com/nippon/api/';
    // String baseUrl = 'https://catsofttech.com/nippon/api/';
    final response = await client.get(
      //this URL is deprecated
      // Uri.parse(baseUrl + 'promotion'),
      Uri.parse(baseUrl + 'popup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      return promotionalImageModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  ///API call to upload the firebase token to the database
  postFirebaseToken(String firebaseToken) async {
    print("Call Post FCM Token API");
    final response = await client.post(
       Uri.parse(fcmUrl + 'update-fcm-token'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
        'primary_number': pn!,
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode({
        "fcmToken": firebaseToken,
        "userId": id,
        "primary_number": pn,
      }),
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      // If the call to the server was successful, parse the JSON
      return fcmResponseModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  //Get Gift Details Call
  getGiftDetails(int id) async {
    final response = await client.get(
      Uri.parse(baseUrl + 'gift-detail/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
        // 'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODg3YTk3NjRlNTBlY2E5NmJkNmVkMWNkNzJmYWRkYzc0NTQyZDRlYTQ2OTlmZWMxNzNmMmVmM2I5ODQ1MzJhZDE0OTNmYjU5MjE2MDJlMWEiLCJpYXQiOjE2NDQ0MTI0MDUuNzg3MDY2LCJuYmYiOjE2NDQ0MTI0MDUuNzg3MDY5LCJleHAiOjE4MDIxNzg4MDUuNzg0MTY1LCJzdWIiOiI0Iiwic2NvcGVzIjpbInBhaW50ZXIiXX0.pAA4JM1_9fY9MvVbDiExR8KwOesSC98DuDo1E4zMSNG5GpQ2a8sKuYYHVCRHYf3UG_Nu6r0YlUlHw48e2omrpx-d8UXZOyq85JAoMnFfG_alqnzswRZYsSADA6inkh6P1zdOQp--OPcGbQpXCQwGr5MyigATjcasOls0f9P5LlvaICvHFf-MWj1pq54XLVQ8xNMlQQg14kxIVo0naG539ihKaI_RE-WHNgBkkBWAkJDbzEBoIunETYlw0wSsYn-hCVzgzIjhOc-WAKgpuCT3enNseeT-sw2rdf_lNkUQxnACyO8oaGqkSC3lpEm0vZS6cVuaE96m7RM8h2tvgtlfmWrinkRvGV3XnFcQgPWi8Oq3CskF1MNyclg3IVTs-pgejD0wG1DOqHvLDVCF5kcCvRYkg6_zHUZSth8x2zLlL2awJ7uLjjbRrGs_5n4AgNd5K5dElrO4gaZeqOFrDyvtRRksZyI70X_BNzQ_9V6ADmD-hpbQTXqbEN50kNiNCxgtfEPU_981mQa4RTy_5Aq4g9l_Wp_IiDK44D9aERxzl5sLjYC_ZiPvHHPMj9G0WvQ31EjPvezPsr-lZF-Z2HGd2yFRJ9Fl88acd-PaSDM3catnfAhYtrC1L6irV_AyyyhI85mWWsxYR247oS9hF6uXFVgl7F3f3t11F18hUv4Hm8A',
      },
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    if (body['success'] == true) {
      return giftDetailsModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  //Get Support History Call
  getSupportHistory() async {
    String url = '$baseUrl'+'support-history/'; //checked and working
    final response = await client.get(
      Uri.parse(url + id.toString()),
      headers: <String, String>{
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    print('HAMZAAAA RESPONSE => ${response.body}');
    var body = json.decode(response.body);
    if (body['success'] == true) {
      return supportHistoryModelFromJson(response.body);
    } else {
      return errorModelFromJson(response.body);
    }
  }

  postFCMToken() async {
    print("PostFcmToken API");
    print('pn  ${pn}');
    print('tokennn ${fcm}');
    final response = await client.post(
      Uri.parse(fcmUrl + 'update-fcm-token'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode({
        'fcmToken': fcm,
        'primary_number': pn!,
      }),
    );


    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    var body = json.decode(response.body);
    print('qr API response : ' + response.body);
    if (body['success'] == true) {
      // If the call to the server was successful, parse the JSON
      return true;
    } else {
      return false;
    }
  }
}
