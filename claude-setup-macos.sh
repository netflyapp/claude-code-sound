#!/bin/bash
#
# Claude Code - macOS Setup Script
# Dodaje alias z dźwiękiem + powiadomieniem gdy Claude kończy i czeka na akceptację
#

echo "🚀 Claude Code - Setup dla macOS"
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
        # Usuń stary alias (wszystkie linie między 'claude() {' a odpowiadającym '}')
        sed -i.tmp '/claude() {/,/^}/d' ~/.zshrc
        rm ~/.zshrc.tmp
        echo "✅ Usunięto stary alias"
    else
        echo "⏭️  Pomijam - zostawiam obecny alias"
        exit 0
    fi
fi

# Dodaj nowy alias na koniec pliku
echo "" >> ~/.zshrc
echo "# Claude Code - dźwięk + notyfikacja po zakończeniu" >> ~/.zshrc
echo 'claude() {' >> ~/.zshrc
echo '  command claude "$@"' >> ~/.zshrc
echo '  osascript -e '\''display notification "Claude czeka na akceptację" with title "Claude Code" sound name "Glass"'\''' >> ~/.zshrc
echo '}' >> ~/.zshrc

echo ""
echo "✅ Alias dodany do ~/.zshrc"
echo ""
echo "🔄 Ładuję nową konfigurację..."
source ~/.zshrc

echo ""
echo "✨ GOTOWE!"
echo ""
echo "Od teraz gdy wpiszesz: claude"
echo "  🔔 usłyszysz dźwięk"
echo "  🖥  pojawi się popup"
echo ""
echo "🔊 Zmiana dźwięku (opcjonalnie):"
echo "   Edytuj ~/.zshrc i zamień 'Glass' na:"
echo "   - Ping, Pop, Hero, Funk, Submarine, etc."
echo ""
