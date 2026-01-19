import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Helper class for launching URLs, apps, and external links
class LauncherHelper {
  LauncherHelper._();

  // ==================== Phone ====================

  /// Launch phone dialer with the given phone number
  /// Example: LauncherHelper.makePhoneCall('+1234567890')
  static Future<bool> makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    return await _launchUrl(phoneUri, errorMessage: 'Could not make phone call');
  }

  /// Launch SMS app with the given phone number
  /// Example: LauncherHelper.sendSMS('+1234567890', message: 'Hello')
  static Future<bool> sendSMS(String phoneNumber, {String? message}) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: message != null ? {'body': message} : null,
    );
    return await _launchUrl(smsUri, errorMessage: 'Could not send SMS');
  }

  // ==================== Email ====================

  /// Launch email app with the given email address
  /// Example: LauncherHelper.sendEmail(
  ///   email: 'support@example.com',
  ///   subject: 'Hello',
  ///   body: 'This is the email body'
  /// )
  static Future<bool> sendEmail({
    required String email,
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) async {
    String emailUrl = 'mailto:$email';

    List<String> params = [];
    if (subject != null) params.add('subject=$subject');
    if (body != null) params.add('body=$body');
    if (cc != null && cc.isNotEmpty) params.add('cc=${cc.join(',')}');
    if (bcc != null && bcc.isNotEmpty) params.add('bcc=${bcc.join(',')}');

    if (params.isNotEmpty) {
      emailUrl += '?${params.join('&')}';
    }

    try {
      final result = await launchUrlString(emailUrl, mode: LaunchMode.externalApplication);
      return result;
    } catch (e) {
      debugPrint('Error launching email: $e');
      return false;
    }
  }

  // ==================== WhatsApp ====================

  /// Launch WhatsApp with the given phone number
  /// Phone number should include country code without + or 00
  /// Example: LauncherHelper.openWhatsApp('1234567890', message: 'Hello')
  static Future<bool> openWhatsApp(String phoneNumber, {String? message}) async {
    // Remove all non-numeric characters except +
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final number = cleanNumber.startsWith('+') ? cleanNumber.substring(1) : cleanNumber;

    final Uri whatsappUri = Uri.parse(
        'https://wa.me/$number${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}'
    );

    return await _launchUrl(
      whatsappUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open WhatsApp. Make sure WhatsApp is installed.',
    );
  }

  /// Launch WhatsApp Business
  static Future<bool> openWhatsAppBusiness(String phoneNumber, {String? message}) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final number = cleanNumber.startsWith('+') ? cleanNumber.substring(1) : cleanNumber;

    final Uri whatsappUri = Uri.parse(
        'https://api.whatsapp.com/send?phone=$number${message != null ? '&text=${Uri.encodeComponent(message)}' : ''}'
    );

    return await _launchUrl(
      whatsappUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open WhatsApp Business',
    );
  }

  // ==================== Social Media ====================

  /// Open Facebook profile
  /// Example: LauncherHelper.openFacebook('username')
  static Future<bool> openFacebook(String username) async {
    final Uri fbUri = Uri.parse('https://www.facebook.com/$username');
    return await _launchUrl(
      fbUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open Facebook',
    );
  }

  /// Open Instagram profile
  /// Example: LauncherHelper.openInstagram('username')
  static Future<bool> openInstagram(String username) async {
    final Uri instaUri = Uri.parse('https://www.instagram.com/$username');
    return await _launchUrl(
      instaUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open Instagram',
    );
  }

  /// Open Twitter profile
  /// Example: LauncherHelper.openTwitter('username')
  static Future<bool> openTwitter(String username) async {
    final Uri twitterUri = Uri.parse('https://twitter.com/$username');
    return await _launchUrl(
      twitterUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open Twitter',
    );
  }

  /// Open LinkedIn profile
  /// Example: LauncherHelper.openLinkedIn('username')
  static Future<bool> openLinkedIn(String username) async {
    final Uri linkedInUri = Uri.parse('https://www.linkedin.com/in/$username');
    return await _launchUrl(
      linkedInUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open LinkedIn',
    );
  }

  /// Open YouTube channel
  /// Example: LauncherHelper.openYouTube('channelId')
  static Future<bool> openYouTube(String channelId) async {
    final Uri youtubeUri = Uri.parse('https://www.youtube.com/channel/$channelId');
    return await _launchUrl(
      youtubeUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open YouTube',
    );
  }

  /// Open TikTok profile
  /// Example: LauncherHelper.openTikTok('username')
  static Future<bool> openTikTok(String username) async {
    final Uri tiktokUri = Uri.parse('https://www.tiktok.com/@$username');
    return await _launchUrl(
      tiktokUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open TikTok',
    );
  }

  // ==================== Maps ====================

  /// Open Google Maps with coordinates
  /// Example: LauncherHelper.openGoogleMaps(latitude: 37.7749, longitude: -122.4194)
  static Future<bool> openGoogleMaps({
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    final Uri mapsUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude${label != null ? '&query_place_id=$label' : ''}'
    );
    return await _launchUrl(
      mapsUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open Google Maps',
    );
  }

  /// Open Google Maps with address search
  /// Example: LauncherHelper.openGoogleMapsSearch('New York City')
  static Future<bool> openGoogleMapsSearch(String address) async {
    final Uri mapsUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}'
    );
    return await _launchUrl(
      mapsUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open Google Maps',
    );
  }

  /// Open navigation to coordinates
  /// Example: LauncherHelper.openNavigation(latitude: 37.7749, longitude: -122.4194)
  static Future<bool> openNavigation({
    required double latitude,
    required double longitude,
  }) async {
    final Uri navUri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude'
    );
    return await _launchUrl(
      navUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open navigation',
    );
  }

  // ==================== Other Apps ====================

  /// Open Telegram
  /// Example: LauncherHelper.openTelegram('username')
  static Future<bool> openTelegram(String username) async {
    final Uri telegramUri = Uri.parse('https://t.me/$username');
    return await _launchUrl(
      telegramUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open Telegram',
    );
  }

  /// Open Skype
  /// Example: LauncherHelper.openSkype('username')
  static Future<bool> openSkype(String username) async {
    final Uri skypeUri = Uri.parse('skype:$username?chat');
    return await _launchUrl(
      skypeUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open Skype',
    );
  }

  /// Open Viber
  /// Example: LauncherHelper.openViber('+1234567890')
  static Future<bool> openViber(String phoneNumber) async {
    final Uri viberUri = Uri.parse('viber://chat?number=$phoneNumber');
    return await _launchUrl(
      viberUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open Viber',
    );
  }

  // ==================== Web & App Store ====================

  /// Open URL in browser
  /// Example: LauncherHelper.openWebsite('https://example.com')
  static Future<bool> openWebsite(String url, {LaunchMode? mode}) async {
    Uri uri;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      uri = Uri.parse('https://$url');
    } else {
      uri = Uri.parse(url);
    }
    return await _launchUrl(
      uri,
      mode: mode ?? LaunchMode.platformDefault,
      errorMessage: 'Could not open website',
    );
  }

  /// Open app in Play Store (Android) or App Store (iOS)
  /// Example: LauncherHelper.openAppStore('com.example.app')
  static Future<bool> openAppStore(String appId) async {
    final Uri storeUri = Uri.parse(
      GetPlatform.isAndroid
          ? 'https://play.google.com/store/apps/details?id=$appId'
          : 'https://apps.apple.com/app/id$appId',
    );
    return await _launchUrl(
      storeUri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not open app store',
    );
  }

  /// Share text (opens share sheet)
  /// Example: LauncherHelper.shareText('Check out this app!')
  static Future<bool> shareText(String text) async {
    final Uri shareUri = Uri(
      scheme: 'mailto',
      query: 'subject=${Uri.encodeComponent(text)}',
    );
    return await _launchUrl(
      shareUri,
      errorMessage: 'Could not share text',
    );
  }

  // ==================== Helper Methods ====================

  /// Check if a URL can be launched
  static Future<bool> canLaunchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      return await canLaunchUrl(uri);
    } catch (e) {
      print('Error checking if URL can be launched: $e');
      return false;
    }
  }

  /// Internal method to launch URL with error handling
  static Future<bool> _launchUrl(
      Uri uri, {
        LaunchMode mode = LaunchMode.platformDefault,
        String? errorMessage,
      }) async {
    try {
      final canLaunch = await canLaunchUrl(uri);
      if (!canLaunch) {
        if (errorMessage != null && Get.isRegistered<GetInstance>()) {
          Get.snackbar(
            'Error',
            errorMessage,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        print('Cannot launch URL: $uri');
        return false;
      }

      final launched = await launchUrl(uri, mode: mode);
      if (!launched && errorMessage != null && Get.isRegistered<GetInstance>()) {
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return launched;
    } catch (e) {
      print('Error launching URL: $e');
      if (errorMessage != null && Get.isRegistered<GetInstance>()) {
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return false;
    }
  }

  // ==================== Custom Schemes ====================

  /// Launch custom URL scheme
  /// Example: LauncherHelper.launchCustomScheme('myapp://screen/details?id=123')
  static Future<bool> launchCustomScheme(String scheme) async {
    final Uri uri = Uri.parse(scheme);
    return await _launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      errorMessage: 'Could not launch app',
    );
  }
}

/// =================================  Use Case ====================

/*// Phone Call
await LauncherHelper.makePhoneCall('+1234567890');

// SMS
await LauncherHelper.sendSMS('+1234567890', message: 'Hello!');

// Email
await LauncherHelper.sendEmail(
  email: 'support@example.com',
  subject: 'Support Request',
  body: 'I need help with...',
);

// WhatsApp
await LauncherHelper.openWhatsApp('1234567890', message: 'Hi there!');

// Social Media
await LauncherHelper.openFacebook('username');
await LauncherHelper.openInstagram('username');
await LauncherHelper.openTwitter('username');

// Maps
await LauncherHelper.openGoogleMaps(
  latitude: 23.8103,
  longitude: 90.4125,
  label: 'Dhaka',
);

// Navigation
await LauncherHelper.openNavigation(
  latitude: 23.8103,
  longitude: 90.4125,
);

// Website
await LauncherHelper.openWebsite('https://example.com');

// App Store
await LauncherHelper.openAppStore('com.example.app');*/

/// =================== permission =================
/// androidManifest
/*<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
    <intent>
        <action android:name="android.intent.action.DIAL" />
        <data android:scheme="tel" />
    </intent>
    <intent>
        <action android:name="android.intent.action.SENDTO" />
        <data android:scheme="mailto" />
    </intent>
</queries>*/

/// info.plist
/*<key>LSApplicationQueriesSchemes</key>
<array>
    <string>https</string>
    <string>http</string>
    <string>tel</string>
    <string>mailto</string>
    <string>whatsapp</string>
    <string>fb</string>
    <string>instagram</string>
    <string>twitter</string>
    <string>tg</string>
</array>*/