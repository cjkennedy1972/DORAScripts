## Pre-requisites
Before we begin setting up our CI/CD pipelines, we have to set up our Kubernetes cluster up and running.
1. Setup machine
    1. can be your local machine (must have Git client and Ansible v2.6.3)
    2. Generate an SSH key for Ansible
   
2. A set of servers that will run the K8S cluster
    1. the minimal number of servers necessary,2 masters and 1 node
    2. Must run Ubuntu 16.0.4
    3. configure the server with password less access to user root, Refer https://medium.com/luckspark/setup-passwordless-ssh-on-ubuntu-16-04-7ac81592fee6
    4. sudo apt install nfs-common
    5. sudo apt-get update
    6. sudo apt-get install socat
    7. IP addresses of these servers are mentioned in the inventory file below: 

Clone the GitHub repository from https://github.com/PureStorage-OpenConnect/DORAScripts.git
1. cd kube-ansible
2. Modify inventory file to point to correct IPs for master, nodes and etcd nodes and the ssh key for accessing the servers.
3. Please ensure that you password-less access enabled to all the servers/ nodes and the key is available on setup node.
4. Run ‘ansible-playbook -i inventory cluster.yml`
5. This will configure a HA Kubernetes cluster on the nodes mentioned in the inventory file.
6. Copy kubernetes config from (.kube/config) any master on your machine to access the cluster using kubectl.
