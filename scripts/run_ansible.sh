cd terraform-ec2-builder
git checkout multi-os-ec2
cd ansible

echo "Running Ansible..."
ansible-playbook -i aws_ec2.yml playbook.yml --limit "os_ubuntu:os_amazon"