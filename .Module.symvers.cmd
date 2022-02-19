cmd_/root/temp/Module.symvers := sed 's/\.ko$$/\.o/' /root/temp/modules.order | scripts/mod/modpost  -a  -o /root/temp/Module.symvers -e -i Module.symvers  -N -T -
