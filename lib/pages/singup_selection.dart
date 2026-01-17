import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/user_signup.dart';
import 'package:flutter_ecommerce/pages/vendor_signup.dart';

enum UserRole { buyer, vendor, none }

class SignupSelection extends StatefulWidget {
  const SignupSelection({super.key});

  @override
  State<SignupSelection> createState() => _SignupSelectionState();
}

class _SignupSelectionState extends State<SignupSelection> {
  UserRole selectedRole = UserRole.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 90),
              const Text(
                "How would you like to join?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Select a role to personalize your experience",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 40),

              _buildRoleCard(
                role: UserRole.buyer,
                title: "Customer",
                subtitle: "I'm here to explore and buy products",
                icon: Icons.shopping_cart_outlined,
              ),

              const SizedBox(height: 20),

              _buildRoleCard(
                role: UserRole.vendor,
                title: "Vendor",
                subtitle: "I want to list products and grow my business",
                icon: Icons.storefront_outlined,
              ),

              const Spacer(),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: selectedRole != UserRole.none
                      ? [
                          BoxShadow(
                            color: Colors.deepPurpleAccent.withOpacity(0.4),
                            blurRadius: 15,
                          ),
                        ]
                      : [],
                ),
                child: ElevatedButton(
                  onPressed: selectedRole == UserRole.none
                      ? null
                      : () {
                          if (selectedRole == UserRole.buyer) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPageUser(),
                              ),
                            );
                          } else if (selectedRole == UserRole.vendor) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MultiStepVendorSignUp(),
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    disabledBackgroundColor: Colors.grey[800],
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required UserRole role,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    bool isSelected = selectedRole == role;
    return GestureDetector(
      onTap: () => setState(() => selectedRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E1E1E) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.deepPurpleAccent : Colors.grey[800]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 50,
              color: isSelected ? Colors.deepPurpleAccent : Colors.white,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
