TROY LOGIN/RACE WORKING CHECKPOINT
Created: 08/16/2026 21:21:48

SON DURUM:
- VS2008/v90 Release TROY.exe build alıyor.
- Natzugen client içinde çalışan TROY.exe var.
- Server seçimi/sinyal çalışıyor.
- test / 123456 login oldu.
- Login sonrası ırk seçimi ekranı geldi.
- Eski ID/şifre sonrası donma çözüldü.
- Client login cevabında serverdan 18,732 byte alıyor.
- Client normalde 35,902 byte bekliyordu.
- Geçici patch: partial receive accept ile login ekranı geçildi.
- Şimdiki hata: Irk/karakter oluşturma isim yazma aşamasında oyundan atıyor.

TEKNİK NOT:
- S05_GMain05.cpp içinde:
  - 97 byte login send patch var.
  - recv timeout patch var.
  - recv part trace patch var.
  - partial accept patch var.
- Kalıcı çözüm için:
  - AVATAR_INFO
  - S_LOGIN_RECV
  - S_USER_AVATAR_INFO_RECV
  - karakter oluşturma paketi
  client/server tarafında eşitlenecek.

GITHUB'A DİREKT YÜKLEME:
- Bu klasör PRIVATE yedektir.
- SQL dump, yerel path, config şifreleri içerebilir.
- Public GitHub için ayrıca temiz/sanitized dosya hazırlanmalı.
