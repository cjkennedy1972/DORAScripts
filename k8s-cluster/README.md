# Tasks
- [x] Enter information for MetalLB and Nginx-Ingress setup
- [ ] Provide details of how to setup `environment.sh` for Install Phase
- [ ] Provide details of setting up GitLab and Jenkins Tokens for Configure Phase


# Setup
We are using a combination of MetalLB and Nginx-Ingress to expose the services created for GitLab, Jenkins and Nexus applications.

To set up these, it is required to set up the [environment.sh] file.

## MetalLB setup
MetalLB needs an available IP range/ CIDR block which it can consume and allocate IPs to load balancer services in Kubernetes. Before we start the installation, we need to set the IP range in environment.sh file for variable ` METAL_LB_IP_CIDR`. For example
```shell
## CIDR Block for the IPs available for LoadBalancer use
METAL_LB_IP_CIDR="10.21.236.91/32" # or "10.21.236.91-10.21.236.95"
```

## Nginx-Ingress setup
To expose the services, our strategy is as follows
* Expose Nginx-Ingress using one of the IPs supplied by MetalLB
* Perform host-based routing to appropriate K8S service for
  * Jenkins
  * Nexus (includes Docker registry)
  * GitLab

As we are using host-based routing, it is required to set up Fully Qualified Domain Names (FQDN) for all services namely Jenkins, Nexus, Docker registry and GitLab.

Please also ensure that all the FQDNs will resolve to the IP allocated to Nginx-Ingress service in the cluster.

It is required to set up following environment variables in `environment.sh`, which you should customize according to your own environment.

```bash
#Set Fully Qualified Domain Names of the Sonatype Nexus, Jenkins, Docker and GitLab services in Kubernetes
NEXUS_FQDN="nexus.puretec.purestorage.com"
JENKINS_FQDN="jenkins.puretec.purestorage.com"
GITLAB_FQDN="git.puretec.purestorage.com"
DOCKER_FQDN="docker.puretec.purestorage.com"
```

# Installation
Once environment variables are properly configured in `environment.sh`, you can run 

```shell
bash install.sh
```
To find the IP allocated to Nginx-Ingress service, run following and check the allocated IP under EXTERNAL-IP
```bash
 $ kubectl get svc ingress-nginx -n ingress-nginx
 NAME            TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)                      AGE
ingress-nginx   LoadBalancer   10.102.138.56   10.21.236.97   80:32558/TCP,443:32111/TCP   10m
 ```

 If the test environment doesn't have a DNS server running where all hostname/ IP mapping for the FQDNs defined above can be applied, it is required to add entries in `/etc/hosts` file

 ```bash
 ## Paste following in /etc/hosts file
# <EXTERNAL-IP> nexus.puretec.purestorage.com
# <EXTERNAL-IP> jenkins.puretec.purestorage.com
# <EXTERNAL-IP> git.puretec.purestorage.com
# <EXTERNAL-IP> docker.puretec.purestorage.com
10.21.236.97 nexus.puretec.purestorage.com
10.21.236.97 jenkins.puretec.purestorage.com
10.21.236.97 git.puretec.purestorage.com
10.21.236.97 docker.puretec.purestorage.com
 ```

# Configuration
After installation steps are completed, it is required to set up a few more variables in the `environment.sh` file related to GitLab token and Jenkins token.

Once the above setup is done, simply run

```shell
bash configure.sh
```

