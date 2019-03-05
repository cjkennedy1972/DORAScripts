# Tasks
- [x] Enter information for MetalLB and Nginx-Ingress setup
- [ ] Provide details of how to setup environment.sh for Install Phase
- [ ] Provide details of setting up Gitlab and Jenkins Tokens for Configure Phase
- [ ] Provide details if we want to utilize local storage (Kontena Storage which internally uses Rook + Ceph) for the CI job


# Setup
We are using a combination of MetalLB and Nginx-Ingress to expose the services created for Gitlab, Jenkins and Nexus applications.

To set up these, we first need to setup [environment.sh] file

## MetalLB setup
MetalLB needs an available IP range/ CIDR block which it can consume and allocate IPs to load balancer services in Kubernetes. Before we start the installation, we need set the IP range in environment.sh file for variable ` METAL_LB_IP_CIDR`. For example
```shell
## CIDR Block for the IPs available for LoadBalancer use
METAL_LB_IP_CIDR="10.21.236.91/32" # or "10.21.236.91-10.21.236.95"
```

## Nginx-Ingress setup
To expose the services, our strategy is as follows
* Expose Nginx-Ingress using one of the IPs supplied by MetalLB
* Do host based routing to appropriate K8S service for
  * Jenkins
  * Nexus (and Docker registry)
  * Gitlab

As we plan to use host-based routing, we need to set up Fully qualified domain names (FQDN) for all services namely Jenkins, Nexus, Docker registry and Gitlab.

Please also ensure that all the FQDNs will resolve to the IP allocated to Nginx-Ingress service in the cluster.

We need to setup following environment variables in environment.sh

```bash
#Set Fully Qualified Domain Names of the Sonatype Nexus, Jenkins and GitLab services in Kubernetes
NEXUS_FQDN="nexus.puretec.purestorage.com"
JENKINS_FQDN="jenkins.puretec.purestorage.com"
GITLAB_FQDN="git.puretec.purestorage.com"
DOCKER_FQDN="git.puretec.purestorage.com"
```

# Installation
Once environment variables are properly configured in environment.sh, you can run 

```shell
bash install.sh
```
# Configuration
After installation steps are completed, we need to setup few more variables in environment.sh file

Once all the above setup is done, simply run

```shell
bash configure.sh
```

