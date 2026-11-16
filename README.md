# Mini Katalog App

Flutter ile geliştirilmiş basit ve profesyonel bir mini katalog uygulaması (Flutter haftalık eğitim projesi).

## Kısa Açıklama
Ürün listesi (GridView), kategori sekmeleri, arama ve sıralama, ürün detayı ve basit sepet simülasyonu içerir.
Veriler `assets/data/products.json` dosyasından okunur (JSON simülasyonu). Ekstra paket kullanılmamıştır.

## Kullanılan Flutter Sürümü
Flutter 3.22+ / Dart 3.0+ (`flutt<img width="243" height="547" alt="home page" src="https://github.com/user-attachments/assets/1e1538c3-ccce-44de-a93c-5722b123d051" />
er --version` çıktınızı buraya yazın)

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
<img width="243" height="547" alt="home page" src="https://github.com/user-attachments/assets/719628e5-8101-4603-adf1-18960636d338" />
<img width="457" height="289" alt="kategori" src="https://github.com/user-attachments/assets/49513c83-9f62-42c5-8ad6-96f9c64e5fef" />
