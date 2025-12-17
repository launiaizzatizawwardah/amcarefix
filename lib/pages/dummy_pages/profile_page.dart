import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8BC0),
        centerTitle: true,
        title: const Text(
          "Profil",
          style: TextStyle(
            fontFamily: "LexendExa",
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ================================================
              // FOTO + NAMA + RM (bisa ditekan seperti Instagram)
              // ================================================
              GestureDetector(
                onTap: () => _showSwitchRM(context, c),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFF2E8BC0),
                      child: Icon(Icons.person, size: 48, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      c.nama.value,
                      style: const TextStyle(
                        fontFamily: "LexendExa",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "RM: ${c.rm.value}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 28),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ================================================
              // DATA DETAIL
              // ================================================
              _boxField("Nomor WA", c.wa.value),
              const SizedBox(height: 18),

              _boxField("Alamat", c.alamat.value),
              const SizedBox(height: 18),

              _boxField("Tanggal Lahir", c.tglLahir.value),
              const SizedBox(height: 18),

              _boxField(
                "Jenis Kelamin",
                c.sex.value == "L" ? "Laki-laki" : "Perempuan",
              ),

              const SizedBox(height: 35),

              // LOGOUT BUTTON
              TextButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text(
                        "Konfirmasi Logout",
                        style: TextStyle(
                          fontFamily: "LexendExa",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      content: const Text(
                        "Apakah Anda yakin ingin keluar?",
                        style: TextStyle(
                          fontFamily: "LexendExa",
                          fontSize: 13,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text("Batal"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E8BC0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                            Get.offAllNamed("/home");
                          },
                          child: const Text(
                            "Ya, Log Out",
                            style: TextStyle(
                              fontFamily: "LexendExa",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                    fontFamily: "LexendExa",
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ============================================================
  //  FUNGSI POPUP BOTTOM SHEET (IG STYLE)
  // ============================================================
  void _showSwitchRM(BuildContext context, ProfileController c) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Obx(() {
          if (c.pasienList.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: Text("Tidak ada nomor pasien ditemukan")),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Pilih Rekam Medis",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // LIST RM
                ...c.pasienList.map((p) {
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(p["nama_pas"]),
                    subtitle: Text("RM: ${p["no_cm"]}"),
                    onTap: () {
                      c.pilihRM(p);   
                      Navigator.pop(context); // tutup bottom sheet
                    },
                  );
                }).toList(),
              ],
            ),
          );
        });
      },
    );
  }

  // ============================================================
  //  CUSTOM FIELD
  // ============================================================
  Widget _boxField(String label, String value) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
