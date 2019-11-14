bosh delete-deployment -d paasta-portal-api

rm -rf dev_releases/

bosh delete-release paasta-portal-api-release/1.0
