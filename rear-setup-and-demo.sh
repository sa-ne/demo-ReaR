#!/bin/bash

TextReset='\033[0m'
TextGreen='\033[32m'
TextBlue='\033[34m'
TextLightGrey='\033[37m'
TextBold='\033[1m'

FormatTextPause="$TextReset $TextLightGrey"  # Pause & continue
FormatTextCommands="$TextReset $TextGreen" # Commands to execute
FormatTextSyntax="$TextReset $TextBlue $TextBold" # Command Syntax & other text

# Place before command line to reset text format
FormatRunCommand="echo -e $TextReset"

# Reset text if script exits abnormally
trap 'echo -e $TextReset;exit' 1 2 3 15

clear
echo -e $FormatTextSyntax "
		Demo: Relax and Recover (ReaR)

   Install the rear package and its dependencies by running the following command as root:

"
echo -e $FormatTextCommands "
	# yum install rear genisoimage syslinux

"
$FormatRunCommand
yum install -y rear genisoimage syslinux
echo -e $FormatTextPause && read -p "<-- Press any key to continue -->" NULL

echo -e $FormatTextSyntax "
ReaR is configured in the /etc/rear/local.conf file.

	OUTPUT=ISO				# to create a boot ISO
	OUTPUT=USB				# to create a bootable USB
	OUTPUT=PXE				# create files on PXE/NFS server

	OUTPUT_URL=file:///mnt/rescue/		# default = /var/lib/rear/output
	OUTPUT_URL=nfs://server/share		# mount NFS
	OUTPUT_URL=http:// or https://		# write (PUT) to http(s)
	OUTPUT_URL=sftp://			# use sftp
	OUTPUT_URL=rsync://			# use rsync
	OUTPUT_URL=sshfs://			# use ssh
	OUTPUT_URL=null				# do not copy (i.e. using external backup)

"
echo -e $FormatTextPause && read -p "<-- Press any key to continue -->" NULL

echo -e $FormatTextSyntax "
   How to create a rescue system with verbose output:
"
echo -e $FormatTextCommands "
	# rear -v mkrescue
"
echo -e $FormatTextSyntax "
   To make ReaR create a rescue system at 22:00 every weekday, add to the /etc/crontab file:
	0 22 * * 1-5 root /usr/sbin/rear mkrescue
"
echo -e $FormatTextPause && read -p "<-- Press any key to continue -->" NULL

echo -e $FormatTextSyntax '
   When using ReaR for backup:

	BACKUP=REQUESTRESTORE			# default, prompts for restore
	BACKUP=NETFS				# internal backup method
	BACKUP=[see list below]			# support for external backup program
	BACKUP=EXTERNAL				# specify commands if not listed below

	BACKUP_URL=file:///srv/backup/		# write to file	
	BACKUP_URL=nfs://srv/share		# mount and write to NFS
	BACKUP_URL=rsync://user@host:/path	# use rsync
	BACKUP_URL=iso:///backup		# include backup on ISO
	BACKUP_URL=usb:///dev/disk		# write to USB device (i.e. external drive)
	BACKUP_URL=sshfs://user@host/path	# use ssh

	NETFS_KEEP_OLD_BACKUP_COPY=y		# internal only
	BACKUP_TYPE=incremental			# internal only
	FULLBACKUPDAY="Day"			# internal only = Mon, Tue, Wed, Thu, Fri, Sat, Sun

   Supported backup methods, see man page for full list:  
	CommVault Galaxy 5 (GALAXY)	CommVault Galaxy 7 (GALAXY7)	CommVault Galaxy 10 (GALAXY10)
	Symantec NetBackup (NBU)	IBM Tivoli Storage Mgr (TSM)	EMC NetWorker/Legato (NSR) 

   Full example conf file at: /usr/share/rear/conf/default.conf

'
echo -e $FormatTextPause && read -p "<-- Press any key to continue -->" NULL

echo -e $FormatTextSyntax "
   Adding to /etc/rear/local.conf
	OUTPUT=ISO
	OUTPUT_URL=nfs://gateway/home/mtonneso/Downloads/
	BACKUP=NETFS
	BACKUP_URL=nfs://gateway/home/mtonneso/Downloads/

   Then run a backup
"
echo -e $FormatTextCommands "
	# rear -v mkbackup
"
$FormatRunCommand
echo -e 'export TMPDIR=/root/scripts/\nOUTPUT=ISO\nOUTPUT_URL=nfs://gateway/home/mtonneso/Downloads/\nBACKUP=NETFS\nBACKUP_URL=nfs://gateway/home/mtonneso/Downloads/'>>/etc/rear/local.conf
rear -v mkbackup

echo -e $FormatTextSyntax '
   To perform a restore or migration:
	1. Boot the rescue system on the new hardware.
	2. In the console interface, select the "Recover" option
	3. At the rescue prompt, run the "rear recover" command to perform the restore or migration.
	   The rescue system then recreates the partition layout and filesystems
	4. Restore user and system files from the backup into the /mnt/local/ directory (i.e. from a tarball)
	5. Ensure that SELinux relabels the files on the next boot: 
		# touch /mnt/local/.autorelabel
	6. Reboot

'
echo -e $FormatTextPause && read -p "<-- End of ReaR Demo: Press any key to continue -->" NULL && echo -e $TextReset

