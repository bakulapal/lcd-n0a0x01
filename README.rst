lcd-n0a0x01

---

External Linux kernel module for the LCD found in Seagate NAS Pro devices
(2, 4, and 6-bay).

# Build and install

Install matching kernel headers, then run::

```
make
sudo make install
```

The module is installed and configured to load automatically at boot.
The LCD device is available as `/dev/lcd`.

# Display IP address and time

To update the display every minute, add this command to root's crontab
(`sudo crontab -e`)::

```
* * * * * [ -e /dev/lcd ] && echo "$(printf '%-16s' "$(ip -4 -o addr show dev eth0 | awk '{split($4,a,"/"); print a[1]}')")$(date +'%H:%M')" > /dev/lcd
```

Replace `eth0` with the desired network interface.

