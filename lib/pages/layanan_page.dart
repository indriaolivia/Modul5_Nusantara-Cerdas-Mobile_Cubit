import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../navigation/app_routes.dart';

// ---------------------------------------------------------------
// Model dan data layanan (dipakai bersama oleh halaman lain).
// ---------------------------------------------------------------
class Layanan {
  final String nama;
  final String dinas;
  final String jamOperasional;
  final String keterangan;
  final IconData ikon;

  const Layanan({
    required this.nama,
    required this.dinas,
    required this.jamOperasional,
    required this.keterangan,
    required this.ikon,
  });
}

const Map<String, List<Layanan>> dataLayanan = {
  'Perizinan': [
    Layanan(
      nama: 'Izin Usaha',
      dinas: 'Dinas Penanaman Modal & PTSP',
      jamOperasional: 'Senin–Jumat, 08.00–15.00',
      keterangan: 'Penerbitan izin usaha mikro, kecil, dan menengah.',
      ikon: Icons.storefront,
    ),
    Layanan(
      nama: 'Izin Mendirikan Bangunan',
      dinas: 'Dinas Pekerjaan Umum & Tata Ruang',
      jamOperasional: 'Senin–Jumat, 08.00–15.30',
      keterangan: 'Persetujuan bangunan gedung untuk hunian dan usaha.',
      ikon: Icons.apartment,
    ),
    Layanan(
      nama: 'Izin Keramaian',
      dinas: 'Dinas Kesatuan Bangsa & Politik',
      jamOperasional: 'Senin–Jumat, 08.00–14.00',
      keterangan: 'Rekomendasi kegiatan yang melibatkan banyak orang.',
      ikon: Icons.groups,
    ),
  ],
  'Kesehatan': [
    Layanan(
      nama: 'Pendaftaran Puskesmas Online',
      dinas: 'Dinas Kesehatan',
      jamOperasional: 'Setiap hari, 07.00–20.00',
      keterangan: 'Ambil antrean pemeriksaan tanpa datang lebih awal.',
      ikon: Icons.local_hospital,
    ),
    Layanan(
      nama: 'Imunisasi Anak',
      dinas: 'Dinas Kesehatan',
      jamOperasional: 'Senin–Sabtu, 08.00–12.00',
      keterangan: 'Jadwal dan pendaftaran imunisasi dasar lengkap.',
      ikon: Icons.vaccines,
    ),
    Layanan(
      nama: 'Ambulans Gawat Darurat',
      dinas: 'Dinas Kesehatan & BPBD',
      jamOperasional: '24 jam',
      keterangan: 'Layanan ambulans untuk kondisi darurat warga.',
      ikon: Icons.emergency,
    ),
  ],
  'Transportasi': [
    Layanan(
      nama: 'Perpanjangan Trayek Angkutan',
      dinas: 'Dinas Perhubungan',
      jamOperasional: 'Senin–Jumat, 08.00–15.00',
      keterangan: 'Perpanjangan izin trayek angkutan umum kota.',
      ikon: Icons.directions_bus,
    ),
    Layanan(
      nama: 'Uji Kir Kendaraan',
      dinas: 'Dinas Perhubungan',
      jamOperasional: 'Senin–Jumat, 08.00–14.30',
      keterangan: 'Pengujian kelaikan kendaraan bermotor umum.',
      ikon: Icons.car_repair,
    ),
    Layanan(
      nama: 'Izin Parkir Khusus',
      dinas: 'Dinas Perhubungan',
      jamOperasional: 'Senin–Jumat, 08.00–15.00',
      keterangan: 'Permohonan lokasi dan izin parkir khusus.',
      ikon: Icons.local_parking,
    ),
  ],
};

// ---------------------------------------------------------------
// Tujuan Layanan
// ---------------------------------------------------------------
class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  Future<void> _bukaRincian(BuildContext context, Layanan layanan) async {
    final hasil = await Navigator.pushNamed<String>(
      context,
      AppRoutes.rincianLayanan,
      arguments: layanan,
    );
    if (hasil != null && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(hasil)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final kategori = dataLayanan.keys.toList();

    return DefaultTabController(
      length: kategori.length,
      child: Column(
        children: [
          TabBar(tabs: [for (final k in kategori) Tab(text: k)]),
          Expanded(
            child: TabBarView(
              children: [
                for (final k in kategori)
                  ListView.separated(
                    itemCount: dataLayanan[k]!.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final layanan = dataLayanan[k]![i];
                      return ListTile(
                        leading: Icon(layanan.ikon),
                        title: Text(layanan.nama),
                        subtitle: Text(layanan.dinas),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _TombolFavorit(namaLayanan: layanan.nama),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () => _bukaRincian(context, layanan),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TombolFavorit extends StatelessWidget {
  final String namaLayanan;
  const _TombolFavorit({required this.namaLayanan});

  @override
  Widget build(BuildContext context) {
    // BlocSelector: hanya dibangun ulang bila status favorit layanan ini berubah.
    return BlocSelector<FavoritCubit, Set<String>, bool>(
      selector: (favorit) => favorit.contains(namaLayanan),
      builder: (context, favorit) {
        return IconButton(
          tooltip: favorit ? 'Batalkan favorit' : 'Tandai favorit',
          icon: Icon(
            favorit ? Icons.star : Icons.star_border,
            color: favorit ? Colors.amber : null,
          ),
          // Memanggil method Cubit langsung.
          onPressed: () {
            final cubit = context.read<FavoritCubit>();
            favorit ? cubit.batalTandai(namaLayanan) : cubit.tandai(namaLayanan);
          },
        );
      },
    );
  }
}