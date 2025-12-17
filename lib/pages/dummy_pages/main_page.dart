import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/main_controller.dart';
import '/pages/dummy_pages/home_page1.dart';
import '/pages/dummy_pages/riwayat_rm_tab_page.dart'; // ← versi TAB
import '/pages/dummy_pages/layanan_page.dart';
import '/pages/dummy_pages/profile_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final c = Get.put(MainController());

  final List<Widget> pages = const [
    HomePage1(),
    RiwayatRMTabPage(),   // ← versi khusus untuk tab bawah
    LayananPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: c.selectedIndex.value,
          children: pages,
        ),

        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(16),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              final icons = [
                Icons.home_rounded,
                Icons.folder_shared_rounded,
                Icons.medical_services_rounded,
                Icons.person_rounded,
              ];

              final labels = [
                "Beranda",
                "Riwayat RM",
                "Layanan",
                "Akun",
              ];

              final active = c.selectedIndex.value == index;

              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => c.changePage(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: active ? Colors.blue.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icons[index],
                        color: active ? Colors.blueAccent : Colors.grey,
                        size: active ? 28 : 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        labels[index],
                        style: TextStyle(
                          fontFamily: 'LexendExa',
                          fontSize: 11,
                          fontWeight:
                              active ? FontWeight.bold : FontWeight.normal,
                          color: active ? Colors.blueAccent : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
