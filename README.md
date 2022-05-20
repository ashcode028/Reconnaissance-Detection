# Linux Kernel Netfilter Module

A loadable kernel firewall module that can detect specific packets and drop them. 
More specifically, using netfilter framework hook functions
(kernel call back functions) that user modules could access and obtain the detail of
packets.

## Testing
On VM1, use the network reconnaissance tool nmap that sends crafted
reconnaissance packets to the VM2 (e.g. TCP half-open scan packets, TCP connect
packets, UDP packets etc.). So, install nmap in VM1

On VM2, load the kernel module that use the Netfilter hook
functions to obtain packets and identify the three reconnaissance scans E.g. the TCP half open
scan sends only a single TCP SYN packet, expecting a SYN/ACK, RST or at worst no
response. Once identified logs these detections into syslog.
In this vm , clone this repo and run make.

<aside>
💡 The module is being loaded in artix system with runit as init system.All steps would be similar except installing headers and updation

</aside>

## Step 1 : Update the kernel and then install headers

>> `pacman -SyU` 

>> `pacman -Sy linux linux-headers`

## Step 2 : Module Usage

Get the script from this repo.

**simple_netfilter_LKM.c** file ****contains the script.

>>`git clone [https://github.com/ashcode028/LKM-Reconnaissance-Detection](https://github.com/ashcode028/LKM-Reconnaissance-Detection)` or downloading the zip file attached.

>>`cd LKM-Reconnaissance-Detection/`

>> `make`

Here, Makefile by default runs `insmod` command.So, before running `make` again, run `make clean` .

### About the module

<aside>
💡 Major usages of netfilter hook functions and its meaning can be clearly understood from [this blog](https://infosecwriteups.com/linux-kernel-communication-part-1-netfilter-hooks-15c07a5a5c4e)

> *Netfilter is a framework for packet mangling, outside the normal Berkeley socket interface. It has four parts. Firstly, each protocol defines “hooks” (IPv4 defines 5) which are well-defined points in a packet’s traversal of that protocol stack. At each of these points, the protocol will call the netfilter framework with the packet and the hook number.*
> 
</aside>

This kernel module intercepts TCP packets and logs the detected scan type using ***prink()***. In each TCP packet, we parse the flag bits set in the tcp header using netfilter hook functions,then detect the type of scan based on it. Once the recon packet is detected, those packets are dropped. If a UDP packet is detected, then if it is destined to port 53 is accepted otherwise dropped.Dropped packets are not logged.

Supported scans/ recon packets are 

1. SYN scan: only syn flag set
2. FIN scan: only fin flag set
3. XMAS scan: fin,urg and psh set
4. NULL scan: all flag bits unset
5. ACK/Window scan: only ack bit set

Once you load the module using `insmod LKM.ko` , output of `dmesg | tail`

![Screenshot from 2022-02-20 20-15-55.png](Linux%20Kernel%20Netfilter%20Module%20fc5227bc12664995a805ab67986dabe9/Screenshot_from_2022-02-20_20-15-55.png)

even if the verification is failed , dont worry you can proceed to next steps.

## Step 3: Running Test scripts

>> These steps are run in another (pen-testing) machine.

>> To check indivdual scans , generic command `nmap <flag> <ip of machine to scan>`

### Sample output

For eg, XMAS scan `nmap -sX 172.12.16.131`

Check the system logs in the machine using `dmesg` after each scan.

![Screenshot from 2022-02-20 23-19-45.png](Linux%20Kernel%20Netfilter%20Module%20fc5227bc12664995a805ab67986dabe9/Screenshot_from_2022-02-20_23-19-45.png)

>> To run all scans at once using `./Test-script.sh`

![Screenshot from 2022-02-21 12-57-08.png](Linux%20Kernel%20Netfilter%20Module%20fc5227bc12664995a805ab67986dabe9/Screenshot_from_2022-02-21_12-57-08.png)

### Resources used :

[https://github.com/repalash/Detect-Nmap-scans](https://github.com/repalash/Detect-Nmap-scans)

[https://infosecwriteups.com/linux-kernel-communication-part-1-netfilter-hooks-15c07a5a5c4e](https://infosecwriteups.com/linux-kernel-communication-part-1-netfilter-hooks-15c07a5a5c4e)

[https://github.com/naman/netfilter-module](https://github.com/naman/netfilter-module)

[https://stackoverflow.com/questions/39426783/netfilter-kernel-module-to-intercept-packets-and-log-them](https://stackoverflow.com/questions/39426783/netfilter-kernel-module-to-intercept-packets-and-log-them)

[https://github.com/wangm8/Netfilter-Kernel-Module](https://github.com/wangm8/Netfilter-Kernel-Module)

[https://tuxthink.blogspot.com/2021/04/loading-modules-automatically-on-boot.html](https://tuxthink.blogspot.com/2021/04/loading-modules-automatically-on-boot.html)

[https://nmap.org/book/man-port-scanning-techniques.html](https://nmap.org/book/man-port-scanning-techniques.html)
