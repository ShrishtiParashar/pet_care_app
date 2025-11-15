/// App constants for the Pet Care application
class AppConstants {
  // Timeouts
  static const Duration signInTimeout = Duration(seconds: 30);
  static const Duration signOutTimeout = Duration(seconds: 15);

  // Error messages
  static const String genericErrorMessage = 'An unexpected error occurred';
  static const String networkErrorMessage = 'Network connection failed';
  static const String signInErrorMessage = 'Failed to sign in. Please try again.';
  static const String signOutErrorMessage = 'Failed to sign out. Please try again.';
  static const String googleCancelledMessage = 'Google Sign-In was cancelled';

  // Success messages
  static const String signInSuccessMessage = 'Successfully signed in';
  static const String signOutSuccessMessage = 'Successfully signed out';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultElevation = 2.0;

  // Profile defaults
  static const String defaultUserName = 'User';
  static const String defaultUserEmail = 'No email';
}
