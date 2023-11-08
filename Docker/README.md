# Docker cheatsheet


* [Docker](#docker)
	* [Install Docker](#install_docker)
	* [Docker file](#dockerfile)
	* [Docker image](#docker_image)
	* [Docker container](#docker_container)
* [Docker compose](#docker_compose)
	* [Install Docker-compose](#install_docker_compose)

<a id="docker"></a>
## Docker

<a id="install_docker"></a>
### install Docker


#### instal Docker by snap

```bash
sudo snap install docker
```

```bash
sudo snap remove docker
```

<a id="dockerfile"></a>
### Docker file

<a id="docker_image"></a>
### Docker image


#### check docker images
```bash
docker image ls
```

#### delete docker image
```bash
docker rmi image_id
```

#### create docker image
```bash
docker build -t your_image_name .
```

#### save and upload docker image
```bash
docker save -o name_of_the_tar_file.tar your_image_name
```

```bash
docker load -i name_of_the_tar_file.tar
```


<a id="docker_container"></a>
### Docker container

#### check list of active containers
```docker
docker ps
```

```bash
docker container ls
```

#### changes inside container

```sh
docker exec -it your_docker_container_id sh
```

#### run docker container from image:
```bash
docker run -d your_image_name
```



<a id="docker_compose"></a>
## Docker compose

<a id="install_docker_compose"></a>
### Insall docker-compose


<a id="run_docker_compose"></a>
### Run docker-compose

- **run docker-compose with .env file**
```bash
docker-compose --env-file your/path/to/.env_file up -d
```

- **stop docker-compose with .env file**
```bash
docker-compose --env-file your/path/to/.env_file down
```