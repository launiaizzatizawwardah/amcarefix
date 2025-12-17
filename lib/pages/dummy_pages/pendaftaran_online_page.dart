// ✨ PendaftaranOnlinePage — COMPACT VERSION
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/pendaftaran_controller.dart';
import '/routes/app_routes.dart';

class PendaftaranOnlinePage extends StatelessWidget {
  const PendaftaranOnlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(PendaftaranController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background-marble.png',
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              // ================= HEADER =================
              Container(
                height: 70,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF2E8BC0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.offAllNamed(AppRoutes.home1),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "Pendaftaran Online",
                        style: TextStyle(
                          fontFamily: 'LexendExa',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ================= LOGO =================
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/logo_rs.png',
                                height: size.width < 380 ? 50 : 68,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Daftar lebih cepat tanpa antre di loket',
                                style: TextStyle(
                                  fontFamily: 'LexendExa',
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // ================= INFO CARD =================
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.info_outline,
                                  color: Color(0xFF2E8BC0), size: 18),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  "Lengkapi data dengan benar sebelum melanjutkan.",
                                  style: TextStyle(
                                    fontFamily: 'LexendExa',
                                    fontSize: 10,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ================= FORM CARD =================
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Data Pendaftaran",
                                style: TextStyle(
                                  fontFamily: 'LexendExa',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 2),
                              const Text(
                                "Isi sesuai identitas Anda.",
                                style: TextStyle(
                                  fontFamily: 'LexendExa',
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),

                              const SizedBox(height: 10),
                              const Divider(height: 1),
                              const SizedBox(height: 10),

                              // ============= PASIEN =============
                              _label("Pasien (Nama & RM)"),
                              _dropdown(
                                value: c.selectedPasien.value.isEmpty
                                    ? null
                                    : c.selectedPasien.value,
                                items: c.pasienList
                                    .map((p) => '${p['nama']} (${p['rm']})')
                                    .toList(),
                                hint: "Silahkan pilih pasien",
                                onChanged: (v) =>
                                    c.selectedPasien.value = v ?? '',
                              ),

                              const SizedBox(height: 10),

                              // ============= TANGGAL =============
                              _label("Tanggal Periksa"),
                              _fieldBox(
                                height: 42,
                                child: TextField(
                                  readOnly: true,
                                  onTap: () => c.pilihTanggal(context),
                                  style: const TextStyle(
                                    fontFamily: 'LexendExa',
                                    fontSize: 12,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                        Icons.calendar_today,
                                        size: 18,
                                        color: Colors.grey),
                                    hintText: c.tanggal.value == null
                                        ? "Silahkan pilih tanggal"
                                        : "${c.tanggal.value!.day}/${c.tanggal.value!.month}/${c.tanggal.value!.year}",
                                    hintStyle: const TextStyle(
                                      fontFamily: 'LexendExa',
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(top: 12),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              // ============= POLI =============
                              _label("Poliklinik"),
                              _dropdown(
                                value: c.poli.value.isEmpty
                                    ? null
                                    : c.poli.value,
                                items: c.poliList,
                                hint: "Silahkan pilih poliklinik",
                                onChanged: (v) {
                                  c.poli.value = v ?? '';
                                  c.dokter.value = '';
                                  c.kuota.value = 0;
                                },
                              ),

                              const SizedBox(height: 10),

                              // ============= DOKTER =============
                              _label("Dokter (Nama & Jam Praktik)"),
                              _dropdown(
                                value: c.dokter.value.isEmpty
                                    ? null
                                    : c.dokter.value,
                                items: c.dokterList
                                    .map((d) => '${d['nama']} (${d['jam']})')
                                    .toList(),
                                hint: "Silahkan pilih dokter",
                                onChanged: (val) {
                                  if (val == null) {
                                    c.dokter.value = '';
                                    c.kuota.value = 0;
                                    return;
                                  }

                                  final dok = c.dokterMap[c.poli.value]
                                      ?.firstWhere(
                                    (d) =>
                                        '${d['nama']} (${d['jam']})' == val,
                                    orElse: () => {'kuota': 0},
                                  );

                                  c.dokter.value = val;
                                  c.kuota.value =
                                      (dok?['kuota'] ?? 0) as int;
                                },
                              ),

                              const SizedBox(height: 10),

                              // ============= KUOTA =============
                              if (c.dokter.value.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: c.kuota.value > 0
                                        ? const Color(0xFFE3F2FD)
                                        : const Color(0xFFFFEBEE),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        c.kuota.value > 0
                                            ? Icons.check_circle
                                            : Icons.error_outline,
                                        size: 18,
                                        color: c.kuota.value > 0
                                            ? const Color(0xFF2E8BC0)
                                            : Colors.redAccent,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        c.kuota.value > 0
                                            ? "Sisa kuota: ${c.kuota.value}"
                                            : "Kuota penuh",
                                        style: TextStyle(
                                          fontFamily: 'LexendExa',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: c.kuota.value > 0
                                              ? const Color(0xFF2E8BC0)
                                              : Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ================= BUTTON =================
                        SizedBox(
                          height: 46,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (c.dokter.value.isNotEmpty &&
                                    c.kuota.value > 0)
                                ? () => c.submitForm(context)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E8BC0),
                              disabledBackgroundColor:
                                  const Color(0xFF2E8BC0).withOpacity(0.45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                fontFamily: 'LexendExa',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // COMPONENTS
  // ==========================================================

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'LexendExa',
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    );
  }

  Widget _dropdown({
    required List<String> items,
    required String hint,
    required Function(String?) onChanged,
    String? value,
  }) {
    return _fieldBox(
      height: 42,
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: const TextStyle(
                      fontFamily: 'LexendExa',
                      fontSize: 12,
                    ),
                  ),
                ))
            .toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        hint: Text(
          hint,
          style: const TextStyle(
            fontFamily: 'LexendExa',
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        icon: const Icon(Icons.expand_more, size: 20),
      ),
    );
  }

  Widget _fieldBox({required Widget child, double height = 42}) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: child,
    );
  }
}
