!#/bin/bash
# This script is for creating ftp site.

NEW_FILESTORE_NAME=samplefiles
NEW_USER=hello_world
NEW_PASS="This is not a password"

set -e

echo "######################################################################"
echo Started setting up for $NEW_FILESTORE_NAME ...

echo "######################################################################"
NEW_FILESTORE_DIR=/var/www/$NEW_FILESTORE_NAME
echo Creating www folder ${NEW_FILESTORE_DIR} ...
sudo mkdir -p ${NEW_FILESTORE_DIR}/files
sudo chmod 777 ${NEW_FILESTORE_DIR}/files

echo "######################################################################"
NEW_PASS_FILE=${NEW_FILESTORE_DIR}/htdigest
echo Creating htdigest password ${NEW_PASS_FILE} ...
sudo htdigest -c ${NEW_PASS_FILE} RestrictedZone ${NEW_USER}

echo "######################################################################"
NEW_APACHE_CONFIG_FILE=${NEW_FILESTORE_NAME}.conf
echo Creating apache config ${NEW_APACHE_CONFIG_FILE} ...

cd /etc/apache2/sites-available

sudo cat > ${NEW_APACHE_CONFIG_FILE} << EOF
<VirtualHost *:80>
    Redirect permanent / https://${NEW_FILESTORE_NAME}.mydomain.com/
</VirtualHost>
<VirtualHost *:443>
    ServerName ${NEW_FILESTORE_NAME}.mydomain.com
    ServerAlias *.mydomain.com
    DocumentRoot /var/www/${NEW_FILESTORE_NAME}/files
    SSLEngine On
    SSLProtocol all
    SSLCertificateFile /etc/certificates/mydomain.com/mydomain.crt
    SSLCertificateKeyFile /etc/certificates/mydomain.com/mydomain.key
    SSLCertificateChainFile /etc/certificates/mydomain.com/intermediate.crt
    <Location / >
        AuthType Digest
        AuthName "RestrictedZone"
        AuthDigestDomain /
        AuthDigestProvider file
        AuthUserFile ${NEW_PASS_FILE}
        Require valid-user
    </Location>
</VirtualHost>
EOF

echo Creating symbolic link in sites-enabled to sites-available/$NEW_APACHE_CONFIG_FILE ...
cd /etc/apache2/sites-enabled
sudo ln -s /etc/apache2/sites-available/${NEW_APACHE_CONFIG_FILE} .

echo "######################################################################"
echo Restarting apache ...

sudo service apache2 restart

echo "######################################################################"
echo DONE
echo "######################################################################"
