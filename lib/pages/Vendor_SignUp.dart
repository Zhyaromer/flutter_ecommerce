import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiStepVendorSignUp extends StatefulWidget {
  const MultiStepVendorSignUp({super.key});

  @override
  State<MultiStepVendorSignUp> createState() => _MultiStepVendorSignUpState();
}

class _MultiStepVendorSignUpState extends State<MultiStepVendorSignUp> {
  int _currentStep = 1;
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _storeName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _location = TextEditingController();
  final _descriptionController = TextEditingController();

  // Selection States
  String? _processingTime;
  String? _vendorType;
  String? _city;
  String? _returnPolicy;
  String? _paymentOption;

  void _submitForm(int currentStep) {
    // to do later for backend integration
    print("Store Name: ${_storeName.text}");
    print("Email: ${_email.text}");
    print("Phone: ${_phone.text}");
    print("Password: ${_password.text}");
    print("City: $_city");
    print("Location: ${_location.text}");
    print("Description: ${_descriptionController.text}");
    print("Vendor Type: $_vendorType");
    print("Processing Time: $_processingTime");
    print("Return Policy: $_returnPolicy");
    print("Payment Option: $_paymentOption");
    _formKey.currentState!.save();
  }

  @override
  void dispose() {
    _storeName.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _location.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            _buildHorizontalIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(key: _formKey, child: _buildStepContent()),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  // --- 1. PROGRESS INDICATOR (4 STEPS) ---
  Widget _buildHorizontalIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        children: List.generate(4, (index) {
          bool isActive = index < _currentStep;
          return Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isActive ? Colors.deepPurpleAccent : Colors.grey[800],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  // --- 2. STEP CONTENT ---
  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1: // Identity
        return Column(
          children: [
            const Text(
              "Store Identity",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildLogoPicker(),
            const SizedBox(height: 20),
            _buildField(
              "Store Name",
              _storeName,
              Icons.storefront,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the store name';
                } else if (value.length < 6) {
                  return 'Store name must be at least 6 characters long';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildField(
              "Email",
              _email,
              Icons.email,
              validator: (value) {
                if (value == null || !value.contains('@')) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildPasswordField((value) {
              if (value == null || value.length < 8) {
                return "Password must be at least 8 characters";
              } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return "Password must contain at least one uppercase letter";
              } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                return "Password must contain at least one number";
              } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                return "Password must contain at least one special character (!@#\$&*~)";
              }
              return null;
            }),
          ],
        );

      case 2: // Location & Type
        return Column(
          children: [
            const Text(
              "Location & Type",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            _buildField(
              "Phone Number",
              _phone,
              Icons.phone,
              isNumeric: true,
              validator: (value) {
                if (value == null || value.length < 10) {
                  return "Enter a valid phone number";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            _buildDropdown(
              "City",
              ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix"],
              _city,
              (val) => setState(() => _city = val),
            ),

            const SizedBox(height: 20),

            _buildField(
              "Full Address",
              _location,
              Icons.map,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your store address";
                } else if (value.length < 5) {
                  return "Address must be at least 5 characters long";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            _buildDropdown(
              "Vendor Type",
              [
                "Market",
                "Cosmetic",
                "Electronics",
                "Fashion",
                "Groceries",
                "Others",
              ],
              _vendorType,
              (val) => setState(() => _vendorType = val),
            ),
          ],
        );

      case 3: // Business Details
        return Column(
          children: [
            const Text(
              "Business Details",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            _buildDescriptionField(
              key: const ValueKey('store_description_field'),
              "Store Description",
              _descriptionController,
              Icons.description,
              minCharacters: 20,
              onChanged: (val) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),

            _buildDropdown(
              "Processing Time",
              ["1-2 Days", "3-5 Days", "1 Week"],
              _processingTime,
              (val) => setState(() {
                _processingTime = val;
              }),
            ),

            const SizedBox(height: 20),

            _buildDropdown(
              "Return Policy",
              ["No Returns", "7 Days", "30 Days"],
              _returnPolicy,
              (val) => setState(() {
                _returnPolicy = val;
              }),
            ),

            const SizedBox(height: 20),

            _buildDropdown(
              "Payment Options",
              ["Cash on Delivery", "Credit Card", "Both Cash and Card"],
              _paymentOption,
              (val) => setState(() {
                _paymentOption = val;
              }),
            ),
          ],
        );
      case 4: // Review
        return _buildReviewStep();
      default:
        return Container();
    }
  }

  // --- 3. INPUT HELPERS ---
  Widget _buildField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isNumeric = false,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumeric
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.deepPurpleAccent),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField(String? Function(String?)? validator) {
    return TextFormField(
      controller: _password,
      obscureText: _obscurePassword,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        labelText: "Password",
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.lock, color: Colors.deepPurpleAccent),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> items,
    String? currentValue,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.grey[900],
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e, style: const TextStyle(color: Colors.white)),
            ),
          )
          .toList(),
      onChanged: onChanged,
      initialValue: currentValue,
      validator: (value) => value == null ? 'Please select $hint' : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildLogoPicker() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.deepPurpleAccent, width: 1),
      ),
      child: const Icon(Icons.add_a_photo, color: Colors.deepPurpleAccent),
    );
  }

  // --- 4. FINAL REVIEW ---
  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Review Store Info",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _reviewRow("Store", _storeName.text),
              _reviewRow("Type", _vendorType ?? "None"),
              _reviewRow("Email", _email.text),
              _reviewRow("Phone", _phone.text),
              _reviewRow("Location", _location.text),
              _reviewRow("Processing Time", _processingTime ?? "None"),
              _reviewRow("City", _city ?? "None"),
              _reviewRow("Payments", _paymentOption ?? "None"),
              _reviewRow("Returns", _returnPolicy ?? "None"),

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description:",
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _descriptionController.text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- 5. NAVIGATION ---
  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          if (_currentStep > 1)
            Expanded(
              child: TextButton(
                onPressed: () => setState(() => _currentStep--),
                child: const Text("Back", style: TextStyle(color: Colors.grey)),
              ),
            ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_currentStep < 4) {
                    setState(() => _currentStep++);
                  } else {
                    _submitForm(_currentStep);
                  }
                }
              },
              child: Text(
                _currentStep == 4 ? "Complete Setup" : "Continue",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDescriptionField(
  String label,
  TextEditingController? description,
  IconData icon, {
  int minCharacters = 20,
  required void Function(String) onChanged,
  Key? key,
}) {
  return TextFormField(
    maxLines: 8,
    maxLength: 200,
    key: key,
    controller: description,
    style: const TextStyle(color: Colors.white),
    onChanged: (val) => onChanged(val),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Enter a brief description of your store";
      } else if (value.length < minCharacters) {
        return "At least $minCharacters characters required";
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: label,
      alignLabelWithHint: true,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(bottom: 170),
        child: Icon(icon, color: Colors.deepPurpleAccent),
      ),
      labelStyle: const TextStyle(color: Colors.grey),
      counterText: "${description?.text.length ?? 0}/200",
      counterStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      filled: true,
      fillColor: Colors.grey[900],
      errorStyle: TextStyle(color: Colors.red),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 1),
      ),
    ),
  );
}
