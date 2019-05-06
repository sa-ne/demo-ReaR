## ReaR Demo WalkThru

### Requirements:
* Minimum VM: 1vCPU x 1G mem, running RHEL 7.latest
* At least 1GB free on root filesystem for ReaR rescue image and backup tar file

### WalkThru:
* Run rear-setup.sh
  * Will need root or sudo to install packages

* Run rear-demo.sh
  * Interactively walks thru a demo on cmdline

* Extra Credit #1 = Test rescue ISO:
   * Copy rescue ISO externally and boot VM on rescue ISO

* Extra Credit #2 = Test local backup method:
  * Required: external location for backup ISO (NFS, USB, rsync, etc.)
  * Using requirement above, create/edit /etc/rear/site.conf
  * This is an example using a NFS share from the local KVM host
  ```
  OUTPUT=ISO
  BACKUP=NETFS
  BACKUP_URL=nfs://gateway/export
  ```
  * Create a backup
  ```
  # rear -v mkbackup
  ```
  * Examine tarball to show what gets backed up

* Once complete, run rear-cleanup.sh
  * Optional if VM is disposable
