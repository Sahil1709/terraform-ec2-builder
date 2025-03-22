sudo yum install docker -y
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.33.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
sudo usermod -aG docker ec2-user
sudo systemctl enable docker
sudo systemctl start docker
mkdir -p ~/.ssh || true
echo "${SSH_PUBLIC_KEY}" >> ~/.ssh/authorized_keys