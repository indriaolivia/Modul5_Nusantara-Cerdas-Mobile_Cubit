import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/layanan_page.dart';
import '../cubit/pengajuan_cubit.dart';

class RincianLayananPage extends StatefulWidget {
  final Layanan layanan;
  const RincianLayananPage({super.key, required this.layanan});

  @override
  State<RincianLayananPage> createState() => _RincianLayananPageState();
}

class _RincianLayananPageState extends State<RincianLayananPage> {
  // State lokal: hanya relevan untuk halaman ini, jadi cukup setState().
  bool _sedangMengirim = false;

  Future<void> _ajukan() async {
    setState(() => _sedangMengirim = true);

    // Simulasi proses pengiriman ke dinas.
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    context.read<PengajuanCubit>().ajukan(widget.layanan);
    setState(() => _sedangMengirim = false);

    Navigator.pop(
      context,
      'Permohonan ${widget.layanan.nama} telah diajukan',
    );
  }

  @override
  Widget build(BuildContext context) {
    final layanan = widget.layanan;

    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Layanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Center(
              child: Icon(layanan.ikon,
                  size: 64, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(layanan.nama,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Dinas Penanggung Jawab'),
              subtitle: Text(layanan.dinas),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Jam Operasional'),
              subtitle: Text(layanan.jamOperasional),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Keterangan'),
              subtitle: Text(layanan.keterangan),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              icon: _sedangMengirim
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: Text(_sedangMengirim ? 'Mengirim...' : 'Ajukan Permohonan'),
              // null = tombol nonaktif, mencegah tekan berulang.
              onPressed: _sedangMengirim ? null : _ajukan,
            ),
          ],
        ),
      ),
    );
  }
}