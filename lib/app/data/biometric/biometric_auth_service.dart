import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  // Check if biometric is available
  Future<bool> isBiometricAvailable() async {
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
  Future<bool> isBiometricEnabled() async {
    String? token = await _storage.read(key: 'device_biometric_token');
    return token != null;
  }

  // Get biometric type for display
  Future<String> getBiometricType() async {
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
  Future<Map<String, dynamic>?> enableBiometric(String userId) async {
    try {
      // Check if already enabled
      if (await isBiometricEnabled()) {
        print('Biometric already enabled');
        return null;
      }

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

        // Store locally
        await _storage.write(key: 'device_biometric_token', value: deviceToken);
        await _storage.write(key: 'biometric_user_id', value: userId);
        await _storage.write(key: 'biometric_enabled_at', value: DateTime.now().toIso8601String());

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
  Future<String?> authenticateAndGetToken() async {
    try {
      // Check if biometric is enabled
      String? deviceToken = await _storage.read(key: 'device_biometric_token');
      if (deviceToken == null) {
        print('Biometric not enabled. Please enable first.');
        return null;
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
        await _storage.write(
          key: 'biometric_last_used',
          value: DateTime.now().toIso8601String(),
        );

        return deviceToken; // Send this to backend
      }

      return null;
    } catch (e) {
      print('Error authenticating: $e');
      return null;
    }
  }

  // Get stored user ID
  Future<String?> getStoredUserId() async {
    return await _storage.read(key: 'biometric_user_id');
  }

  // Get stored device token
  Future<String?> getStoredDeviceToken() async {
    return await _storage.read(key: 'device_biometric_token');
  }

  // Disable biometric
  Future<bool> disableBiometric() async {
    try {
      await _storage.delete(key: 'device_biometric_token');
      await _storage.delete(key: 'biometric_user_id');
      await _storage.delete(key: 'biometric_enabled_at');
      await _storage.delete(key: 'biometric_last_used');
      return true;
    } catch (e) {
      print('Error disabling biometric: $e');
      return false;
    }
  }

  // Get unique device ID
  Future<String> _getDeviceId() async {
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
  Future<String> _getDeviceName() async {
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