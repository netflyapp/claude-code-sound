#!/bin/bash
#
# Claude Code - macOS Setup Script (WERSJA PRO)
# Dźwięk TYLKO gdy Claude pyta o akceptację [y/N]
#

echo "🚀 Claude Code - Setup PRO dla macOS"
echo ""

# Backup obecnego .zshrc
if [ -f ~/.zshrc ]; then
    echo "📦 Tworzę backup ~/.zshrc → ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
fi

# Sprawdź czy alias już istnieje
if grep -q "claude() {" ~/.zshrc 2>/dev/null; then
    echo "⚠️  Alias 'claude' już istnieje w ~/.zshrc"
    echo ""
    echo "Wybierz opcję:"
    echo "1) Zastąp istniejący alias (usuń stary, dodaj nowy)"
    echo "2) Pomiń (zostaw jak jest)"
    read -p "Wybór [1/2]: " choice

    if [ "$choice" = "1" ]; then
        # Usuń stary alias
        sed -i.tmp '/claude() {/,/^}/d' ~/.zshrc
        rm ~/.zshrc.tmp
        echo "✅ Usunięto stary alias"
    else
        echo "⏭️  Pomijam - zostawiam obecny alias"
        exit 0
    fi
fi

# Dodaj WERSJĘ PRO - dźwięk tylko gdy pojawi się prompt akceptacji
echo "" >> ~/.zshrc
echo "# Claude Code - dźwięk TYLKO gdy wymaga akcji (WERSJA PRO)" >> ~/.zshrc
echo 'claude() {' >> ~/.zshrc
echo '  output=$(command claude "$@" 2>&1 | tee /dev/tty)' >> ~/.zshrc
echo '  if echo "$output" | grep -Ei "accept|\[y/N\]|approve|proceed"; then' >> ~/.zshrc
echo '    osascript -e '\''display notification "Claude wymaga akcji 👀" with title "Claude Code - Akcja wymagana" sound name "Glass"'\''' >> ~/.zshrc
echo '  fi' >> ~/.zshrc
echo '}' >> ~/.zshrc

echo ""
echo "✅ Alias PRO dodany do ~/.zshrc"
echo ""
echo "🔄 Ładuję nową konfigurację..."
source ~/.zshrc

echo ""
echo "✨ GOTOWE!"
echo ""
echo "🎯 WERSJA PRO aktywna:"
echo "  🔕 Brak dźwięku przy normalnych odpowiedziach"
echo "  🔔 Dźwięk TYLKO gdy Claude pyta o akceptację"
echo "  🖥  Popup z 'Akcja wymagana'"
echo ""
echo "🔊 Zmiana dźwięku:"
echo "   Edytuj ~/.zshrc i zamień 'Glass' na inny"
echo ""
