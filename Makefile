obj-m :=LKM.o
LKM-objs += simple_netfilter_LKM.o
all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
	rm -r -f *.mod.c .*.cmd *.symvers *.o
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean                                                                                                                            
