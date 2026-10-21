import 'package:flutter_bloc/flutter_bloc.dart';

/// State: kumpulan nama layanan yang ditandai favorit.
class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(const {});

  bool apakahFavorit(String namaLayanan) => state.contains(namaLayanan);

  void tandai(String namaLayanan) {
    if (state.contains(namaLayanan)) return;
    // Emit salinan baru, bukan memutasi Set lama.
    emit({...state, namaLayanan});
  }

  void batalTandai(String namaLayanan) {
    if (!state.contains(namaLayanan)) return;
    emit(state.where((n) => n != namaLayanan).toSet());
  }
}