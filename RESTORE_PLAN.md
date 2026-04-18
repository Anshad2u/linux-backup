# Linux Reset & Restore Plan

## Phase 1: Before Reset

### Backup Summary (Already Done)
- **GitHub**: https://github.com/Anshad2u/linux-backup
- **Repos backed up**: insaintel, mymarky-data, mymarky-test, schedulechat, and more

### What Was Backed Up to GitHub
```
linux-backup/ (All repos in GitHub)
├── ssh_keys/           # SSH authentication
├── credentials/       # API keys and secrets
├── databases/         # SQLite databases
├── env_files/         # Environment configs
├── .bashrc           # Shell config
├── .gitconfig        # Git config
├── .profile         # Profile config
├── bin/             # Custom scripts
└── antigravity_tools/ # Tool settings
```

### What Needs Manual Restore (After Install)
- thunderbird/ (emails) - skip for now
- gemini/ (AI data) - skip for now

---

## Phase 2: After Linux Install

### 1. Install Essential Packages
```bash
# Update
sudo apt update && sudo apt upgrade -y

# Install dev tools
sudo apt install -y curl wget git vim build-essential

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs

# Install Docker
sudo apt install -y docker.io docker-compose

# Install Python
sudo apt install -y python3 python3-pip python3-venv

# Install VS Code
sudo apt install -y code

# Install browsers
sudo apt install -y firefox chromium-browser

# Install useful utils
sudo apt install -y htop neofetch bat exa
```

### 2. Setup GitHub Access
```bash
# Generate new SSH key
ssh-keygen -t ed25519 -C "anshadputtu@gmail.com"
# Add to GitHub > Settings > SSH Keys

# Set git config
git config --global user.name "Anshad"
git config --global user.email "anshadputtu@gmail.com"

# Clone backup repo
git clone git@github.com:Anshad2u/linux-backup.git ~/linux-backup

# Restore files
cp ~/linux-backup/ssh_keys/* ~/.ssh/
cp ~/linux-backup/credentials/* ~/Data/CRITICAL_BACKUP/credentials/
cp ~/linux-backup/databases/* ~/Data/CRITICAL_BACKUP/databases/
cp ~/linux-backup/.bashrc ~/.bashrc
cp ~/linux-backup/.gitconfig ~/.gitconfig

chmod 600 ~/.ssh/id_ed25519
```

### 3. Clone Your Project Repos
```bash
# Create projects directory
mkdir -p ~/Data/CRITICAL_BACKUP/anshad_projects

# Clone repos
git clone git@github.com:Anshad2u/insaintel.git ~/Data/CRITICAL_BACKUP/inshad_projects/insaintel
git clone git@github.com:Anshad2u/mymarky-data.git ~/Data/CRITICAL_BACKUP/anshad_projects/mymarky-data
git clone git@github.com:Anshad2u/mymarky-test.git ~/Data/CRITICAL_BACKUP/anshad_projects/mymarky-test
git clone git@github.com:Anshad2u/final-schedule-chat-backend.git ~/Data/Projects/schedulechat-backend
git clone git@github.com:Anshad2u/Final-Schedule-Chat-Frontend.git ~/Data/Projects/schedulechat-frontend
```

### 4. Install Project Dependencies
```bash
# Node projects
cd ~/Data/Projects/schedulechat-backend && npm install
cd ~/Data/Projects/schedulechat-frontend && npm install

# Python environments
cd ~/Data/CRITICAL_BACKUP/anshad_projects/insaintel && python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt
```

### 5. Start Docker Services
```bash
# Start PostgreSQL
docker run -d --name postgres -e POSTGRES_PASSWORD=password -v postgres_data:/var/lib/postgresql/data postgres:16-alpine

# Start Redis
docker run -d --name redis -p 6379:6379 redis:latest

# Start schedulechat
cd ~/Data/Projects/schedulechat-backend
docker-compose up -d
```

---

## Partition Merging Instructions

### Option A: Use GParted (Recommended)
1. Boot from Linux Mint USB
2. Open GParted
3. Delete /dev/sda8 (root partition)
4. Resize /dev/sda3 (Data partition) to fill unallocated space
5. Apply

### Option B: Command Line
```bash
# Boot from live USB first, then:
sudo parted /dev/sda
(parted) rm 8  # Remove root partition
(parted) resizepart 3 100%
(parted) quit
sudo resize2fs /dev/sda3
```

---

## Conversation Resume

After installing Linux and opencode, search for this conversation or run:
```bash
# The restore plan is also in GitHub
cat ~/linux-backup/RESTORE_PLAN.md
```

### Quick Resume Commands
```bash
# Clone all repos at once
~/linux-backup/bin/backup.sh

# Start all services
cd ~/Data/Projects/schedulechat-backend && docker-compose up -d
```

---

## Disk Space After Reset
- Root: ~90GB (instead of 92GB)
- Data: ~370GB (merged)
- No separate root partition needed

---

Generated: 2026-04-18
Backed up repositories: 10+