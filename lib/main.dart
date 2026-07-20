import 'package:flutter/material.dart';

void main() {
  runApp(const CrochetApp());
}

// Renk Paleti (Orgu Temasi)
class OrguTemasi {
  static const Color arkaPlan = Color(0xFFE8D7F9);
  static const Color kartArkaPlan = Colors.white;
  static const Color anaMor = Color(0xFF502176);
  static const Color yaziRengi = Color(0xFF502176);
  static const Color inputBorder = Color(0xFF502176);
}

// Urun Modeli
class Urun {
  final int id;
  final String isim;
  final double fiyat;
  final String aciklama;
  final String gorselUrl;

  Urun({
    required this.id,
    required this.isim,
    required this.fiyat,
    required this.aciklama,
    required this.gorselUrl,
  });
}

// SEPETI HAFIZADA TUTMAK ICIN GLOBAL LISTE
List<Urun> sepetListesi = [];

class CrochetApp extends StatelessWidget {
  const CrochetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crochet & Knitting',
      theme: ThemeData(
        scaffoldBackgroundColor: OrguTemasi.arkaPlan,
        primaryColor: OrguTemasi.anaMor,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginEkrani(),
        '/home': (context) => const HomeEkrani(),
        '/detail': (context) => const DetailEkrani(),
        '/sepet': (context) => const SepetEkrani(),
      },
    );
  }
}

