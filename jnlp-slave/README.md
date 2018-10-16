# How to configure JNLP Slave for Jenkins job
## Create the base image for JNLP Slave
1. docker build -t "nexus-server-ip":5000/jnlp-slave-sudo .
2. docker push "nexus-server-ip":5000/jnlp-slave-sudo  
