# demo-ReaR

Quick demo of Relax-and-Recover (ReaR) capabilities

Relax-and-Recover (ReaR), a disaster recovery and system migration utility.  ReaR complements backup software by creating a rescue system. Booting the rescue system on a new hardware allows you to issue the rear recover command, which starts the recovery process.

During this process, ReaR replicates the partition layout and filesystems, prompts for restoring user and system files from the backup created by backup software, and finally installs the boot loader.

Install the rear package and its dependencies by running the following command as root:
```
	# yum install rear genisoimage syslinux
```

ReaR is configured in the /etc/rear/local.conf file.
```
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
FULLBACKUPDAY="Day"			# internal only = Mon,Tue,Wed,Thu,Fri,Sat,Sun
```
Supported backup methods:  CommVault Galaxy 5 (GALAXY), CommVault Galaxy 7 (GALAXY7), CommVault Galaxy 10 (GALAXY10), Symantec NetBackup (NBU), IBM Tivoli Storage Manager (TSM), EMC NetWorker/Legato (NSR),

Full example conf file at: /usr/share/rear/conf/default.conf

How to create a rescue system with verbose output:
```
	# rear -v mkrescue
```
To make ReaR create a rescue system at 22:00 every weekday, add to the /etc/crontab file:
>	0 22 * * 1-5 root /usr/sbin/rear mkrescue

To perform a restore or migration:
* Boot the rescue system on the new hardware.
* In the console interface, select the "Recover" option
* At the rescue prompt, run the rear recover command to perform the restore or migration. The rescue system then recreates the partition layout and filesystems
* Restore user and system files from the backup into the /mnt/local/ directory (i.e. from a tarball)
* Ensure that SELinux relabels the files on the next boot: ```# touch /mnt/local/.autorelabel```
* Reboot

ReaR includes a built-in, or internal, backup method. This method is fully integrated with ReaR
To create a rescue system only, run:
```
#  rear mkrescue
```
To create a backup only, run:
```
# rear mkbackuponly
```
To create a rescue system and a backup, run:
```
# rear mkbackup
```
To create a rescue system, but only if the layout has changed, use this command:
```
# rear checklayout || rear mkrescue
```

[Red Hat Documentation](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-relax-and-recover_rear)

[Upstream ReaR Documentation](http://relax-and-recover.org/documentation/)

[Upstream ReaR FAQs](http://relax-and-recover.org/documentation/faq)

