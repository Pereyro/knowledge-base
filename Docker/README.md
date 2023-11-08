# Docker

* [Docker](#)
	* [Install Docker](#install_docker)
	* [Docker image](#docker_image)
	* [Docker container](#docker_container)
	* [Docker compose](#docker_compose)


<a id="install_docker"></a>
## install Docker

```bash
sudo snap install docker
```

```bash
sudo snap remove docker
```


<a id="docker_image"></a>
## Docker image

docker image ls

docker rmi image_id

docker build -t your_image_name .

docker save -o name_of_the_tar_file.tar your_image_name

docker load -i name_of_the_tar_file.tar



<a id="docker_container"></a>
## Docker container


```docker
docker ps
```

```bash
docker container ls
```

### run docker container from image:
```bash
docker run -d your_image_name
```



<a id="docker_compose"></a>
## Docker compose

### Run docker-compose

- **run docker-compose with .env file**
```bash
docker-compose --env-file your/path/to/.env_file up -d
```

- **stop docker-compose with .env file**
```bash
docker-compose --env-file your/path/to/.env_file down
```