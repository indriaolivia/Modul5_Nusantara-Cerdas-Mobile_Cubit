import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../pages/layanan_page.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Gabungkan layanan dari semua tab bidang menjadi satu daftar.
    final semuaLayanan = dataLayanan.values.expand((l) => l).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Indria Olivia'),
            subtitle:
                Text('NIK: 3201•••••••0001\nKelurahan Cerdas, Kota Nusantara'),
            isThreeLine: true,
          ),
        ),
        const SizedBox(height: 16),
        Text('Layanan Favorit',
            style: Theme.of(context).textTheme.titleMedium),
        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, namaFavorit) {
            final favorit = semuaLayanan
                .where((l) => namaFavorit.contains(l.nama))
                .toList();

            if (favorit.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Belum ada layanan favorit. '
                    'Tandai dengan ikon bintang di tujuan Layanan.'),
              );
            }

            return Column(
              children: [
                for (final l in favorit)
                  ListTile(
                    leading: Icon(l.ikon),
                    title: Text(l.nama),
                    subtitle: Text(l.dinas),
                    trailing: IconButton(
                      tooltip: 'Hapus dari favorit',
                      icon: const Icon(Icons.star, color: Colors.amber),
                      onPressed: () =>
                          context.read<FavoritCubit>().batalTandai(l.nama),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        Text('Laporan Terakhir',
            style: Theme.of(context).textTheme.titleMedium),
        const ListTile(
          leading: Icon(Icons.report_problem_outlined),
          title: Text('Lampu jalan mati'),
          subtitle: Text('Status: Diproses'),
        ),
        const ListTile(
          leading: Icon(Icons.report_problem_outlined),
          title: Text('Sampah menumpuk'),
          subtitle: Text('Status: Selesai'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          icon: const Icon(Icons.history),
          label: const Text('Buka Riwayat Laporan'),
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.riwayatLaporan),
        ),
      ],
    );
  }
}