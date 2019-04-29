# Tasks
- [x] Enter information for MetalLB and Nginx-Ingress setup
- [x] Provide details of how to setup `environment.sh` for Install Phase
- [x] Provide details of setting up GitLab and Jenkins Tokens for Configure Phase
- [ ] Provide details if it is required utilize local storage (Kontena Storage which internally uses Rook + Ceph) for the CI job


# Setup
We are using a combination of MetalLB and Nginx-Ingress to expose the services created for the GitLab, Jenkins and Nexus applications.

To set up these, it is required to set up the [environment.sh] file.

## MetalLB setup
MetalLB needs an available IP range/CIDR block which it can consume and allocate IPs to load balance services in Kubernetes. Before we start the installation, we need to set the IP range in environment.sh file for variable ` METAL_LB_IP_CIDR`. For example
```shell
## CIDR Block for the IPs available for LoadBalancer use
METAL_LB_IP_CIDR="10.21.236.91/32" # or "10.21.236.91-10.21.236.95"
```

## Nginx-Ingress setup
To expose the services, our strategy is as follows
* Expose Nginx-Ingress using one of the IPs supplied by MetalLB
* Perform host-based routing to appropriate K8S services for
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
Once the environment variables are properly configured in `environment.sh`, you can run 

```shell
bash install.sh <CUSTOM_NAMESPACE> #Defaults to "pure" if CUSTOM_NAMESPACE isn't set
```
To find the IP allocated to Nginx-Ingress service, run following and check the allocated IP under EXTERNAL-IP
```bash
 $ kubectl get svc ingress-nginx -n ingress-nginx
 NAME            TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)                      AGE
ingress-nginx   LoadBalancer   10.102.138.56   10.21.236.97   80:32558/TCP,443:32111/TCP   10m
 ```

 If the test environment doesn't have a DNS server running where all hostname/IP mapping for the FQDNs defined above can be applied, it is required to add entries in `/etc/hosts` file

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
bash configure.sh <CUSTOM_NAMESPACE> #Must match the CUSTOM_NAMESPACE used with install.sh. Defaults to "pure" if CUSTOM_NAMESPACE isn't set
```

# Setting up `environment.sh`
Navigate to the k8s-cluster folder and open the environment.sh file

Customize the following free values and make sure you specify a valid, accessible IP address and the FQDN of your Kubernetes cluster nodes:

```
- NEXUS_IP
- NEXUS_FQDN
- JENKINS_IP
- JENKINS_FQDN
- GITLAB_IP
- GITLAB_DOMAIN
- HA_PROXY_VM_IP
- METAL_LB_IP_CIDR 
```
Note: it is possible to deploy the solution on a single-node cluster, since the default ports are distinct (see below)
(Optional) Modify the default port values (NEXUS_PORT, JENKINS_PORT and GITLAB_PORT). 

It is recommended to leave the default values but if the ports are already taken, you might want to modify them.
(Optional) Modify the resource requirements for GitLab and Jenkins by editing the following files:
helm/gitlab/gitlab-ce.yaml - Look for resources/requests resources/limits, postgresql/cpu,  postgresql/memory and redis/resources/requests/memory and modify or comment them if you want to allocate fewer resources assigned to GitLab

helm/jenkins/jenkins.yaml - Look for Master/Cpu and Master/Memory values and modify or comment them if you want to allocate less resources to Jenkins.


# Setting up GitLab and Jenkins Tokens 
1. GitLab:\
  Add a entry in your `/etc/hosts/` file on your machine with the GITLAB_DOMAIN(entered in environment.sh) and the ingress IP.You can get the host enry details through the command `kubectl get ing -n <NAME_SPACE>|grep <GITLAB_DOMAIN>`\
  Follow the steps to configure the gitlab token: 
    - Open Gilab in a web browser `http://GITLAB_DOMAIN`
    - Sign in with the administrator credentials: `root/admin123`
    - Select the user icon in the top right corner of the page and select Settings
    - From the User Settings page, select Access Tokens in the left, vertical navigation bar
    - In the Personal Access Tokens section, give your token a name (such as ImportProjects), select the `api` scope and press the *Create personal access token* button
    - Copy your new Personal Access Token value to the `k8s-cluster/environment.sh` file in the `GITLAB_TOKEN` variable.
    
2. Jenkins:\
  Add an entry in your `/etc/hosts/` file on your machine with the JENKINS_FQDN (entered in environment.sh) and the ingress IP. You can get the host enry details through the command `kubectl get ing -n <NAME_SPACE>|grep <JENKINS_FQDN>`\
  Follow the steps to configure the Jenkins token: 
    - Open Jenkins in a web browser `http;//JENKINS_FQDN`
    - Sign with the following credentials : `admin/admin123`
    - Select the arrow next to the admin link in the top right corner of the page and select Configure
    - In the API Token section, press the Add New Token button and give your token a name.
    - Copy your API Token value to the `k8s-cluster/environment.sh` file in the `JENKINS_TOKEN` variable
