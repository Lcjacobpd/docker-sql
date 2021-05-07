# SQL-Docker Cheatsheet

This is intended as a quick refernce and showcase of establishing an
SQL database within a docker image. For more complete info see the
Microsoft Docks on using
[SQL container images with Docker](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-bash "Quickstart: Run SQL Server container images with Docker").

Note also that this cheatsheet assumes a Fedora OS and a bash environment.
Instructions for alternative distributions can be found in the aformentioned
complete documentation.
<br/>

## 1 Prerequisites

### 1.a Install Docker Engine 1.8+ (Fedora)
```Shell
# Remove old versions.
$ sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

# Setup and install via the repository.
$ sudo dnf -y install dnf-plugins-core

$ sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Install docker engine.
$ sudo dnf -y install docker-ce-3:20.10.6 docker-ce-cli-1:20.10.6 containerd.io
```

Testing the installation:
```Shell
# Start docker and run example.
$ sudo systemctl start docker
$ sudo docker run hello-world
```

### 1.b Configure Docker overlay2 driver
```Shell
# Ensure docker is not running and copy to temp.
$ sudo systemctl stop docker
$ cp -au /var/lib/docker /var/lib/docker.bk

# Edit/create /etc/docker/daemon.json
$ cat > /etc/docker/daemon.json
{
  "storage-driver": "overlay2"
}
```

Testing the configuration:
```Shell
# Start docker and check details.
$ sudo systemctl start docker
$ sudo docker info

# Ensure that "Storage Driver: overlay2".
# Close docker when complete.
$ sudo systemctl stop docker
```

<br/>

## 2 SQL Installation (Bash)
```Shell
$ sudo docker pull mcr.microsoft.com/mssql/server:2019-latest

# SA_PASSWORD requires symbols/numbers, capital and lowercase letters.
# Example password provided: @strongPassword
$ sudo docker run -e "ACCEPT_EULA=Y" \
                  -e "SA_PASSWORD=@strongPassword" \
                  -p 1433:1433 \
                  --name sql1 \
                  -h sql1 \
                  -d mcr.microsoft.com/mssql/server:2019-latest

# View docker containers
$ sudo docker ps -a
```
