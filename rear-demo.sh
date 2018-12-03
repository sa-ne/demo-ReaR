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

		Relax-and-Recover (ReaR), a disaster recovery and system migration utility.
		ReaR complements backup software by creating a rescue system. Booting the
		rescue system on a new hardware allows you to issue the rear recover
		command, which starts the recovery process.

		During this process, ReaR replicates the partition layout and filesystems,
		prompts for restoring user and system files from the backup created by
		backup software, and finally installs the boot loader.

"
echo -e $FormatTextPause && read -p "<-- Press any key to continue -->" NULL

echo -e $FormatTextSyntax "
ReaR is configured via the /etc/rear/site.conf file.

	OUTPUT=ISO \t\t\t\t # to create a boot ISO
	OUTPUT=USB \t\t\t\t # to create a bootable USB
	OUTPUT=PXE \t\t\t\t # create files on PXE/NFS server

	OUTPUT_URL=file:///mnt/rescue/ \t\t # default = /var/lib/rear/output
	OUTPUT_URL=nfs://server/share \t\t # mount NFS
	OUTPUT_URL=http:// or https:// \t\t # write (PUT) to http(s)
	OUTPUT_URL=sftp:// \t\t\t # use sftp
	OUTPUT_URL=rsync:// \t\t\t # use rsync
	OUTPUT_URL=sshfs:// \t\t\t # use ssh
	OUTPUT_URL=null \t\t\t # do not copy (i.e. using external backup)

"
echo -e $FormatTextPause && read -p "<-- Press any key to continue -->" NULL

echo -e $FormatTextSyntax "
   How to create a rescue system with verbose output:
"
echo -e $FormatTextCommands "
	# rear -v mkrescue
"
echo -e $FormatTextSyntax "
   To make ReaR create a rescue system at 22:00 every weekday,
	 add to the /etc/crontab file:

	0 22 * * 1-5 root /usr/sbin/rear mkrescue
"
echo -e $FormatTextPause && read -p "<-- Press any key to continue -->" NULL

echo -e $FormatTextSyntax '
   When using ReaR for backup:

	BACKUP=REQUESTRESTORE \t\t\t # default, prompts for restore
	BACKUP=NETFS \t\t\t\t # internal backup method
	BACKUP=[see list below] \t\t # support for external backup program
	BACKUP=EXTERNAL \t\t\t # specify commands if not listed below

	BACKUP_URL=file:///srv/backup/ \t\t # write to file
	BACKUP_URL=nfs://srv/share \t\t # mount and write to NFS
	BACKUP_URL=rsync://user@host:/path \t # use rsync
	BACKUP_URL=iso:///backup \t\t # include backup on ISO
	BACKUP_URL=usb:///dev/disk \t\t # write to USB device (i.e. external drive)
	BACKUP_URL=sshfs://user@host/path \t # use ssh

	NETFS_KEEP_OLD_BACKUP_COPY=y \t\t # internal only
	BACKUP_TYPE=incremental \t\t # internal only
	FULLBACKUPDAY="Day" \t\t\t # internal only = Mon,Tue,Wed,Thu,Fri,Sat,Sun

   Supported backup methods, see man page for full list:
	CommVault Galaxy 5 (GALAXY)	CommVault Galaxy 7 (GALAXY7)	CommVault Galaxy 10 (GALAXY10)
	Symantec NetBackup (NBU)	IBM Tivoli Storage Mgr (TSM)	EMC NetWorker/Legato (NSR)

   Full example conf file at: /usr/share/rear/conf/default.conf

'
echo -e $FormatTextPause && read -p "<-- Press any key to continue -->" NULL

echo -e $FormatTextCommands "
  Let's create a rescue ISO ...

	# rear -v mkrescue
"
$FormatRunCommand
rear -v mkrescue

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
