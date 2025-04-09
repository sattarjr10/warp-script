#!/bin/bash

# Namayesh unvan
echo "Warp IP Scanner By @Champione"
echo "--------------------------------"

# Tabe baraye askan IPv4
scan_ipv4() {
    echo "Askan IPv4 dar hal anjam ast..."
    ip=$(curl -s https://api64.ipify.org)
    echo "IP payda shode: $ip"
    
    # Ping IP
    ping_result=$(ping -c 4 $ip)
    echo "Natije ping be IP $ip:"
    echo "$ping_result"
    
    # Barresi tamiz boodan IP
    response=$(curl -s https://ipinfo.io/$ip/json)
    asn=$(echo "$response" | jq -r '.org' | grep -i "cloudflare")
    if [[ -n "$asn" ]]; then
        echo "IP tamiz payda shod: $ip (IPv4)"
    else
        echo "IP $ip (IPv4) tamiz nist."
    fi
}

# Tabe baraye askan IPv6
scan_ipv6() {
    echo "Askan IPv6 dar hal anjam ast..."
    ip=$(curl -s https://api64.ipify.org?format=json | jq -r '.ip')
    echo "IP payda shode: $ip"
    
    # Ping IP
    ping_result=$(ping6 -c 4 $ip)
    echo "Natije ping be IP $ip:"
    echo "$ping_result"
    
    # Barresi tamiz boodan IP
    response=$(curl -s https://ipinfo.io/$ip/json)
    asn=$(echo "$response" | jq -r '.org' | grep -i "cloudflare")
    if [[ -n "$asn" ]]; then
        echo "IP tamiz payda shod: $ip (IPv6)"
    else
        echo "IP $ip (IPv6) tamiz nist."
    fi
}

# Menu-ye entekhab
while true; do
    echo "Lotfan yeki az gozine-ha ra entekhab konid:"
    echo "1. Scane IPv4"
    echo "2. Scane IPv6"
    echo "3. Khoroj"
    read -p "Entekhab shoma: " choice

    case $choice in
        1)
            scan_ipv4
            ;;
        2)
            scan_ipv6
            ;;
        3)
            echo "Khoroj az barname..."
            exit 0
            ;;
        *)
            echo "Lotfan yeki az gozine-ha-ye moshakhas vared konid."
            ;;
    esac
done
