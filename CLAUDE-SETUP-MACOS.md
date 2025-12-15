# 🔔 Claude Code - Setup dla macOS

Gotowy setup, który daje **dźwięk + powiadomienie**, gdy Claude Code kończy i czeka na akceptację.

---

## ⚡ SZYBKI START (WERSJA PODSTAWOWA)

Dźwięk + notyfikacja **po każdej odpowiedzi** Claude:

```bash
cd /Users/miloszzajac/Desktop/02_projekty/202512121208_fluent\ coomunity\ autoodpowiedzi/fluent-community-ai-responder
chmod +x claude-setup-macos.sh
./claude-setup-macos.sh
```

Efekt:
- ✅ Alias `claude` z dźwiękiem
- 🔔 Dźwięk "Glass" + popup systemowy
- 🖥 Notyfikacja: "Claude czeka na akceptację"

---

## 🎯 WERSJA PRO (POLECAM)

Dźwięk **TYLKO gdy Claude pyta o akceptację** (`[y/N]`, `Accept?`):

```bash
cd /Users/miloszzajac/Desktop/02_projekty/202512121208_fluent\ coomunity\ autoodpowiedzi/fluent-community-ai-responder
chmod +x claude-setup-macos-pro.sh
./claude-setup-macos-pro.sh
```

Efekt:
- 🔕 Brak dźwięku przy normalnych odpowiedziach
- 🔔 Dźwięk TYLKO gdy wymaga akcji
- 🖥 Notyfikacja: "Claude wymaga akcji 👀"

---

## 🔊 ZMIANA DŹWIĘKU

Po instalacji możesz zmienić dźwięk. Edytuj `~/.zshrc`:

```bash
nano ~/.zshrc
```

Znajdź linię:

```bash
sound name "Glass"
```

Zamień `"Glass"` na:
- **Ping** - krótkie „ping"
- **Pop** - miękkie „pop"
- **Hero** - bohaterski dźwięk
- **Funk** - funkowy beat
- **Submarine** - sonar
- **Tink** - metaliczny
- **Purr** - cichy
- **Blow** - podmuch

Lista wszystkich dźwięków:

```bash
ls /System/Library/Sounds/
```

---

## 🎨 DODATKOWE OPCJE

### 1️⃣ Różne dźwięki dla różnych akcji

Dodaj do `~/.zshrc`:

```bash
claude() {
  output=$(command claude "$@" 2>&1 | tee /dev/tty)

  if echo "$output" | grep -Ei "error|failed"; then
    osascript -e 'display notification "Wystąpił błąd" with title "Claude Code - Błąd" sound name "Funk"'
  elif echo "$output" | grep -Ei "accept|\[y/N\]|approve"; then
    osascript -e 'display notification "Claude wymaga akcji 👀" with title "Claude Code" sound name "Glass"'
  elif echo "$output" | grep -Ei "completed|done|finished"; then
    osascript -e 'display notification "Zadanie zakończone ✅" with title "Claude Code" sound name "Hero"'
  fi
}
```

### 2️⃣ Kolorowy prompt w terminalu

Dodaj wizualną informację o statusie:

```bash
claude() {
  echo -e "\n🤖 \033[1;36mClaude Code running...\033[0m\n"
  output=$(command claude "$@" 2>&1 | tee /dev/tty)

  if echo "$output" | grep -Ei "accept|\[y/N\]"; then
    echo -e "\n⚠️  \033[1;33mCZEKA NA AKCEPTACJĘ\033[0m\n"
    osascript -e 'display notification "Claude wymaga akcji" with title "Claude Code" sound name "Glass"'
  else
    echo -e "\n✅ \033[1;32mZakończono\033[0m\n"
  fi
}
```

### 3️⃣ Integracja z tmux

Jeśli używasz tmux, dodaj powiadomienie do paska statusu:

```bash
claude() {
  command claude "$@"
  osascript -e 'display notification "Claude czeka" with title "Claude Code" sound name "Glass"'

  # Ustaw czerwony status w tmux
  if [ -n "$TMUX" ]; then
    tmux set-option -g status-style "bg=red"
    sleep 2
    tmux set-option -g status-style "bg=green"
  fi
}
```

---

## 🧪 TESTOWANIE

Po instalacji przetestuj:

```bash
claude
```

Powinieneś:
1. Zobaczyć interfejs Claude Code
2. Usłyszeć dźwięk
3. Zobaczyć powiadomienie systemowe

---

## 🔙 PRZYWRACANIE BACKUPU

Jeśli coś pójdzie nie tak:

```bash
# Zobacz dostępne backupy
ls -la ~ | grep "zshrc.backup"

# Przywróć backup (podmień datę)
cp ~/.zshrc.backup.20231215_143022 ~/.zshrc

# Załaduj ponownie
source ~/.zshrc
```

---

## ❓ TROUBLESHOOTING

### Nie słyszę dźwięku

1. Sprawdź ustawienia systemowe:
   - System Settings → Sound → Alert volume
   - System Settings → Notifications → Terminal (włącz)

2. Sprawdź czy skrypt działa:
   ```bash
   osascript -e 'display notification "Test" sound name "Glass"'
   ```

### Alias nie działa

1. Sprawdź czy został dodany:
   ```bash
   cat ~/.zshrc | grep "claude()"
   ```

2. Załaduj ponownie:
   ```bash
   source ~/.zshrc
   ```

3. Sprawdź czy `claude` jest w PATH:
   ```bash
   which claude
   ```

### Powiadomienia nie działają

Włącz powiadomienia dla Terminala:
1. System Settings → Notifications
2. Znajdź "Terminal" (lub "iTerm2" / "Warp")
3. Włącz "Allow notifications"

---

## 🚀 WORKFLOW Z OBSIDIAN

Setup idealny gdy:
- Przełączasz się między **Claude Code** (Terminal) → **Obsidian** (PRD/prompty)
- Robisz **AI-coding loop** (Claude + Cursor)
- Pracujesz z **wieloma terminalami**

Dźwięk + notyfikacja informują Cię, że:
- Claude skończył i czeka
- Możesz wrócić do Terminala
- Trzeba zaakceptować akcję

---

## 📚 DODATKOWE ZASOBY

- [Lista wszystkich dźwięków macOS](https://developer.apple.com/design/human-interface-guidelines/playing-sounds)
- [AppleScript Guide](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/)
- [Customizing zsh](https://zsh.sourceforge.io/Doc/Release/User-Contributions.html)

---

## 💡 PRO TIPS

1. **Używaj wersji PRO** - mniej rozpraszająca
2. **Dostosuj dźwięk** - wybierz mniej inwazyjny niż "Glass"
3. **Dodaj kolorowe prompty** - wizualna informacja o statusie
4. **Testuj w tmux** - świetnie działa z panelami

---

**Autor:** Setup na podstawie oryginalnej instrukcji
**Data:** 2025-12-15
**Wersja:** 1.0
