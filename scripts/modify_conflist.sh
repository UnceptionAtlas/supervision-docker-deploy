#!/bin/bash

# Function to modify conflist
modify_conflist(){
    correct_config='{
        "cniVersion": "0.4.0",
        "name": "elastic",
        "plugins": [
           {
              "type": "bridge",
              "bridge": "cni-podman1",
              "isGateway": true,
              "ipMasq": true,
              "hairpinMode": true,
              "ipam": {
                 "type": "host-local",
                 "routes": [
                    {
                       "dst": "0.0.0.0/0"
                    }
                 ],
                 "ranges": [
                    [
                       {
                          "subnet": "10.89.0.0/24",
                          "gateway": "10.89.0.1"
                       }
                    ]
                 ]
              }
           },
           {
              "type": "portmap",
              "capabilities": {
                 "portMappings": true
              }
           },
           {
              "type": "firewall",
              "backend": ""
           },
           {
              "type": "tuning"
           },
           {
              "type": "dnsname",
              "domainName": "dns.podman",
              "capabilities": {
                 "aliases": true
              }
           }
        ]
    }'

    # Write the correct configuration to elastic.conflist
    echo "$correct_config" > ~/.config/cni/net.d/elastic.conflist
}

