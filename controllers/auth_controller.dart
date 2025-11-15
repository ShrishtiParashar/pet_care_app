import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_auth_service.dart';
import '../screens/profile_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Reactive variables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Check if user is already logged in
    currentUser.value = _authService.currentUser;
    isAuthenticated.value = currentUser.value != null;
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final user = await _authService.signInWithGoogle();

      if (user != null) {
        currentUser.value = user;
        isAuthenticated.value = true;
        errorMessage.value = '';

        // Navigate to profile screen
        Get.off(() => const ProfileScreen());
      } else {
        errorMessage.value = 'Failed to sign in. Please try again.';
      }
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _authService.signOut();

      currentUser.value = null;
      isAuthenticated.value = false;
      errorMessage.value = '';

      // Navigate back to login screen
      Get.offAll(() => null); // Will be replaced by proper navigation in app
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Get user name
  String? get userName => _authService.userName ?? 'User';

  /// Get user email
  String? get userEmail => _authService.userEmail ?? 'No email';

  /// Get user photo URL
  String? get userPhotoUrl => _authService.userPhotoUrl;

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }
}
