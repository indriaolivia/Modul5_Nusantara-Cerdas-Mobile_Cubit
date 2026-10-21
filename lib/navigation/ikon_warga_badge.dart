import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pengajuan_cubit.dart';
import '../pages/layanan_page.dart';

class IkonWargaBadge extends StatelessWidget {
  final bool terpilih;
  const IkonWargaBadge({super.key, this.terpilih = false});

  @override
  Widget build(BuildContext context) {
    // Hanya badge yang dibangun ulang saat totalPengajuan berubah.
    return BlocSelector<PengajuanCubit, List<Layanan>, int>(
      selector: (daftar) => daftar.length,
      builder: (context, total) {
        return Badge(
          isLabelVisible: total > 0,
          label: Text('$total'),
          child: Icon(terpilih ? Icons.person : Icons.person_outline),
        );
      },
    );
  }
}