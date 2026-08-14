# TROY Zone 17 Mart kurtarma planı

## Sabit referans

- Ana aday: 17 Mart Linux `troy_zoned`
- Kanıtlanmış port: `11601`
- Server2 ve Windows/MSSQL paketleri ayrı revizyondur; doğrudan karıştırılmaz.
- 20260809 baseline değiştirilmez, yalnız karşılaştırılır.

## Uygulama kapıları

1. **Binary kapısı:** ELF mimarisi, SHA256 ve `ldd` eksikleri doğrulanır.
2. **Kütüphane kapısı:** `commonlib`, `raslib`, iniparser ve diğer `.so/.a` sürümleri eşleştirilir.
3. **Config kapısı:** Zone ID, Center/Login hedefleri, IP ve `11601` doğrulanır.
4. **SQL kapısı:** Binary/source içindeki gerçek sorgulardan gerekli tablo, kolon ve procedure listesi çıkarılır.
5. **Veri kapısı:** hesap, karakter, envanter ve harita verileri için okuma-yazma testi yapılır.
6. **Sinyal kapısı:** Login/Center/Relay/PlayUser/GameLog bağlantıları log ve socket ile kanıtlanır.
7. **Client kapısı:** Önceki altı kapı geçilmeden `TROY.exe` protokol testi yapılmaz.

## Çalıştırma

WSL/Ubuntu içinde:

```bash
chmod +x TROY_ZONE_0317_TARA.sh
./TROY_ZONE_0317_TARA.sh "/mnt/c/TROY/TROY_Core"
```

Oluşan `_TROY_ZONE_0317_RAPORU.tar.gz` dosyası sonraki onarım aşamasının girdisidir.