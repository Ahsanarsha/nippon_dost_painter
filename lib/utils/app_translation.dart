import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/resources/cache_manager.dart';
import 'package:nippon_dost/screens/login/login.dart';

class AppTranslation extends Translations with CacheManager {

  static final locale = Locale('en_US', 'US');

  static final fallbackLocale = Locale('ur_PK', 'PK');

  static final langs = [
    'English',
    'اردو',
  ];


  static final locales = [
    Locale('en_US', 'US'),
    Locale('ur_PK', 'PK'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'ur_PK': ur,
      };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}

final Map<String, String> enUS = {
  'app_name': 'Nippon Dost',

  //Login Screen
  'login': 'Login',
  'enter_phone_number': 'Enter Phone Number',
  'phone_number_required': 'Phone number required',
  'phone_number_must_be_valid': 'Phone number must be valid',
  'next': 'Next',

  //OTP Verification Screen
  'enter_verification_code':
      'Enter 4 digit verification code send to your number',
  'verify': 'Verify',
  ///Zee
  'resend_code': 'Resend code',
  'in': ' in',

  // Home Screen
  'home': 'Home',

  'profile': 'Profile',
  'history': 'History',
  'points': 'POINTS',
  'cash': 'Cash',
  'new_order_scan' : 'New Order Scan Here',
  'my_qr_code' : 'My QR Code',
  //Slab
  'slab': 'Slab',
  'gift_redemption_slab' : 'Gift Redemption Slab',

  ///Ze
  'welcome': 'Welcome!',
  'selectLanguage' : 'Select Language',

  //Settings
  'settings' : 'Settings',
  'themes' : 'Themes',
  'languages' : 'Languages',
  'app_info' : 'App Information',
  'about_app' : 'About App',
  'privacy_policy' : 'Privacy Policy',
  'logout' : 'Logout',

  //Support
  'write_note' : 'Write a note',
  'send' : 'Send',
  'support_history' : 'Support History',




  //Slab Screen
  'united_ud_70' : 'UNITED UD 70',
  'gifts':'Gifts',
  'points_smaller' : 'Points',

  //Earning banner
  'you_earned': 'You have earned',
  'select_language' : 'Select Language',

  //History
  'current_week' : 'Current Week',
  'previous_week' : 'Previous Week',
  'order_history' : 'Order History',
  'points_redemption_history' : 'Points Redemption History',
  'cash_redemption_history' : 'Cash Redemption History',
  'pending' : 'Pending',
  'delivered' : 'Delivered',
  'received' : 'Received',
  'sr.' : 'Sr.',
  'status' : 'Status',
  'bonus' : 'Bonus',
  'date' : 'Date',
  'dealer' : 'Dealer',

  'theme_text': 'Change Theme',
  'theme_dark': 'Dark',
  'theme_light': 'Light',
  'change_language': 'Change Language',
  'select_theme' : 'Select Theme',
  'system_default' : 'System Default',
  'light' : 'Light',
  'dark': 'Dark',

  //redeem token
  'redeem_token' : 'Redeem Token',
  'done' : 'Done',
  'time' : 'Time',
  'are_you_sure' : 'Are you sure?',
  'do_you_want_to_go_back' : 'Do you want to back, all progress will be lost',
  'no' : 'No',
  'yes' : 'Yes',
  'do_you_want_exit' : 'Do you want to exit Nippon Dost',

  //SnackBar
  'success' : 'Success',
  'note_uploaded' : 'Notes Successfully Uploaded ',
  'image_updated' : 'Image Successfully Uploaded ',
  'something_went_wrong' : 'Something went wrong',
  'please_try_again' : 'Please try again later ',
  'qr_scan' : 'QR Scan',
  'qr_already_in_list' : 'Qr Code already in scanned list',
  'qr_code' : 'QR Code',
  'enter_qr_code' : 'Enter QR Code',
  'scan' : 'Scan',
  'sorry' : 'Sorry',
  'mobile_number' : 'Mobile Number',
  'all_qr_code_redeemed' : 'All QR codes successfully redeemed',
  'no_permission' : 'No Permission',
  'otp' : 'OTP',
  'otp_not_matched' : 'OTP is not matched',
  'attention' : 'Attention',
  'otp_required' : 'OTP code is required',
  'image_not_available' : 'Image is not available',
  'delivery_days' : 'Delivery Days :',
  'data_not_available' : 'Data is not available',
  'already_scanned' : 'QR has been scanned',
  'image_size_large' : 'Image is too large',




  //OTP
  'mobile_number_verified' : 'Your mobile number is verified',
  'verified' : 'Verified',

  //Notifications
  'notifications' : 'Notifications',
};

final Map<String, String> ur = {
  'app_name': 'نپون دوست',

  //Login Screen
  'login': 'لاگ ان کریں',
  'enter_phone_number': 'فون نمبر درج کریں',
  'phone_number_required': 'فون نمبر درکار ہے',
  'phone_number_must_be_valid': 'فون نمبر درست ہونا چاہیے',
  'next': 'آگے',

//OTP Verification Screen
  'enter_verification_code':
      'چار ہندسوں کا تصدیقی کوڈ درج کریں جوآپ کے نمبر پر موصول ہوا ہے',
  'verify': 'تصدیق کریں',
  'resend_code': 'کوڈ دوبارہ بھیجیں',
  'in':  'میں  ',

  // Home Screen
  'home': 'سرورق',
  'profile': 'پروفائل',
  'history': 'ریکارڈ',
  'points' : 'پوائنٹس',
  'cash': 'نقد',
  'new_order_scan' : 'نیا آرڈر یہاں اسکین کریں',
  'my_qr_code' : 'میرا کیو آر کوڈ',
  //Slab
  'slab': 'سلیب',
  'gift_redemption_slab' : 'گفٹ ریڈمپشن سلیب',
  'gifts' : 'تحائف',
  'points_smaller' : 'پوائنٹس',
  'select_language' : 'زبان منتخب کریں',
  'select_theme' : 'تھیم منتخب کریں۔',
  'status' : 'حالت',
  'bonus' : 'بونس',
  'date' : 'تاریخ',
  'system_default' : 'سسٹم ڈیفالٹ',
  'light' : 'مدھم',
  'dark': 'گہرا',


  //Slab Screen
  'united_ud_70' : 'یونائیٹڈ یو ڈی 70',

  ///Ze
  'welcome': '!خوش آمدید',

  //Earning banner
  'you_earned': 'آپ نے کمایا ہے',

  //History
  'current_week' : 'موجودہ ہفتہ',
  'previous_week' : 'پچھلا ہفتہ',
  'order_history' : 'آرڈر کی تاریخ',
  'points_redemption_history' : 'پوائنٹس ریڈیمپشن کی تاریخ',
  'cash_redemption_history' : 'نقد ریڈیمپشن کی تاریخ',
  'pending' : 'ملتوی',
  'delivered' : 'پہنچایا',
  'received' : 'موصولہ',
  'sr.' : 'اشاریہ',
  'dealer' : 'ڈیلر',
  'time' : 'وقت',





  'theme_text': 'تھیم تبدیل کریں',
  'theme_dark': 'تاریک',
  'theme_light': 'روشنی',
  'change_language': 'زبان تبدیل کریں',

  //Settings
  'settings' : 'ترتیبات',
  'themes' : 'تھیمز',
  'languages' : 'زبانیں',
  'app_info' : 'ایپ کی معلومات',
  'about_app' : 'ایپ کے بارے میں',
  'privacy_policy' : 'رازداری کی پالیسی',
  'logout' : 'لاگ آوٹ',

  //Support
  'write_note' : 'ایک نوٹ لکھیں۔',
  'send' : 'بھیجیں',
  'support_history' : 'معاونت کی تاریخ',

  //SnackBar
  'success' : 'کامیابی',
  'note_uploaded' : 'نوٹ کامیابی سے اپ لوڈ ہو گیا۔ ',
  'something_went_wrong' : 'کچھ غلط ہو گیا',
  'please_try_again' : 'براہ کرم کچھ دیر بعد کوشش کریں',
  'image_updated' : 'تصویر کامیابی کے ساتھ اپ لوڈ ہو گئی۔',
  'qr_scan' : 'کیو آر اسکین',
  'qr_already_in_list' : 'کیو آر کوڈ پہلے ہی اسکین شدہ فہرست میں ہے۔',
  'qr_code' : ' کیو آر کوڈ',
  'enter_qr_code' : ' کیو آر کوڈ درج کریں',
  'scan' : 'اسکین کریں',
  'sorry' : 'معذرت',
  'mobile_number' : 'موبائل فون نمبر',
  'all_qr_code_redeemed' : 'تمام کیو آر کوڈز کامیابی سے حاصل کر لیے گئے ہیں',
  'no_permission' : 'اجازت نہیں',
  'otp' : 'او ٹی پی',
  'otp_not_matched' : 'او ٹی پی مشابہ نہیں',
  'attention' : 'توجہ',
  'otp_required' : 'او ٹی پی کوڈ درکار ہے',
  'image_not_available' : 'تصویر دستیاب نہیں۔',
  'delivery_days' : 'ترسیل کے دن :',
  'data_not_available' : 'ڈیٹا دستیاب نہیں ہے۔',
  'image_size_large' : 'تصویر بہت بڑی ہے',

  'mobile_number_verified': 'آپ کا موبائل نمبر تصدیق شدہ ہے۔',
  'verified' :'تصدیق شدہ',
  //Notifications
  'notifications' : 'اطلاعات',
  'already_scanned' : 'کیو آر اسکین ہو چکا ہے',
  //redeem token
  'redeem_token' : 'حاصل کیے گئے ٹوکن',
  'done' : 'ہو گیا',
  'are_you_sure' : 'کیا اپکو یقین ہے؟',
  'do_you_want_to_go_back' : 'کیا آپ پیچھے ہٹنا چاہتے ہیں، تمام پیش رفت ضائع ہو جائے گی',
  'no' : 'نہیں',
  'yes' : 'جی ہاں',
  'do_you_want_exit' : 'کیا آپ نیپون دوست سے باہر نکلنا چاہتے ہیں؟',

};
