import 'package:barberita/common/prefs_helper/prefs_helpers.dart';
import 'package:local_auth/local_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class BiometricAuthService {
 static final LocalAuthentication _auth = LocalAuthentication();
 static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();


  // Check if biometric is available
 static Future<bool> isBiometricAvailable() async {
    try {
      bool canCheck = await _auth.canCheckBiometrics;
      bool isSupported = await _auth.isDeviceSupported();
      return canCheck && isSupported;
    } catch (e) {
      print('Error checking biometric: $e');
      return false;
    }
  }

  // Check if biometric is already enabled
 static Future<bool> isBiometricEnabled() async {
    String? deviceId = await PrefsHelper.getString('deviceId');
    return deviceId.isNotEmpty;
  }

  // Get biometric type for display
 static Future<String> getBiometricType() async {
    try {
      List<BiometricType> types = await _auth.getAvailableBiometrics();
      if (types.contains(BiometricType.face)) {
        return 'Face ID';
      } else if (types.contains(BiometricType.fingerprint)) {
        return 'Fingerprint';
      } else if (types.contains(BiometricType.iris)) {
        return 'Iris';
      }
      return 'Biometric';
    } catch (e) {
      return 'Biometric';
    }
  }

  // Enable biometric for first time
static  Future<Map<String, dynamic>?> enableBiometric(String userId) async {
    try {
      // Check if already enabled
      // if (await isBiometricEnabled()) {
      //   print('Biometric already enabled');
      //   return null;
      // }

      // Authenticate
      bool authenticated = await _auth.authenticate(
        localizedReason: 'Enable biometric authentication',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ),
      );

      if (authenticated) {
        // Generate unique token for this device
        String deviceToken = const Uuid().v4();
        String deviceId = await _getDeviceId();
        String deviceName = await _getDeviceName();
        String biometricType = await getBiometricType();

        // Store locally using SharedPreferences
        await PrefsHelper.setString('device_id', deviceId);
        await PrefsHelper.setString('device_biometric_token', deviceToken);
        await PrefsHelper.setString('biometric_user_id', userId);
        await PrefsHelper.setString('biometric_enabled_at', DateTime.now().toIso8601String());

        // Return data to send to backend
        return {
          'device_token': deviceToken,
          'device_id': deviceId,
          'device_name': deviceName,
          'user_id': userId,
          'biometric_type': biometricType,
          'platform': Platform.isIOS ? 'ios' : 'android',
          'biometric_enabled': true,
          'timestamp': DateTime.now().toIso8601String(),
        };
      }


      return null;
    } catch (e) {
      print('Error enabling biometric: $e');
      return null;
    }
  }

  // Authenticate and get token (for login)
 static Future<String?> authenticateAndGetToken() async {
    try {
      // Check if biometric is enabled
      await PrefsHelper.remove('device_id'); //<============ remove this =============

      String? deviceId = await PrefsHelper.getString('device_id');
      if (deviceId.isEmpty) {
        print('Biometric not enabled. Please enable first.');
        final result = await enableBiometric('shuvo15');
        String deviceId = result?['device_id']??'';
        return deviceId;
      }

      // Authenticate with biometric
      bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to sign in',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ),
      );

      if (authenticated) {
        // Update last used timestamp
        await PrefsHelper.setString(
          'biometric_last_used',
          DateTime.now().toIso8601String(),
        );

        return deviceId; // Send this to backend
      }

      return null;
    } catch (e) {
      print('Error authenticating: $e');
      return null;
    }
  }

  // Get stored user ID
 static Future<String?> getStoredUserId() async {

    return await PrefsHelper.getString('biometric_user_id');
  }

  // Get stored device token
 static Future<String?> getStoredDeviceToken() async {
    return await PrefsHelper.getString('device_biometric_token');
  }

  // Disable biometric
 static  Future<bool> disableBiometric() async {
    try {
      await PrefsHelper.remove('device_biometric_token');
      await PrefsHelper.remove('biometric_user_id');
      await PrefsHelper.remove('biometric_enabled_at');
      await PrefsHelper.remove('biometric_last_used');
      return true;
    } catch (e) {
      print('Error disabling biometric: $e');
      return false;
    }
  }

  // Get unique device ID
 static Future<String> _getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'unknown';
      }
    } catch (e) {
      print('Error getting device ID: $e');
    }
    return 'unknown_device';
  }

  // Get device name
 static Future<String> _getDeviceName() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        return '${androidInfo.brand} ${androidInfo.model}';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.name;
      }
    } catch (e) {
      print('Error getting device name: $e');
    }
    return 'Unknown Device';
  }
}