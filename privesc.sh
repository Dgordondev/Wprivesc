#!/bin/bash
clear

GTFOBINSSUID="aa-exec,ab,agetty,alpine,ar,arj,arp,as,ascii-xfr,ash,aspell,atobm,awk,base32,base64,basenc,basez,bash,bc,bridge,busctl,busybox,bzip2,cabal,capsh,cat,chmod,choom,chown,chroot,clamscan,cmp,column,comm,cp,cpio,cpulimit,csh,csplit,csvtool,cupsfilter,curl,cut,dash,date,dd,debugfs,dialog,diff,dig,distcc,dmsetup,docker,dosbox,ed,efax,elvish,emacs,env,eqn,espeak,expand,expect,file,find,fish,flock,fmt,fold,gawk,gcore,gdb,genie,genisoimage,gimp,grep,gtester,gzip,hd,head,hexdump,highlight,hping3,iconv,install,ionice,ip,ispell,jjs,join,jq,jrunscript,julia,ksh,ksshell,kubectl,ld.so,less,links,logsave,look,lua,make,mawk,minicom,more,mosquitto,msgattrib,msgcat,msgconv,msgfilter,msgmerge,msguniq,multitime,mv,nasm,nawk,ncftp,nft,nice,nl,nm,nmap,node,nohup,ntpdate,od,openssl,openvpn,pandoc,paste,perf,perl,pexec,pg,php,pidstat,pr,ptx,python,rc,readelf,restic,rev,rlwrap,rsync,rtorrent,run-parts,rview,rvim,sash,scanmem,sed,setarch,setfacl,setlock,shuf,soelim,softlimit,sort,sqlite3,ss,ssh-agent,ssh-keygen,ssh-keyscan,sshpass,start-stop-daemon,stdbuf,strace,strings,sysctl,systemctl,tac,tail,taskset,tbl,tclsh,tee,terraform,tftp,tic,time,timeout,troff,ul,unexpand,uniq,unshare,unsquashfs,unzip,update-alternatives,uudecode,uuencode,vagrant,varnishncsa,view,vim,vimdiff,vipw,w3m,watch,wc,wget,whiptail,xargs,xdotool,xmodmap,xmore,xxd,xz,yash,zsh,zsoelim"
GREENCODE="\e[32m"
REDCODE="\e[31m"
BLUECODE="\e[34m"
YELLOWCODE="\e[33m"
COLORCLOSE="\e[0m"

function separator (){
	echo
	echo -e "${BLUECODE}=====================================================================${COLORCLOSE}"
}

function header (){
    echo ' __      __                                                     '
    echo '/\ \  __/\ \                 __                                 '
    echo '\ \ \/\ \ \ \  _____   _ __ /\_\  __  __    __    ____    ___   '
    echo ' \ \ \ \ \ \ \/\  __`\/\` __\/\ \/\ \/\ \ / __`\ / ,__\  / ___\ '
    echo '  \ \ \_/ \_\ \ \ \L\ \ \ \/ \ \ \ \ \_/ /\  __//\__, `\/\ \__/ '
    echo '   \ `\___x___/\ \ ,__/\ \_\  \ \_\ \___/\ \____\/\____/\ \____\'
    echo '     \/__//__/  \ \ \/  \/_/   \/_/\/__/  \/____/\/___/  \/____/'
    echo '                 \ \_\                                          '
    echo '                  \/_/                                          '
	echo
	echo -e "${BLUECODE}=================================================================${COLORCLOSE}"
	echo -e "                     Dveloped by: ${YELLOWCODE}ElWeoner${COLORCLOSE}                         "
	echo -e "${BLUECODE}=================================================================${COLORCLOSE}"
}

function sudoers (){
	echo -e "${BLUECODE}Permisos a nivel de sudoers"
	echo -e "============================${COLORCLOSE}"
	echo
	
    SUDOERS=$(sudo -ln 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "$SUDOERS" | tac | sed -n '/may run the following commands/!p;/may run the following commands/q' | tac
    else
        echo 'No tenemos acceso acceso o no tenemos permisos a nivel de sudoers.'
    fi
}

function suid (){
	echo -e "${BLUECODE}Permisos SUID"
    echo -e "==============${COLORCLOSE}"
	echo
	
    SUID=$(find / -perm -4000 2>/dev/null)
    for perm in $SUID; do
    	BASE=$(basename "$perm")
		if [[ ",$GTFOBINSSUID," == *",$BASE,"* ]]; then
			echo -e "$GREENCODE$perm$COLORCLOSE"
		else
			echo -e "$REDCODE$perm$COLORCLOSE"
		fi  
    done
}

function listcrontab (){
	echo -e "${BLUECODE}Crontab"
	echo -e "========${COLORCLOSE}"
	echo
	
	CRON=$(crontab -l 2>/dev/null)
	if [ -z $CRON ]; then 
		echo "El cron no esta accesible para nuestro usuario o no esta activo"
	else
		echo $CRON
	fi
}

function interestingdirs (){
	echo -e "${BLUECODE}Directorios interesantes"
	echo -e "=========================${COLORCLOSE}"
	echo

	echo /OPT
	echo -----
	ls -la /opt
	echo
	echo /TMP
	echo -----
	ls -al /tmp
}

function runproc (){
	echo -e "${BLUECODE}Procesos en ejecucion"
    echo -e "=========================${COLORCLOSE}"
	echo
	
    ps aux
}

separator
header
separator
sudoers
separator
suid
separator
listcrontab
separator
interestingdirs
separator
runproc