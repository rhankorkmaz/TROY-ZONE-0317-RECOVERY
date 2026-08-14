#!/usr/bin/env bash
set -u

root="${1:-.}"
out="${2:-$root/_TROY_ZONE_0317_RAPORU}"
mkdir -p "$out"

find "$root" -type f \( -iname 'troy_zoned' -o -iname '*zone*' -o -iname 'run.sh' -o -iname 'troy.sh' -o -iname 'Makefile' \) -print0 \
  | xargs -0 -r stat --printf='%y|%s|%n\n' | sort -r > "$out/01_ZONE_ADAYLARI.txt"

find "$root" -type f \( -name '*.so' -o -name '*.so.*' -o -name '*.a' -o -name '*.conf' -o -name '*.cfg' -o -name '*.ini' -o -name '*.sql' \) -print0 \
  | xargs -0 -r sha256sum > "$out/02_KUTUPHANE_CONFIG_SQL_SHA256.txt"

zone="$(find "$root" -type f -name 'troy_zoned' -perm -111 -print 2>/dev/null | head -n 1)"
if [[ -n "$zone" ]]; then
  file "$zone" > "$out/03_ZONE_BINARY.txt" 2>&1
  sha256sum "$zone" >> "$out/03_ZONE_BINARY.txt" 2>&1
  ldd "$zone" > "$out/04_LDD_BAGIMLILIKLAR.txt" 2>&1 || true
  readelf -d "$zone" > "$out/05_ELF_DYNAMIC.txt" 2>&1 || true
  strings -a "$zone" | grep -Eai 'select |insert |update |delete |call |procedure|mysql|maria|odbc|login|center|relay|playuser|gamelog|zone|11601|127\.0\.0\.1' \
    | sort -u > "$out/06_BINARY_SQL_PORT_STRINGS.txt" || true
else
  echo 'Çalıştırılabilir troy_zoned bulunamadı.' > "$out/03_ZONE_BINARY.txt"
fi

grep -RInEa --include='*.cpp' --include='*.c' --include='*.h' --include='*.hpp' --include='*.sql' \
  'SELECT|INSERT|UPDATE|DELETE|CALL|PROCEDURE|mysql_|MYSQL|ADO|ODBC|11601|zone|center|login' "$root" \
  > "$out/07_KAYNAK_SQL_KONTRATI.txt" 2>/dev/null || true

grep -RInEa --include='*.ini' --include='*.cfg' --include='*.conf' --include='*.xml' --include='*.json' --include='*.sh' \
  '11601|127\.0\.0\.1|localhost|port|server.?id|database|db_|login|center|zone|relay|playuser|gamelog' "$root" \
  > "$out/08_CONFIG_SERVIS_KONTRATI.txt" 2>/dev/null || true

find "$root" -type f \( -name '*.log' -o -name 'nohup.out' \) -printf '%T@|%p\n' 2>/dev/null \
  | sort -nr | head -n 100 | cut -d'|' -f2- > "$out/09_LOG_LISTESI.txt"

{
  echo '# TROY Zone 0317 kurtarma özeti'
  echo
  echo "- Kök: $root"
  echo "- Zone binary: ${zone:-BULUNAMADI}"
  echo "- Zaman: $(date --iso-8601=seconds)"
  echo
  echo 'Önce 04_LDD_BAGIMLILIKLAR.txt içindeki not found satırları çözülmelidir.'
  echo 'Ardından 07 ve 08 numaralı SQL/config kontratları karşılaştırılmalıdır.'
  echo 'Client testi, Zone SQL bağlantısı ve diğer servis sinyalleri doğrulandıktan sonra yapılır.'
} > "$out/00_OZET.md"

tar -czf "${out}.tar.gz" -C "$(dirname "$out")" "$(basename "$out")"
echo "Hazır: ${out}.tar.gz"