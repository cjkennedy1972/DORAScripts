# HA-Proxy-Deploy Jenkins Job
HAProxy is free, open source software which works as a proxy server for TCP and HTTP-based applications that spreads requests across multiple servers

- we are using HA-Proxy for Blue-Green deployment, such that we have setup a VM on Vsphere which will act as a front-end load balancer for the wordpress VMs launched through the CD job.
- This Job is triggerred as an downstream job of Wordpress-CD job, i.e triggrred after the successful execution of CD Job
- With this job we simply replace the Backend VM IPs with the new VM IPs which are launched through the CD job.

## Parameters for tis Job
1. This job will take the Wordpress-CD job number as paramter.

## Prerequisites
Following are the Prerequisites for this job
1. A running VM having HA-Proxy installation, we have the VM setup scripts inside the `vm-cluster/haproxy` directory, 
2. The IP address of the HA-Proxy VM to be set in `environment.sh` as the value for parameter `HA_PROXY_VM_IP`
