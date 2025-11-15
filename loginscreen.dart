import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/error_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                // App Logo or Title
                _buildAppHeader(),

                const SizedBox(height: 60),

                // Welcome Text
                _buildWelcomeText(context),

                const SizedBox(height: 40),

                // Error Message Display
                _buildErrorMessage(),

                const SizedBox(height: 24),

                // Google Sign-In Button
                _buildSignInButton(),

                const SizedBox(height: 40),

                // Features List
                _buildFeaturesList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue[100],
      ),
      child: Icon(
        Icons.pets,
        size: 64,
        color: Colors.blue[700],
      ),
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome to Pet Care',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Your companion for pet health and wellness',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Obx(() {
      if (_authController.errorMessage.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red[50],
          border: Border.all(color: Colors.red[300]!, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red[700], size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _authController.errorMessage.value,
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 14,
                ),
              ),
            ),
            GestureDetector(
              onTap: _authController.clearError,
              child: Icon(Icons.close, color: Colors.red[700], size: 20),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSignInButton() {
    return Obx(() {
      return GoogleSignInButton(
        isLoading: _authController.isLoading.value,
        onPressed: () {
          _authController.signInWithGoogle().catch((e) {
            // Error handling is done in the controller
          });
        },
      );
    });
  }

  Widget _buildFeaturesList(BuildContext context) {
    final features = [
      ('📱', 'Easy Sign-In', 'Sign in with your Google account'),
      ('🔒', 'Secure & Safe', 'Your data is protected with Firebase'),
      ('🐾', 'Pet Wellness', 'Track your pet health and wellness'),
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Text(feature.$1, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.$2,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      feature.$3,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}