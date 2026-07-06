import 'package:flutter/material.dart';
import 'package:latihan1/features/auth/presentation/providers/auth_provider.dart';
import 'package:latihan1/features/auth/presentation/providers/tenant_provider.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna tema berdasarkan desain
    const Color mainBlue = Color(0xFF113355); // Warna biru kartu
    const Color accentGreen = Color(0xFFA1D645); // Warna hijau tombol
    const Color bgColor = Color(0xFFF6F8F6); // Warna background aplikasi

    return Consumer2<AuthProvider, TenantProvider>(
      builder: (context, authProvider, tenantProvider, child) {
        final userData = authProvider.loginData;

        return Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 100,
              ), // Ruang untuk bottom nav
              child: Column(
                children: [
                  // 1. HEADER (Profil & Ikon)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(userData!.photos!),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData.ename!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              userData.getCompany(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.logout, color: Colors.black54),
                          onPressed: () async {
                            await authProvider.logout();
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 2. KARTU CHECK-IN
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: mainBlue,
                      borderRadius: BorderRadius.circular(30),
                      // Jika ada gambar background gelombang, gunakan ini:
                      // image: DecorationImage(
                      //   image: AssetImage('assets/images/wave_bg.png'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Monday, 24 May 2026",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const Text(
                          "08:00 – 17:00 (Morning Shift)",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Clock In • 09:41:36",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            // Tombol Hijau Check In
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                  size: 18,
                                ),
                                label: const Text(
                                  "CHECK IN",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentGreen,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Tombol Putar/History
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.history,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 3. GRID MENU
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.0, // Rasio aspek kotak menu
                      children: [
                        _buildMenuItem(
                          "Working Shift",
                          Icons.calendar_today_outlined,
                        ),
                        _buildMenuItem(
                          "Time Off",
                          Icons.calendar_month_outlined,
                        ),
                        _buildMenuItem(
                          "Payslip",
                          Icons.account_balance_wallet_outlined,
                        ),
                        _buildMenuItem("Overtime", Icons.timer_outlined),
                        _buildMenuItem(
                          "Sales Visit",
                          Icons.chat_bubble_outline,
                        ),
                        _buildMenuItem(
                          "Attendance Correction",
                          Icons.edit_note_outlined,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 4. KARTU TIMESHEET
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.description_outlined,
                          color: Color(0xFF9FA6A0),
                          size: 28,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Timesheet",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Update your project activities",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // 5. BOTTOM NAVIGATION BAR
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 10,
            selectedItemColor: const Color(0xFF7CB342), // Hijau
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            currentIndex: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi Helper untuk membangun item Grid Menu
  Widget _buildMenuItem(String title, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8F6),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: const Color(0xFF4CAF50), size: 26),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
