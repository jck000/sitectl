
cp sitectl.sh /usr/local/bin
cp sitectl.cfg /etc

chmod ugo+rwx /usr/local/bin/sitectl.sh
chmod go-w /usr/local/bin/sitectl.sh

chmod ugo+r /etc/sitectl.cfg
chmod ugo-wx /etc/sitectl.cfg
