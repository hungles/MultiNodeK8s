#!/bin/bash

cd terraform/

terraform init
terraform apply -auto-approve
terraform output > ips.txt


# Inicializar diccionarios
declare -A masters
declare -A workers

content=$(cat ips.txt)

# Read the file line by line
while IFS= read -r line; do
    name=$(echo "$line" | cut -d '=' -f1 | xargs)
    value=$(echo "$line" | cut -d '=' -f2- | tr -d '"' | xargs)
    # Check if the line contains "master" or "worker"
    if [[ "$name" == *"master"* ]]; then
        if [[ "$name" == *"public_dns" ]]; then
            current_dns="$value"
        elif [[ "$name" == *"public_ip" ]]; then
            masters["$current_dns"]="$value"
        fi
    elif [[ "$name" == *"worker"* ]]; then
        if [[ "$name" == *"public_dns" ]]; then
            current_dns="$value"
        elif [[ "$name" == *"public_ip" ]]; then
            workers["$current_dns"]="$value"
        fi
    fi
done <<< "$content"

echo "load_balancer_dns: $(grep "lb =" ips.txt ips.txt | cut -d"=" -f 2 | xargs)" >> ../ansible/roles/master/vars/main.yml

cd ../ansible/

# Create inventory.ini file
echo "[k8-masters]" > inventory.ini
for dns in "${!masters[@]}"; do
    echo "$dns ansible_host=${masters[$dns]}" >> inventory.ini
done

echo "" >> inventory.ini
echo "[k8-workers]" >> inventory.ini
for dns in "${!workers[@]}"; do
    echo "$dns ansible_host=${workers[$dns]}" >> inventory.ini
done

rm -f ../terraform/ips.txt

#ansible-playbook -i inventory.ini playbooks/01-preconfig_kubernetes_servers.yml
#ansible-playbook -i inventory.ini playbooks/02-configure_nodes.yml