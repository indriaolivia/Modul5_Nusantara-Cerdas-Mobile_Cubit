import 'package:flutter/material.dart';
import '../pages/layanan_page.dart';
import '../pages/halaman_pendukung.dart';
import '../pages/rincian_layanan_page.dart';
import '../pages/riwayat_laporan_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  AppRoutes._();

  static const String beranda = '/';
  static const String rincianLayanan = '/layanan/rincian';
  static const String riwayatLaporan = '/warga/riwayat';
  static const String pengaturanKota = '/pengaturan';
  static const String tentangAplikasi = '/tentang';
  static const String keluar = '/keluar';

  /// Untuk properti `routes` pada MaterialApp.
  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      riwayatLaporan: (context) => const RiwayatLaporanPage(),
      pengaturanKota: (context) => const PengaturanKotaPage(),
      tentangAplikasi: (context) => const TentangAplikasiPage(),
      keluar: (context) => const KeluarPage(),
    };
  }

  /// Untuk `onGenerateRoute`: route yang membawa arguments.
  /// Mengembalikan null bila nama tidak dikenali, sehingga
  /// Flutter meneruskan ke onUnknownRoute.
  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == rincianLayanan) {
      final args = settings.arguments;
      if (args is Layanan) {
        return MaterialPageRoute<String>(
          settings: settings,
          builder: (context) => RincianLayananPage(layanan: args),
        );
      }
    }
    return null;
  }

  /// Untuk `onUnknownRoute`.
  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => RouteTidakDikenalPage(namaRoute: settings.name),
    );
  }
}