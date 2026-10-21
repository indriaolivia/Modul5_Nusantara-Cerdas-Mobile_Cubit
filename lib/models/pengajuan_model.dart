import 'package:flutter/foundation.dart';
import '../pages/layanan_page.dart';

class PengajuanModel extends ChangeNotifier {
  final List<Layanan> _daftar = [];

  List<Layanan> get daftar => List.unmodifiable(_daftar);

  int get totalPengajuan => _daftar.length;

  void ajukan(Layanan layanan) {
    // Hindari pengajuan ganda untuk layanan yang sama.
    if (_daftar.any((l) => l.nama == layanan.nama)) return;
    _daftar.add(layanan);
    notifyListeners();
  }

  void batalkan(String namaLayanan) {
    _daftar.removeWhere((l) => l.nama == namaLayanan);
    notifyListeners();
  }
}