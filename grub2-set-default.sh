cat /etc/default/grub | grep '^GRUB_DEFAULT='
sed 's/^GRUB_DEFAULT=.*/GRUB_DEFAULT=saved/g' -i /etc/default/grub
cat /etc/default/grub | grep '^GRUB_DEFAULT='
grub2-mkconfig -o "$(readlink -e /etc/grub2.cfg)"

grub2-editenv list
grub2-set-default "$(grep -i '^menuentry ' /etc/grub2.cfg | cut -d\' -f2 | sort -V | tail -n 1)"
grub2-editenv list

