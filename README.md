# 🧊 Aplikasi Frozen Food

Aplikasi mobile sederhana untuk catalog dan checkout produk frozen food menggunakan Flutter, Firebase, dan backend Golang.

---

## 🚀 Fitur

- Login & Register (Firebase)
- Email Verification
- Catalog Produk
- Keranjang (Cart)
- Checkout (Simulasi)
- Integrasi Backend (JWT)

---

## 🏗️ Struktur
lib/
├── core/
├── features/
│ ├── auth/
│ ├── cart/
│ ├── dashboard/

---

## 🔐 Alur Singkat

1. Login via Firebase  
2. Dapat ID Token  
3. Kirim ke backend  
4. Backend return JWT  
5. JWT dipakai untuk API  

---

## ▶️ Cara Menjalankan

### Flutter
git clone https://github.com/dzikribdr/frozen_food_1123150049
cd frozen_food_1123150049
flutter pub get
flutter run

### Backend
git clone https://github.com/dzikribdr/gin-firebase-backend
cd gin-firebase-backend
go run main.go

---

## 🎬 Demo Video

https://youtu.be/2nmfudfP-Ic

---

## 👤 Author

Dzikri Abdurrahman Haris
https://github.com/dzikribdr
