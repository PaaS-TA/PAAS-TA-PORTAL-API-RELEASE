bosh create-release --sha2 --force --tarball ./paasta-portal-api-release-2.0.1-min.tgz --name paasta-portal-api-release --version 2.0.1-min


bosh upload-release ./paasta-portal-api-release-2.0.1-min.tgz
