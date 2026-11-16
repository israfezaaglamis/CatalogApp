# Mini Katalog

Flutter ile geliştirilmiş basit ve profesyonel bir mini katalog uygulaması (Flutter haftalık eğitim projesi).

## Kısa Açıklama
Ürün listesi (GridView), kategori sekmeleri, arama ve sıralama, ürün detayı ve basit sepet simülasyonu içerir.
Veriler `assets/data/products.json` dosyasından okunur (JSON simülasyonu). Ekstra paket kullanılmamıştır.

## Kullanılan Flutter Sürümü
Flutter 3.22+ / Dart 3.0+ (`flutter --version` çıktınızı buraya yazın)

## Çalıştırma Adımları
```bash
git clone <repo-url>
cd mini_katalog
flutter create .        # android/ios klasörlerini oluşturur (lib ve assets korunur)
flutter pub get
flutter run             # emülatör veya fiziksel Android cihaz açıkken
```

## Klasör Yapısı
```
lib/
  main.dart                 # uygulama girişi, named routes
  theme/app_theme.dart      # renkler, tema, Pill rozeti
  models/product.dart       # model sınıfı (fromJson / toJson)
  data/product_repository.dart
  state/cart_model.dart     # ChangeNotifier ile sepet state'i
  screens/                  # home, product_detail, cart
  widgets/                  # product_card, product_image
assets/
  data/products.json
  images/
```

## Ekran Görüntüleri
`screenshots/` klasörüne ekleyin: ana sayfa, ürün detayı, sepet.
