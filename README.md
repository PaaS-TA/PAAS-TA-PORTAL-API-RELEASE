## PAAS-TA-PORTAL-API-RELEASE (ctn-infra) 

### Notices  
  - "ctn-infra" branch (portal container infra)  
    Portal을 cloudfoundry container에 배포(cf push)하는 경우, Portal 서비스를 위해 필요한 infra로 구성되어 있다.  
    
  - Use PAAS-TA-PORTAL-API-RELEASE >= v.2.1.0-ctn    
    - PaaS-TA >= v.5.0.4    
    - portal-deployment >= v5.0.4  

### PaaS-TA Portal API (ctn-infra) Release Configuration   

  - binary_storage & mariadb : 1 machine  

### Create PaaS-TA Portal API (ctn-infra) Release   
  - Download the latest PaaS-TA Portal API Release   
    ```   
    $ git clone https://github.com/PaaS-TA/PAAS-TA-PORTAL-API-RELEASE.git   
    $ cd PAAS-TA-PORTAL-API-RELEASE   
    ```
  - Download & Copy "source files" into the src directory (source file은 master version과 동일)  
    ```   
    ## download source files      
    $ wget -O src.zip http://45.248.73.44/index.php/s/yRMt6LBTL5rZSMr/download   
         
    ## unzip download source files   
    $ unzip src.zip   

    ## final src directory   
    src   
      ├── haproxy  
      │   └── haproxy-1.6.5.tar.gz   
      ├── java   
      │   └── server-jre-8u121-linux-x64.tar.gz   
      ├── mariadb   
      │   └── mariadb-10.5.5-linux-x86_64.tar.gz   
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
      ├── python   
      │   └── Python-2.7.8.tgz   
      └── swift-all-in-one   
          └── swift-all-in-one-2.23.2.tar.gz   
    ```   
  - Create PaaS-TA Portal API Release   
    ```   
    ## <VERSION> :: release version (e.g. 2.1.0-ctn)   
    ## <RELEASE_TARBALL_PATH> :: release file path (e.g. /home/ubuntu/workspace/paasta-portal-api-release-<VERSION>.tgz)   
    $ bosh -e <bosh_name> create-release --name=paasta-portal-api-release --sha2 --version=<VERSION> --tarball=<RELEASE_TARBALL_PATH> --force   
    ```   
### Deployment
- https://github.com/PaaS-TA/portal-deployment   
