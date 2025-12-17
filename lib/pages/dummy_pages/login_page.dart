import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/controllers/otp_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final otpC = Get.find<OtpController>();
  final nikController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // 🔹 Tombol Back
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      size: 26, color: Colors.black87),
                  onPressed: () => Get.back(),
                ),
              ),

              const SizedBox(height: 10),

              // 🔹 Logo RS
              Center(
                child: Image.asset(
                  "assets/images/logo_rs.png",
                  width: 140,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "OTP Verification",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text(
                "Masukkan nomor NIK untuk melakukan OTP\n"
                "yang terdaftar di database RS",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 30),

              // 🔹 Label NIK
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "NIK",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // 🔹 Input NIK
              TextField(
                controller: nikController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: "Masukkan NIK",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 🔹 Tombol Continue (call API, bukan cuma pindah halaman)
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: otpC.isLoading.value
                        ? null
                        : () async {
                            final nik = nikController.text.trim();

                            if (nik.isEmpty) {
                              Get.snackbar(
                                  "Peringatan", "NIK tidak boleh kosong");
                              return;
                            }

                            if (nik.length != 16) {
                              Get.snackbar(
                                  "Format NIK salah", "Harus 16 angka");
                              return;
                            }

                            // 🔥 Ini yang trigger OTP (2x call) + pindah halaman
                            await otpC.sendOtp(nik);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: otpC.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Continue",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Pastikan NIK sudah terdaftar di rumah sakit",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
