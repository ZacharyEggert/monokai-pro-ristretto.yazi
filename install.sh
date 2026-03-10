#!/usr/bin/env bash
set -e

FLAVORS_DIR="$HOME/.config/yazi/flavors"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$FLAVORS_DIR"

themes=(
  monokai-classic
  monokai-pro
  monokai-pro-filter-machine
  monokai-pro-filter-octagon
  monokai-pro-filter-ristretto
  monokai-pro-filter-spectrum
  monokai-pro-light
  monokai-pro-light-filter-sun
)

echo "Copying themes to $FLAVORS_DIR..."
for theme in "${themes[@]}"; do
  cp -r "$SCRIPT_DIR/$theme.yazi" "$FLAVORS_DIR/"
done
echo "Done."

echo ""
echo "Available themes:"
for i in "${!themes[@]}"; do
  echo "  $((i+1)). ${themes[$i]}"
done

echo ""
read -p "Enter number of theme to enable: " choice

if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#themes[@]}" ]; then
  echo "Invalid selection." >&2
  exit 1
fi

selected="${themes[$((choice-1))]}"

cat > "$HOME/.config/yazi/theme.toml" <<EOF
[flavor]
dark = "$selected"
EOF

echo "Enabled: $selected"
