// Tugas Rutin 5: Menu UMKM Kuliner (versi 4: Kedai Jajanan & Minuman)
// Nama: ................  NIM: ................
import 'package:material_ui/material_ui.dart';

enum KategoriMenu {
  minuman('Minuman', Icons.local_cafe),
  jajanan('Jajanan', Icons.icecream),
  makanan('Makanan', Icons.rice_bowl);

  const KategoriMenu(this.label, this.ikon);
  final String label;
  final IconData ikon;
}

class Menu {
  const Menu({required this.nama, required this.harga, required this.kategori});

  final String nama;
  final int harga;
  final KategoriMenu kategori;

  String get hargaRupiah =>
      'Rp${harga.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
}

// Ganti dengan data UMKM pilihanmu.
const namaUsaha = 'Kedai Jajanan Kampus';
const daftarMenu = <Menu>[
  Menu(nama: 'Es Campur', harga: 12000, kategori: KategoriMenu.minuman),
  Menu(nama: 'Jus Alpukat', harga: 15000, kategori: KategoriMenu.minuman),
  Menu(nama: 'Pisang Goreng Keju', harga: 10000, kategori: KategoriMenu.jajanan),
  Menu(nama: 'Nasi Goreng Kampung', harga: 18000, kategori: KategoriMenu.makanan),
];

void main() => runApp(const MenuApp());

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: namaUsaha,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HalamanMenu(),
    );
  }
}

class HalamanMenu extends StatelessWidget {
  const HalamanMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu UMKM Kuliner')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const HeaderUmkm(),
          const KartuKontak(),
          for (final m in daftarMenu) KartuMenu(menu: m),
        ],
      ),
    );
  }
}

class HeaderUmkm extends StatelessWidget {
  const HeaderUmkm({super.key});

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 7,
          // Letakkan foto di assets/header.jpg dan daftarkan di pubspec.yaml.
          child: Image.asset(
            'assets/header.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) => ColoredBox(
              color: skema.tertiaryContainer,
              child: Icon(
                Icons.storefront,
                size: 64,
                color: skema.onTertiaryContainer,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(namaUsaha, style: teks.headlineSmall),
        ),
      ],
    );
  }
}

class KartuKontak extends StatelessWidget {
  const KartuKontak({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text('0852-0000-1111'),
            subtitle: Text('WhatsApp'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.pin_drop),
            title: Text('Dekat gerbang kampus'),
            subtitle: Text('Lokasi'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.alternate_email),
            title: Text('@kedaijajanankampus'),
            subtitle: Text('Instagram'),
          ),
        ],
      ),
    );
  }
}

class KartuMenu extends StatelessWidget {
  const KartuMenu({super.key, required this.menu});

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;
    return Card(
      color: skema.surfaceContainerHighest,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(menu.nama, style: teks.titleMedium),
                  const SizedBox(height: 2),
                  Text(menu.hargaRupiah, style: teks.bodyMedium),
                  const SizedBox(height: 8),
                  Chip(
                    avatar: Icon(menu.kategori.ikon, size: 18),
                    label: Text(menu.kategori.label),
                  ),
                ],
              ),
            ),
            TombolFavorit(namaMenu: menu.nama),
          ],
        ),
      ),
    );
  }
}

class TombolFavorit extends StatefulWidget {
  const TombolFavorit({super.key, required this.namaMenu, this.awal = false});

  final String namaMenu;
  final bool awal;

  @override
  State<TombolFavorit> createState() => _TombolFavoritState();
}

class _TombolFavoritState extends State<TombolFavorit> {
  late bool _favorit;

  @override
  void initState() {
    super.initState();
    _favorit = widget.awal;
  }

  void _ubah() {
    setState(() => _favorit = !_favorit);
    final aksi = _favorit ? 'ditambahkan ke' : 'dihapus dari';
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('${widget.namaMenu} $aksi favorit')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: _ubah,
      tooltip: 'Favorit',
      icon: Icon(_favorit ? Icons.favorite : Icons.favorite_border),
    );
  }
}
