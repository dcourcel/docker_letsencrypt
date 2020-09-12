# A basic Docker image to obtain and renew automatically a letsencrypt certificate
This image contains a cron job that will run certbot day 1rst, 11 and 21 of the month. If the certificate is due to renewal, it will be renewed. It is possible to specify only one certificate for the moment, but it can have multiple dns names associated. The certificates obtained are inside /etc/letsencrypt. You should mount a volume at that location to keep the certificates and the information certbot uses when renewing. You should also mount a volume at VALIDATION_PATH to share it with your server to be able to serve that location when http requests are made on .well-known/acme-challenge.

The optional parameter --single-run can be specified to execute immediately certbot and exit. It is usefull to obtain the certificate for the first time.

The following environment variables can be specified.
| Variable        | Description                                                                       | Default                                             | Mandatory |
| --------------- | --------------------------------------------------------------------------------- | --------------------------------------------------- | :-------: |
| VALIDATION_PATH | The folder where to put the file that letsencrypt will query on the server        | /media/letsencrypt_renew/.well-known/acme-challenge | √         |
| DRY_RUN         | Put anything in the variable to use --dry-run option of certbot. No real action will be taken . |                                       |           |
| OPTIONS_DOMAINS | The domains that will be in the certificate. Must be specified in the format --cert-name _domain\_name.com_ -d _other\_domain.com_,... | | √        |
| EMAIL           | One or more comma separated emails to gives with the option --email or certbot. If the value is -, then --register-unsafely-without-email will be passed to certbot. If the value is left empty, then none of these options is given to certbot. If it is the first time certbot is launched, it will ask for an email. | | |
| CERTBOT_AGREE   | Put anything in the variable to put the option --agree-tos to certbot. It means that you agree with the Terms of Service of LET'S ENCRYPT. | |      |

# Example of execution
> docker run -it --mount type=volume,src=_renew_path_,dst=/media/letsencrypt_renew --mount type=volume,src=_certificates_,dst=/etc/letsencrypt --env "OPTIONS_DOMAINS=--cert-name _myserver.com_ -d _myserver.com_,_drive.myserver.com_" letsencrypt --single-run
