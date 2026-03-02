- #To check secure connection between zookeeper nodes
- #zookeeper-0 can act as a TLS client to zookeeper-1/zookeeper-2 using its own node certificate, as long as zookeeper-1 and zookeeper-2 trusts the CA
- #Convert .p12 Files to PEM (inside your Zookeeper pod)

- openssl pkcs12 -in /security/keystore.p12 -nocerts -nodes -out /security/client.key -password pass:changeme
- openssl pkcs12 -in /security/keystore.p12 -clcerts -nokeys -out /security/client.crt -password pass:changeme
- openssl pkcs12 -in /security/truststore.p12 -cacerts -nokeys -out /security/ca.pem -password pass:changeme

- #How the Zookeeper Quorum TLS handshake works:
- - When zookeeper-0 connects to zookeeper-1 (port 2888):
- - zookeeper-1 sends its server certificate (CN=zookeeper-1…)
- - zookeeper-0 verifies it using its truststore.p12
- - zookeeper-0 sends its client certificate (CN=zookeeper-0…)
- - zookeeper-1 verifies it using its truststore.p12
- - They establish encrypted channel → quorum communication continues So each node uses its own cert as a client when talking to others.

- #Now you have:
- - /security/client.key
- - /security/client.crt
- - /security/ca.pem


- openssl s_client -connect zookeeper-1.zookeeper.testing-kafka.svc.cluster.local:3888 -cert /security/client.crt -key /security/client.key -CAfile security/ca.pem -tls1_3
- openssl s_client -connect zookeeper-2.zookeeper.testing-kafka.svc.cluster.local:3888 -cert /security/client.crt -key /security/client.key -CAfile security/ca.pem -tls1_3
- openssl s_client -connect zookeeper-1.zookeeper.testing-kafka.svc.cluster.local:12181 -cert /security/client.crt -key /security/client.key -CAfile security/ca.pem -tls1_3
- openssl s_client -connect zookeeper-2.zookeeper.testing-kafka.svc.cluster.local:12181 -cert /security/client.crt -key /security/client.key -CAfile security/ca.pem -tls1_3

- #you can also Confirm Traffic Is Encrypted (tcpdump), but tcpdump doesnot exist on zookeeper default image
- tcpdump -i any port 2888 -A
- tcpdump -i any port 3888 -A

- zkCli.sh -server zookeeper-2.zookeeper.testing-kafka.svc.cluster.local:2181
- create /demo_only some_value
- get /demo_only

- available commands
        ```sh
        addWatch [-m mode] path # optional mode is one of [PERSISTENT, PERSISTENT_RECURSIVE] - default is PERSISTENT_RECURSIVE
        addauth scheme auth
        close
        config [-c] [-w] [-s]
        connect host:port
        create [-s] [-e] [-c] [-t ttl] path [data] [acl]
        delete [-v version] path
        deleteall path [-b batch size]
        delquota [-n|-b|-N|-B] path
        get [-s] [-w] [-b] [-x] path
        getAcl [-s] path
        getAllChildrenNumber path
        getEphemerals path
        history
        listquota path
        ls [-s] [-w] [-R] path
        printwatches on|off
        quit
        reconfig [-s] [-v version] [[-file path] | [-members serverID=host:port1:port2;port3[,...]*]] | [-add serverId=host:port1:port2;port3[,...]]* [-remove serverId[,...]*]
        redo cmdno
        removewatches path [-c|-d|-a] [-l]
        set path data [-s] [-v version] [-b]
        setAcl [-s] [-v version] [-R] path acl
        setquota -n|-b|-N|-B val path
        stat [-w] path
        sync path
        version
        whoami
        ```