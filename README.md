# PAAS-TA-PORTAL-API-RELASE
bosh 2.0 PAAS-TA-PORTAL-API-RELASE 


stemcell ubuntu-xenial 만 지원됨

src
---

src 폴더에 각 package의 설치파일이 위치해야 한다.

src <br>
├── haproxy <br>
│     └── haproxy-1.6.5.tar.gz <br>
├── java <br>
│     └── server-jre-8u121-linux-x64.tar.gz <br>
├── mariadb <br>
│     └── mariadb-10.1.22-linux-x86_64.tar.gz <br>
├── paas-ta-portal-api <br>
│     └── paas-ta-portal-api.jar <br>
├── paas-ta-portal-common-api <br>
│     └── paas-ta-portal-common-api.jar <br>
├── paas-ta-portal-gateway <br>
│     └── paas-ta-portal-gateway.jar <br>
├── paas-ta-portal-log-api <br>
│     └── paas-ta-portal-log-api.jar <br>
├── paas-ta-portal-registration <br>
│     └── paas-ta-portal-registration.jar <br>
├── paas-ta-portal-storage-api <br>
│     └── paas-ta-portal-storage-api.jar <br>
├── python <br>
│     └── Python-2.7.8.tgz <br>
├── swift-all-in-one <br>
│     └── deb-files <br>
│     └── swift <br>
│     └── whl-files <br>
└── README.md <br>


***PaaS-TA 5.0 공개시 사용 가능***

```
$ cd ~/
$ git clone https://github.com/PaaS-TA/PAAS-TA-PORTAL-API-RELEASE.git
$ cd ~/PAAS-TA-PORTAL-API-RELEASE
$ wget -O src.zip http://45.248.73.44/index.php/s/Ww94aojKCADdb3N/download
$ unzip src.zip
```
