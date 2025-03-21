# NixOS Конфигурация

Этот репозиторий содержит мою персональную конфигурацию NixOS с использованием flakes.

## Установка

### Свежая установка

1. Загрузитесь с установочного носителя NixOS

2. Включите поддержку flakes (не обязательно)
   ```bash
   mkdir -p ~/.config/nix
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   ```

3. Клонируйте этот репозиторий (советую перебросить к пользователю, либо в etc/nixos)
   ```bash
   git clone https://github.com/TOwInOK/config-nixos.git
   cd config-nixos
   ```

4. Разметка диска с помощью disko
   ```bash
   # Проверьте конфигурацию разметки в ./modules/nixos/disko.nix
   # Замените /dev/sda на нужный вам диск
   sudo nix run github:nix-community/disko -- --mode dryrun ./config/disko.nix
   # или если не использовали 2-ой пункт
   sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disco.nix
   # Если всё верно, запустите реальную разметку
   sudo nix run github:nix-community/disko -- --mode zap_create_mount ./config/disko.nix
   ```

5. Установите NixOS с помощью флейка
   ```bash
   nixos-install --flake .#twk
   ```

6. Перезагрузите систему
   ```bash
   reboot
   ```

7. После первой загрузки примените конфигурацию home-manager
   ```bash
   home-manager switch --flake .#towinok@twk
   ```

### Обновление системы

Для обновления конфигурации системы:
```bash
sudo nixos-rebuild switch --flake .#twk
```

Для обновления конфигурации home-manager:
```bash
home-manager switch --flake .#towinok@twk
```

### Устранение неполадок

При возникновении проблем:
- Проверьте системные логи: `journalctl -b`
- Проверьте конфигурацию флейка: `nix flake check`
- При необходимости загрузитесь в предыдущую генерацию (выберите из меню GRUB)
- Проверьте статус сервисов: `systemctl status`

### Полезные команды

```bash
# Обновить все пакеты
nix flake update

# Очистить неиспользуемые пакеты
sudo nix-collect-garbage -d

# Посмотреть историю поколений системы
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Откатиться к предыдущей конфигурации
sudo nixos-rebuild switch --rollback
```

## Структура конфигурации

```
.
├── config/
│   ├── nixos/          # Конфигурация системы
│   └── home-manager/   # Пользовательские настройки
|   └── disko.nix       # Конфигурация диска
├── modules/
│   ├── nixos/          # Модули NixOS
│   └── home-manager/   # Модули home-manager
└── flake.nix          # Основной файл конфигурации
```

## Лицензия
MIT
