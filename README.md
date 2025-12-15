# 🔔 Claude Code Sound Notifications for macOS

> Get audio alerts and system notifications when Claude Code finishes tasks and waits for your approval

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: macOS](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](https://www.apple.com/macos/)
[![Shell: Zsh](https://img.shields.io/badge/shell-zsh-blue.svg)](https://www.zsh.org/)

## 🎯 What is this?

A simple setup that adds **sound notifications** and **system popups** to [Claude Code](https://claude.ai/code) on macOS. Never miss when Claude is waiting for your approval again!

Perfect for:
- 🔄 Switching between Terminal and other apps (Obsidian, Cursor, browsers)
- 🎨 AI-coding workflows with multiple tools
- 📝 Working with tmux or multiple terminal windows
- 🧠 Deep focus work where you need audio cues

## ✨ Features

- 🔔 **Audio alerts** when Claude finishes
- 🖥 **System notifications** with custom messages
- 🎛 **Two modes**: Basic (always notify) or PRO (only on `[y/N]` prompts)
- 🔊 **Customizable sounds** (choose from macOS system sounds)
- 🎨 **Optional tmux integration** with status bar alerts
- 🔙 **Automatic backups** of your `.zshrc` file

## 🚀 Quick Start

### Option 1: Basic Version (Always Notify)

Sound + notification after **every Claude response**:

```bash
git clone https://github.com/YOUR_USERNAME/claude-code-sound.git
cd claude-code-sound
chmod +x claude-setup-macos.sh
./claude-setup-macos.sh
```

### Option 2: PRO Version (Smart Notifications) ⭐ Recommended

Sound + notification **ONLY when Claude asks for approval** (`[y/N]`, `Accept?`):

```bash
git clone https://github.com/YOUR_USERNAME/claude-code-sound.git
cd claude-code-sound
chmod +x claude-setup-macos-pro.sh
./claude-setup-macos-pro.sh
```

## 🧪 Test It

After installation:

```bash
claude
```

You should:
1. Hear a sound (default: "Glass")
2. See a system notification
3. Get a popup when Claude is waiting

## 🔊 Customize Sound

Edit your `~/.zshrc`:

```bash
nano ~/.zshrc
```

Find the line:
```bash
sound name "Glass"
```

Replace `"Glass"` with any macOS system sound:
- **Ping** - short, discrete
- **Pop** - soft pop
- **Hero** - heroic chime
- **Funk** - funky beat
- **Submarine** - sonar ping
- **Purr** - very quiet
- **Blow** - whoosh sound

See all available sounds:
```bash
ls /System/Library/Sounds/
```

After changing, reload:
```bash
source ~/.zshrc
```

## 📚 Advanced Usage

### Different Sounds for Different Actions

Edit `~/.zshrc` to add context-aware notifications:

```bash
claude() {
  output=$(command claude "$@" 2>&1 | tee /dev/tty)

  if echo "$output" | grep -Ei "error|failed"; then
    osascript -e 'display notification "Error occurred" with title "Claude Code - Error" sound name "Funk"'
  elif echo "$output" | grep -Ei "accept|\[y/N\]|approve"; then
    osascript -e 'display notification "Action required 👀" with title "Claude Code" sound name "Glass"'
  elif echo "$output" | grep -Ei "completed|done|finished"; then
    osascript -e 'display notification "Task completed ✅" with title "Claude Code" sound name "Hero"'
  fi
}
```

### Colored Terminal Prompts

Add visual status indicators:

```bash
claude() {
  echo -e "\n🤖 \033[1;36mClaude Code running...\033[0m\n"
  output=$(command claude "$@" 2>&1 | tee /dev/tty)

  if echo "$output" | grep -Ei "accept|\[y/N\]"; then
    echo -e "\n⚠️  \033[1;33mWAITING FOR APPROVAL\033[0m\n"
    osascript -e 'display notification "Action required" with title "Claude Code" sound name "Glass"'
  else
    echo -e "\n✅ \033[1;32mCompleted\033[0m\n"
  fi
}
```

### tmux Integration

Visual alerts in tmux status bar:

```bash
claude() {
  command claude "$@"
  osascript -e 'display notification "Claude waiting" with title "Claude Code" sound name "Glass"'

  # Set red status in tmux
  if [ -n "$TMUX" ]; then
    tmux set-option -g status-style "bg=red"
    sleep 2
    tmux set-option -g status-style "bg=green"
  fi
}
```

## 🔧 Troubleshooting

### No sound playing

1. Check system sound settings:
   - System Settings → Sound → Alert volume
   - System Settings → Notifications → Terminal (enable notifications)

2. Test the notification manually:
   ```bash
   osascript -e 'display notification "Test" sound name "Glass"'
   ```

### Alias not working

1. Check if alias was added:
   ```bash
   cat ~/.zshrc | grep "claude()"
   ```

2. Reload configuration:
   ```bash
   source ~/.zshrc
   ```

3. Verify `claude` is in PATH:
   ```bash
   which claude
   ```

### Notifications not appearing

Enable notifications for your Terminal app:
1. System Settings → Notifications
2. Find "Terminal" (or "iTerm2" / "Warp")
3. Enable "Allow notifications"

## 🔙 Restore Backup

If something goes wrong:

```bash
# List available backups
ls -la ~ | grep "zshrc.backup"

# Restore backup (replace with your timestamp)
cp ~/.zshrc.backup.20231215_143022 ~/.zshrc

# Reload
source ~/.zshrc
```

## 📖 Documentation

Full documentation with all options available in [`CLAUDE-SETUP-MACOS.md`](./CLAUDE-SETUP-MACOS.md)

## 🤝 Contributing

Contributions welcome! Feel free to:
- 🐛 Report bugs
- 💡 Suggest new features
- 🔧 Submit pull requests
- 📖 Improve documentation

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details

## 🙏 Credits

Created for the [Claude Code](https://claude.ai/code) community.

## ⭐ Show Your Support

If this tool helps your workflow, give it a star! ⭐

---

**Made with ❤️ for developers who love AI-assisted coding**
