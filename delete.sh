bosh delete-deployment -d portal-infra

rm -rf dev_releases/

bosh delete-release paasta-portal-api-release/2.0.1-min
