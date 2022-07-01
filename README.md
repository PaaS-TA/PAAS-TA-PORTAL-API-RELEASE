## PAAS-TA-PORTAL-API-RELEASE
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

### Portal 배포 방식에 따른 branch 분리
  - Bosh를 이용한 VM 배포
    - branch : "master" branch 사용  
    - version 표기 방식 : e.g.) v2.1.0, v2.2.0 ...  
    
  - CF CLI를 이용한 cloudfoundry container 배포
    - branch : "portal-container-infra" branch 사용 (Portal 운영에 필요한 infra환경 구성)
    - version 표기 방식 [version + "-ctn"] : e.g.) v2.2.0-ctn ...
    - PaaS-TA v5.0.4 부터 해당 배포 방식 추가 제공

### Notices  
  - Use PAAS-TA-PORTAL-API-RELEASE >= v.2.0.1
    - PaaS-TA >= v.5.0.2
    - portal-deployment >= v5.0.2
  - Use PAAS-TA-PORTAL-API-RELEASE =< v.2.0.0
    - PaaS-TA =< v.5.0.1
    - portal-deployment =< v5.0.1
  - Use PAAS-TA-PORTAL-API-RELEASE >= v.2.2.0-ctn
    - PaaS-TA >= v.5.0.4
    - portal-deployment >= v5.0.4
  
### PaaS-TA Portal API Release Configuration   
  - Bosh를 이용한 VM 배포
    - binary_storage : 1 machine
    - haproxy : 1 machine
    - mariadb : 1 machine
    - paas-ta-portal-registration : 1 machine
    - paas-ta-portal-gateway : 1 machine
    - paas-ta-portal-api : 1 machine
    - paas-ta-portal-common-api : 1 machine
    - paas-ta-portal-log-api : 1 machine
    - paas-ta-portal-storage-api : 1 machine
    
  - CF CLI를 이용한 cloudfoundry container 배포
    - binary_storage & mariadb : 1 machine  

### Create PaaS-TA Portal API Release   
  - Download the latest PaaS-TA Portal API Release     
    ```   
    ### Bosh를 이용한 VM 배포 
    $ git clone https://github.com/PaaS-TA/PAAS-TA-PORTAL-API-RELEASE.git   
    $ cd PAAS-TA-PORTAL-API-RELEASE
    
    ### CF CLI를 이용한 cloudfoundry container 배포
    $ git clone -b portal-container-infra https://github.com/PaaS-TA/PAAS-TA-PORTAL-API-RELEASE.git
    $ cd PAAS-TA-PORTAL-API-RELEASE
    ```  
    
  - Download & Copy "source files" into the src directory  
    ```   
    ## download source files      
    $ wget -O src.zip https://nextcloud.paas-ta.org/index.php/s/GmD3sK9T3fHiFb5/download
         
    ## unzip download source files   
    $ unzip src.zip
      
    ## final src directory   
    src 
      ├── haproxy
      │   └── haproxy-1.6.5.tar.gz
      ├── java
      │   └── server-jre-8u121-linux-x64.tar.gz
      ├── mariadb
      │   └── mariadb-10.5.16-linux-x86_64.tar.gz
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
      │   └── Python-3.6.9.tgz
      └── swift-all-in-one
          └── README.txt ( dependencies : apache2 2.4.49 >  2.4.53 )
          └── swift-2.23.2.tar.gz
          └── swift-2.23.2-bionic-dependencies.tar.gz
          
     ----------------------------------------------------------------------------------------------------
     ### CF CLI를 이용한 cloudfoundry container 배포시, 사용하지 않는 source files을 지우고 release를 생성할 수 있다.(Option)
     $ rm -rf src/paas-ta-portal-* src/haproxy src/java
     
     ### final src directory 
     src
       ├── mariadb
       │   └── mariadb-10.5.16-linux-x86_64.tar.gz
       ├── python
       │   └── Python-3.6.9.tgz
       └── swift-all-in-one
           └── swift-2.23.2.tar.gz
           └── swift-2.23.2-bionic-dependencies.tar.gz
     ---------------------------------------------------------------------------------------------------- 
    ```   
  - Create PaaS-TA Portal API Release    
    ```   
    ## <VERSION> :: release version (e.g. 2.5.1 or 2.5.1-ctn)   
    ## <RELEASE_TARBALL_PATH> :: release file path (e.g. /home/ubuntu/workspace/paasta-portal-api-release-<VERSION>.tgz)   
    $ bosh -e <bosh_name> create-release --name=paasta-portal-api-release --sha2 --version=<VERSION> --tarball=<RELEASE_TARBALL_PATH> --force   
    ```   
### Deployment
- https://github.com/PaaS-TA/portal-deployment   

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/jinhyojin"><img src="https://avatars.githubusercontent.com/u/76993633?v=4?s=100" width="100px;" alt=""/><br /><sub><b>jinhyojin</b></sub></a><br /><a href="https://github.com/PaaS-TA/PAAS-TA-PORTAL-API-RELEASE/issues?q=author%3Ajinhyojin" title="Bug reports">🐛</a> <a href="https://github.com/PaaS-TA/PAAS-TA-PORTAL-API-RELEASE/commits?author=jinhyojin" title="Tests">⚠️</a> <a href="https://github.com/PaaS-TA/PAAS-TA-PORTAL-API-RELEASE/commits?author=jinhyojin" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/okpc579"><img src="https://avatars.githubusercontent.com/u/55691511?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Ruby</b></sub></a><br /><a href="#infra-okpc579" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/PaaS-TA/PAAS-TA-PORTAL-API-RELEASE/commits?author=okpc579" title="Tests">⚠️</a> <a href="https://github.com/PaaS-TA/PAAS-TA-PORTAL-API-RELEASE/commits?author=okpc579" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
