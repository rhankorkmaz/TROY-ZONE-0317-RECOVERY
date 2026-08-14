# TROY Zone 0317 Recovery

Troy Online'ın 17 Mart Linux `troy_zoned` referansını temel alan açık geliştirme ve kurtarma projesidir.

## Hedef

- Zone ELF binary ve kaynak revizyonunu doğrulamak
- `commonlib`, `raslib`, iniparser ve diğer kütüphane bağımlılıklarını eşleştirmek
- SQL tablo, kolon ve procedure kontratlarını gerçek binary/source sorgularından çıkarmak
- Login, Center, Relay, PlayUser, GameLog ve Zone sinyallerini doğrulamak
- `11601` portunu ve servis zincirini kanıtlamak
- Server ve SQL doğrulanmadan Client protokolüne geçmemek

## Kullanım

```bash
chmod +x TROY_ZONE_0317_TARA.sh
./TROY_ZONE_0317_TARA.sh "/mnt/c/TROY/TROY_Core"
```

Araç `_TROY_ZONE_0317_RAPORU.tar.gz` üretir. Rapor; ELF/`ldd`, SHA256, kütüphane, config, SQL, port ve log kanıtlarını içerir.

## Güvenlik

- Çalışan 20260809 baseline doğrudan değiştirilmez.
- Kritik dosyalardan önce yedek ve SHA256 alınır.
- SQL değişikliğinden önce veritabanı yedeği alınır.
- Şifre, API anahtarı, gerçek IP, kullanıcı verisi ve özel loglar repoya yüklenmez.

## Durum

Bu depo kurtarma ve analiz araçlarını içerir. Gerçek server/client binary'leri yalnız lisans ve dağıtım hakkı doğrulandıktan sonra eklenmelidir.