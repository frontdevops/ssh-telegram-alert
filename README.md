# ssh-telegram-alert
Telegram notifications about ssh authorization on the server

<img src="https://raw.githubusercontent.com/frontdevops/ssh-telegram-alert/main/tgscreen.png" height="400">

1. First you need to create a telegram bot via https://t.me/BotFather
2. Then create a private (or not, as you prefer) channel for alerts
3. Create a URI as follows:
```bash
https://api.telegram.org/bot*****:***-*****************/getUpdates
```
and invoke it

4. Add your bot to the channel
5. Get channel ID from `https://api.telegram.org/bot*****:***-*****************/getUpdates`

<img src="https://raw.githubusercontent.com/frontdevops/ssh-telegram-alert/main/tg-check-id.png" height="200">

4. Register at https://ipinfo.io/ and get an API token
5. Fill in the variables in the script
6. `chown +x ssh-alert.sh`
7. Call the script and check that everything works correctly
8. vi /etc/pam.d/sshd and enter at the end of the file
```
session optional pam_exec.so type=open_session seteuid /full/path/to/ssh-alert.sh
```
Try connecting to the server via ssh and enjoy your notification system
