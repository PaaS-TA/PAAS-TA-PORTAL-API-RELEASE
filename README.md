## PAAS-TA-PORTAL-API-RELEASE     

### Notices     
  - Use PAAS-TA-PORTAL-API-RELEASE >= v.2.0.1-min
    - PaaS-TA >= v.5.0.2-min    
    - portal-deployment >= v5.0.2-min    
  - Use PAAS-TA-PORTAL-API-RELEASE =< v.2.0.0-min    
    - PaaS-TA =< v.5.0.1-min   
    - portal-deployment =< v5.0.1-min    

### PaaS-TA Portal API Release Configuration   

  - portal-infra : 1 machine

### Create PaaS-TA Portal API Release   
  - Download the latest PaaS-TA Portal API Release   
    ```   
    $ git clone -b paas-ta-portal-api-release-min --single-branch https://github.com/PaaS-TA/PAAS-TA-PORTAL-API-RELEASE.git   
    $ cd PAAS-TA-PORTAL-API-RELEASE   
    ```
  - Download & Copy "source files" into the src directory   
    ```   
    ## download source files      
    $ wget -O src.zip http://45.248.73.44/index.php/s/GkTHaTFz6a8KFaX/download   
         
    ## unzip download source files   
    $ unzip src.zip   

    ## final src directory   
    src   
      ├── haproxy   
      │   └── haproxy-1.6.5.tar.gz   
      ├── java   
      │   └── server-jre-8u121-linux-x64.tar.gz   
      ├── mariadb   
      │   └── mariadb-10.1.22-linux-x86_64.tar.gz   
      ├── paas-ta-portal-api   
      │   └── paas-ta-portal-api.jar   
      ├── paas-ta-portal-common-api   
      │   └── paas-ta-portal-common-api.jar   
      ├── paas-ta-portal-gateway   
      │   └── paas-ta-portal-gateway.jar   
      ├── paas-ta-portal-infra-admin   
      │   └── paas-ta-portal-infra-admin.jar   
      ├── paas-ta-portal-log-api   
      │   └── paas-ta-portal-log-api.jar   
      ├── paas-ta-portal-registration   
      │   └── paas-ta-portal-registration.jar   
      ├── paas-ta-portal-storage-api   
      │   └── paas-ta-portal-storage-api.jar   
      ├── paas-ta-portal-webadmin   
      │   └── paas-ta-portal-webadmin.war   
      ├── paas-ta-portal-webuser   
      │   └── paas-ta-portal-webuser.tar.gz   
      ├── python   
      │   └── Python-2.7.8.tgz   
      └── swift-all-in-one   
          └── swift-all-in-one.tar.gz   
    ```   
  - Create PaaS-TA Portal API Release   
    ```   
    ## <VERSION> :: release version (e.g. 2.0.1-min)   
    ## <RELEASE_TARBALL_PATH> :: release file path (e.g. /home/ubuntu/workspace/paasta-portal-api-release-<VERSION>.tgz)   
    $ bosh -e <bosh_name> create-release --name=paasta-portal-api-release --sha2 --version=<VERSION> --tarball=<RELEASE_TARBALL_PATH> --force   
    ```   
### Deployment
- https://github.com/PaaS-TA/portal-deployment   
