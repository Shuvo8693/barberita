
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';

class BiometricService {
 static final LocalAuthentication _auth = LocalAuthentication();

  // Check if device supports biometrics
 static Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      print('Error checking biometrics: $e');
      return false;
    }
  }

  // Check if device is enrolled with biometrics
 static Future<bool> isDeviceSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (e) {
      print('Error checking device support: $e');
      return false;
    }
  }

  // Get available biometric types
 static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      print('Error getting biometrics: $e');
      return [];
    }
  }

  // Authenticate with biometrics
 static Future<bool> authenticate({String reason = 'Please authenticate to continue'}) async {
    try {
      // Check if biometrics are available
      bool canAuthenticate = await canCheckBiometrics();
      if (!canAuthenticate) {
        print('Biometric authentication not available');
        return false;
      }

      // Perform authentication
      bool authenticated = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true, // Don't cancel on app switch
          biometricOnly: false, // Allow fallback to PIN/password
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ),
      );

      return authenticated;
    } on PlatformException catch (e) {
      print('Authentication error: ${e.code} - ${e.message}');

      // Handle specific errors
      if (e.code == auth_error.notAvailable) {
        print('Biometric authentication not available');
      } else if (e.code == auth_error.notEnrolled) {
        print('No biometrics enrolled');
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        print('Too many failed attempts');
      }

      return false;
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }

  // Get biometric type name for display
 static String getBiometricTypeName(List<BiometricType> types) {
    if (types.contains(BiometricType.face)) {
      return 'Face ID';
    } else if (types.contains(BiometricType.fingerprint)) {
      return 'Fingerprint';
    } else if (types.contains(BiometricType.iris)) {
      return 'Iris';
    } else if (types.contains(BiometricType.strong) ||
        types.contains(BiometricType.weak)) {
      return 'Biometric';
    }
    return 'Biometric Authentication';
  }
}