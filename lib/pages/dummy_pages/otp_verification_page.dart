import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/otp_controller.dart';

class OTPVerificationPage extends StatelessWidget {
  OTPVerificationPage({super.key});

  final otpC = Get.find<OtpController>();
  final otpControllers = List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String nik = (args?['nik'] ?? '').toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Verifikasi OTP"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Masukkan kode OTP yang dikirim ke WhatsApp kamu",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),
            Text(
              nik,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 45,
                  height: 55,
                  child: TextField(
                    controller: otpControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 50),

            // TOMBOL VERIFIKASI
            Obx(
              () => ElevatedButton(
                onPressed: otpC.isLoading.value
                    ? null
                    : () async {
                        // Gabungkan 6 digit otp tanpa spasi
                        final otp = otpControllers
                            .map((c) => c.text.trim())
                            .join("");

                        // Cek apakah semua digit terisi
                        if (otp.length != 6 || otp.contains(" ")) {
                          Get.snackbar(
                            "OTP tidak valid",
                            "Pastikan semua kotak OTP terisi",
                          );
                          return;
                        }

                        await otpC.verifyOtp(
                          nik: nik.trim(),
                          otp: otp,
                        );
                      },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                child: otpC.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Verifikasi",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // TOMBOL RESEND OTP
            Obx(
              () => TextButton(
                onPressed: otpC.isResending.value
                    ? null
                    : () async {
                        await otpC.resendOtp(nik.trim());
                      },
                child: otpC.isResending.value
                    ? const Text("Mengirim ulang...")
                    : const Text("Kirim Ulang OTP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
