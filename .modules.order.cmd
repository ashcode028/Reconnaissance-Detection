cmd_/root/temp/modules.order := {   echo /root/temp/simple_netfilter_LKM.ko; :; } | awk '!x[$$0]++' - > /root/temp/modules.order
