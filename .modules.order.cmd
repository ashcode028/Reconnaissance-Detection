cmd_/root/temp/modules.order := {   echo /root/temp/LKM.ko; :; } | awk '!x[$$0]++' - > /root/temp/modules.order
