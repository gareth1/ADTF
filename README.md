This a deployment template for Windows Server 2016 in AWS with Ansible playbooks to deploy and configure to act as a domain controller(s)

Please note the following:-

1. All IP Address Ranges are AWS Defaults - confirm your IP ranges and edit if need be before deployment
2. Don't forget to add your PUBLICIP to the whitelist in the vars file or you will not be able to connect to the server via RDP after deployment
3. The DNS Role as been left blank as DNS is a fickle thing and lets face your DNS is most likely in AWS Route 53
4. NO WARRANTIES / GUARANTEES / NDEMNITIES IMPLIED OR GIVEN IF YOU USE THIS REPO YOU DO SO AT YOUR OWN RISK