// --- 1. GÖRSELE BİREBİR UYGUN LOGIN EKRANI ---
class LoginEkrani extends StatelessWidget {
  const LoginEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFE1D5F5,
      ), // Görseldeki açık lavanta arka plan
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo ve Başlık
                Image.asset(
                  'assets/images/logo.png',
                  width: 110,
                  height: 110,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.gesture,
                    size: 100,
                    color: Color(0xFF4A148C),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'CROCHET / KNITTING',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A2574),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 45),

                // Kullanıcı Adı Kutusu (Siyah Kalın Çerçeveli)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                      ),
                      hintText: 'Kullanıcı Adı',
                      hintStyle: TextStyle(color: Colors.purple, fontSize: 14),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Şifre Kutusu (Siyah Kalın Çerçeveli)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                      suffixIcon: Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black,
                      ),
                      hintText: 'Şifre',
                      hintStyle: TextStyle(color: Colors.purple, fontSize: 14),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Giriş Yap Butonu (Koyu Mor ve Kalın Siyah Çerçeveli)
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A237B),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: InkWell(
                    onTap: () {
                      // BUTONA BASINCA HOME SAYFASINA GEÇİŞ YAPAR
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    borderRadius: BorderRadius.circular(13),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.login, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Giriş Yap',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Linkler
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Şifremi Unuttum',
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.8),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Yeni Hesap Oluştur',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),

                // Alternatif Giriş Butonları (Beyaz üzerine siyah çerçeve)
                _alternatifGirisButonu(
                  Icons.phone_outlined,
                  'Telefon Numarası ile Giriş Yap',
                ),
                const SizedBox(height: 12),
                _alternatifGirisButonu(
                  Icons.mail_outline,
                  'E-posta ile Giriş Yap',
                ),
                const SizedBox(height: 30),

                // Alt Sorun Bildirimi Yazısı
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 13),
                    children: [
                      TextSpan(
                        text: 'Sorun mu yaşıyorsunuz?\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        text: 'Bize Ulaşın',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A237B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _alternatifGirisButonu(IconData ikon, String metin) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(ikon, color: const Color(0xFF4A237B)),
          const SizedBox(width: 12),
          Text(
            metin,
            style: const TextStyle(
              color: Color(0xFF4A237B),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2. HOME (KATALOG) EKRANI ---
class HomeEkrani extends StatefulWidget {
  const HomeEkrani({super.key});

  @override
  State<HomeEkrani> createState() => _HomeEkraniState();
}

class _HomeEkraniState extends State<HomeEkrani> {
  int _currentBarIndex = 1;

  final List<Urun> _urunler = [
    Urun(
      id: 1,
      isim: "Beyaz Kalpli Mavi Headband",
      fiyat: 250.0,
      aciklama:
          "Soft renkleri ve sevimli figuruyle dikkat ceken trend aksesuar. Kalp motifleri ve pratik baglama ipi sayesinde saclariniza hem konforlu hem de goz alici modern bir hava katacak.",
      gorselUrl:
          "https://i.pinimg.com/736x/57/97/e3/5797e33afd3733766d4af3391377ffff.jpg",
    ),
    Urun(
      id: 2,
      isim: "Piyano Desenli Mini Etek",
      fiyat: 750.0,
      aciklama:
          "Tamamen el orgusu, sik ve dikkat cekici piyano tusu desenli tasarim etek. Tarziniza muzikal ve yaratici bir dokunus katin.",
      gorselUrl:
          "https://i.pinimg.com/1200x/f1/4f/1c/f14f1c17a8790a34ce8edf3e9365032a.jpg",
    ),
    Urun(
      id: 3,
      isim: "Cilekli Pasta Temali Canta",
      fiyat: 900.0,
      aciklama:
          "Tarzina tatli bir dokunus katan, tamamen el orgusu ozel tasarim canta. Sirin, sik ve tek kelimeyle goz alici.",
      gorselUrl:
          "https://i.pinimg.com/736x/45/74/8a/45748a36465f229294b6a076baea842d.jpg",
    ),
    Urun(
      id: 4,
      isim: "Sakura Cicegi Anahtarlik",
      fiyat: 150.0,
      aciklama:
          "Tamamen el orgusu olarak hazirlanan zarif sakura cicegi anahtarlik. Cantana, anahtarlarina veya hediyelerine sirin ve estetik bir dokunus katar.",
      gorselUrl:
          "https://i.pinimg.com/736x/21/40/54/214054c2ba85814179cb0dd99f7d7837.jpg",
    ),
    Urun(
      id: 5,
      isim: "Spider-Gwen Bere",
      fiyat: 350.0,
      aciklama:
          "Tamamen el orgusu olarak hazirlanan siradisi tasarim bere. Yumusak dokusu ve dikkat ceken goz deseniyle hem sicak tutar hem de tarzina farkli bir hava katar.",
      gorselUrl:
          "https://i.pinimg.com/736x/e6/fe/91/e6fe91a804fec0331042fc4de6b13f36.jpg",
    ),
    Urun(
      id: 6,
      isim: "Fiyonk Detayli Orgu Cuzdan",
      fiyat: 250.0,
      aciklama:
          "Tamamen el orgusu olarak hazirlanan zarif ve sik cuzdan. Fiyonk detayi ve yumusak dokusuyla gunluk kullanim icin hem kullanisli hem de estetik bir tamamlayici.",
      gorselUrl:
          "https://i.pinimg.com/736x/fe/dc/b9/fedcb9511814c77bfeb595ff0443e7aa.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Arama Çubuğu
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: OrguTemasi.anaMor, width: 1.5),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Modellerde arayin',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 18),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: OrguTemasi.anaMor),
                  ),
                ),
              ),
            ),

            // YAN YANA İKİLİ ŞIK IZGARA (GRIDVIEW)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Yan yana 2 ürün göster
                  childAspectRatio:
                      0.72, // Dikey kart oranı (Resimlerin tam oturması için gizli formül)
                  crossAxisSpacing: 12, // Kartların yatay arası boşluk
                  mainAxisSpacing: 12, // Kartların dikey arası boşluk
                ),
                itemCount: _urunler.length,
                itemBuilder: (context, index) {
                  final urun = _urunler[index];
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: urun,
                      );
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: OrguTemasi.kartArkaPlan,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: OrguTemasi.anaMor,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Fotoğraf Alanı
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(18),
                              ),
                              child: Image.network(
                                urun.gorselUrl,
                                fit: BoxFit
                                    .cover, // Grid yapısında cover artık resmi bozmaz, kutuyu doldurur!
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.purple[100],
                                      child: const Icon(
                                        Icons.image,
                                        color: OrguTemasi.anaMor,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    urun.isim,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: OrguTemasi.yaziRengi,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      sepetListesi.add(urun);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${urun.isim} sepete eklendi!',
                                        ),
                                        duration: const Duration(
                                          milliseconds: 900,
                                        ),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(18),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: OrguTemasi.anaMor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _ozelBottomBar(),
    );
  }

  Widget _ozelBottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: OrguTemasi.anaMor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentBarIndex,
      onTap: (index) async {
        setState(() {
          _currentBarIndex = index;
        });
        if (index == 2) {
          await Navigator.pushNamed(context, '/sepet');
          setState(() {
            _currentBarIndex = 1;
          });
        }
      },
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
        const BottomNavigationBarItem(icon: Icon(Icons.colorize), label: ''),
        BottomNavigationBarItem(
          icon: Badge(
            label: Text(sepetListesi.length.toString()),
            isLabelVisible: sepetListesi.isNotEmpty,
            backgroundColor: Colors.red,
            child: const Icon(Icons.shopping_bag_outlined),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}

// --- 3. DETAIL (URUN DETAY / SEPETE EKLEME) EKRANI ---
class DetailEkrani extends StatelessWidget {
  const DetailEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    // Ana sayfadan gönderilen ürün verisini alıyoruz
    final urun = ModalRoute.of(context)!.settings.arguments as Urun;

    // Örgü ürünlerine özel dinamik teknik detayları id'ye göre belirliyoruz
    final double puan = urun.id == 1 ? 9.2 : 8.7;
    final String ipRengi = urun.id == 1
        ? "Bebek Mavisi, Beyaz"
        : "Siyah, Ekru Beyaz";
    final String tigNo = urun.id == 1 ? "3.5 mm" : "4.0 mm";
    final String ipTuru = "Koton / Pamuklu";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Ürün Detayı',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF502176),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Ürün Fotoğrafı
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        urun.gorselUrl,
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 240,
                          color: Colors.purple[100],
                          child: const Icon(
                            Icons.image,
                            size: 50,
                            color: OrguTemasi.anaMor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 2. Ürün Başlığı
                        Text(
                          urun.isim,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: OrguTemasi.yaziRengi,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // 3. Puan ve Stok Durumu (10 Üzerinden Puanlama)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.amber,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "$puan / 10",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                "Stokta Var",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 4. Fiyat Paneli (Görseldeki gibi özel kutu)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFF3EAF8,
                            ), // Açık mor arka plan
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Fiyat",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "₺${urun.fiyat.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 5. Kategori Bilgisi
                        Row(
                          children: [
                            Icon(
                              Icons.category,
                              size: 18,
                              color: OrguTemasi.anaMor.withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Kategori: El Örgüsü Aksesuar",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // 6. Açıklama Alanı
                        const Text(
                          "Açıklama",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: OrguTemasi.yaziRengi,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          urun.aciklama,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // 7. Teknik Özellikler Tablosu (İp rengi, Tığ no vb.)
                        const Text(
                          "Teknik Özellikler",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: OrguTemasi.yaziRengi,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            children: [
                              _teknikSatir("İp Rengi", ipRengi),
                              const Divider(height: 1, thickness: 1),
                              _teknikSatir("Tığ Numarası", tigNo),
                              const Divider(height: 1, thickness: 1),
                              _teknikSatir("İp Türü", ipTuru),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 8. Sepete Ekle Butonu (Alt kısma sabitlenmiş)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  sepetListesi.add(urun);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${urun.isim} sepete eklendi!'),
                      duration: const Duration(milliseconds: 900),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF502176),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Sepete Ekle",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Teknik özellik tablosundaki satırları oluşturan yardımcı widget
  Widget _teknikSatir(String baslik, String deger) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            baslik,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            deger,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: OrguTemasi.yaziRengi,
            ),
          ),
        ],
      ),
    );
  }
}

// --- 4. SEPET (CART) EKRANI ---
class SepetEkrani extends StatefulWidget {
  const SepetEkrani({super.key});

  @override
  State<SepetEkrani> createState() => _SepetEkraniState();
}

class _SepetEkraniState extends State<SepetEkrani> {
  double get toplamTutar =>
      sepetListesi.fold(0, (toplam, urun) => toplam + urun.fiyat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sepetim',
          style: TextStyle(
            color: OrguTemasi.yaziRengi,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: OrguTemasi.anaMor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: sepetListesi.isEmpty
          ? const Center(
              child: Text(
                'Sepetiniz bos.\nModelleri inceleyip ekleyebilirsiniz!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: OrguTemasi.yaziRengi),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sepetListesi.length,
                    itemBuilder: (context, index) {
                      final urun = sepetListesi[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              urun.gorselUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            urun.isim,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${urun.fiyat.toStringAsFixed(2)} TL',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                sepetListesi.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Toplam Tutar:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${toplamTutar.toStringAsFixed(2)} TL',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: OrguTemasi.anaMor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              sepetListesi.clear();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Siparisiniz alindi! Tesekkurler.',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Alisverisi Tamamla',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
