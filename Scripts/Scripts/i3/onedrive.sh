rclone --copy-links --vfs-cache-mode=full --vfs-read-ahead=10M --vfs-cache-max-age=1000h \
       --vfs-cache-max-size=2G mount unionedrive: ~/OneDrive/unionedrive/
# --umask 000
