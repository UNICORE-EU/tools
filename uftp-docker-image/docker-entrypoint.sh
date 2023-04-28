#!/bin/bash

_users_setup() {
    /usr/sbin/useradd -c "Demouser" -g users \
      -s /bin/bash -r -b /home demouser 2>/dev/null
    mkdir -p /home/demouser
    chown demouser:users /home/demouser
}

_unicore_setup() {
    /usr/sbin/groupadd -r unicore 2>/dev/null    
    /usr/sbin/useradd -c "UNICORE" -g unicore \
      -s /bin/false -r -d /tmp unicore 2>/dev/null

    mkdir -p /opt/unicore
    chown unicore:unicore /opt/unicore
    cd /opt/unicore
    mv /tmp/unicore-authserver.tgz /tmp/unicore-uftpd.tgz /opt/unicore
    chown unicore:unicore /opt/unicore/*.tgz
    sudo -u unicore tar xzf unicore-uftpd.tgz
    sudo -u unicore tar xzf unicore-authserver.tgz
    rm -f unicore-*.tgz
    sudo -u unicore mv unicore-authserver-* unicore-authserver
    sudo -u unicore mv unicore-uftpd-* unicore-uftpd

    # configure user mapping so jobs run as "demouser"
    sudo -u unicore cat > /opt/unicore/unicore-authserver/conf/simpleuudb <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!--
 User mapping / attributes file
-->
<fileAttributeSource>
   <entry key="CN=Demo User, O=UNICORE, C=EU">
      <attribute name="role">
         <value>user</value>
      </attribute>
      <attribute name="xlogin">
         <value>demouser</value>
      </attribute>
   </entry>
</fileAttributeSource>
EOF

    # setup UFTPD - no SSL, configure ports
    sudo -u unicore cat > /opt/unicore/unicore-uftpd/conf/uftpd.conf <<EOF
#!/bin/bash
# autogenerated - Config file for the UFTPD server

export SETPRIV="/usr/bin/setpriv_no"

export LOG_VERBOSE=false
export LOG_SYSLOG=true

export UFTPD_LIB=lib
export UFTPD_PID=uftpd.pid

export SERVER_HOST=0.0.0.0
export SERVER_PORT=64434
export CMD_HOST=localhost
export CMD_PORT=64435

#export SSL_CONF=conf/uftpd-ssl.conf
export ACL=conf/uftpd.acl

export MAX_CONNECTIONS=256
export MAX_STREAMS=2
export PORT_RANGE=50000:50010
export DISABLE_IP_CHECK="yes"

export UFTP_KEYFILES=.ssh/authorized_keys:.uftp/authorized_keys
export UFTP_NO_WRITE=.ssh/authorized_keys

EOF

    # switch off SSL in authserver conf
    sed -i "s/TEST.ssl=true/TEST.ssl=false/" /opt/unicore/unicore-authserver/conf/container.properties
    # listen on all interfaces
    sed -i "s/localhost:9000/0.0.0.0:9000/"  /opt/unicore/unicore-authserver/conf/container.properties
    sed -i "s/host=localhost/host=0.0.0.0/"  /opt/unicore/unicore-authserver/conf/container.properties

    sudo /opt/unicore/unicore-uftpd/bin/unicore-uftpd-start.sh
    sudo -u unicore /opt/unicore/unicore-authserver/bin/unicore-authserver-start.sh

}

_main() {
    echo "Creating user(s)..."
    _users_setup
    _unicore_setup

    if [[ -t 0 && -t 1 ]] ; then
	echo "Running interactive shell"
	if [[ "${1:0:1}" = "-" ]]; then
            echo "Please pass a program name to the container!"
            exit 1
	else
            exec "$@"
	fi
    else
	echo "Running detached"
	# just keep the services running
	tail -f /opt/unicore/unicore-authserver/logs/authserver-startup.log
    fi
}

_main "$@"

