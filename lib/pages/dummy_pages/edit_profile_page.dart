import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  final hpC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8BC0),
        elevation: 0,
        title: const Text(
          "Edit Profil",
          style: TextStyle(
            fontFamily: 'LexendExa',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              // ============ BOX PUTIH FORM ============
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    _input(
                      "Ganti Username",
                      "Masukkan username baru",
                      usernameC,
                    ),

                    const SizedBox(height: 18),

                    _input(
                      "Ganti Password",
                      "Masukkan password baru",
                      passwordC,
                      isPassword: true,
                    ),

                    const SizedBox(height: 18),

                    _input(
                      "Ganti Nomor HP",
                      "Masukkan nomor HP",
                      hpC,
                      type: TextInputType.phone,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ============ BUTTON SAVE ============
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    String msg = "Perubahan berhasil disimpan:\n";

                    if (usernameC.text.isNotEmpty) {
                      msg += "- Username berhasil diganti\n";
                    }
                    if (passwordC.text.isNotEmpty) {
                      msg += "- Password berhasil diganti\n";
                    }
                    if (hpC.text.isNotEmpty) {
                      msg += "- No HP berhasil diganti\n";
                    }

                    Get.snackbar(
                      "Berhasil",
                      msg,
                      snackPosition: SnackPosition.BOTTOM,
                    );

                    // balik ke ProfilePage (hapus Edit dari stack)
                    Get.offNamed(AppRoutes.profile);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E8BC0),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Simpan Perubahan",
                    style: TextStyle(
                      fontFamily: 'LexendExa',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ==================================================
  // WIDGET INPUT FIELD (rapi & modern)
  // ==================================================
  Widget _input(
    String label,
    String hint,
    TextEditingController c, {
    bool isPassword = false,
    TextInputType type = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'LexendExa',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: c,
          obscureText: isPassword,
          keyboardType: type,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: 'LexendExa',
              fontSize: 13,
              color: Colors.black45,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF2E8BC0),
                width: 1.6,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
