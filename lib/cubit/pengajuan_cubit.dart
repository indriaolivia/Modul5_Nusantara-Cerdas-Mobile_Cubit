import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/layanan_page.dart';

/// State: daftar layanan yang sedang diajukan.
class PengajuanCubit extends Cubit<List<Layanan>> {
  PengajuanCubit() : super(const []);

  int get totalPengajuan => state.length;

  void ajukan(Layanan layanan) {
    // Hindari pengajuan ganda untuk layanan yang sama.
    if (state.any((l) => l.nama == layanan.nama)) return;
    emit([...state, layanan]);
  }

  void batalkan(String namaLayanan) {
    emit(state.where((l) => l.nama != namaLayanan).toList());
  }
}