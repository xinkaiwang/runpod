# How to build?

```
docker build -t xinkai-i3:0.2 .
```

# How to run the image locally?

```
docker run -it  docker.io/library/xinkai-i3:0.2 -- /bin/bash
```


```
docker build -t my-gpu-ssh-image .
docker run -d -p 2222:22 --name gpu-ssh-container my-gpu-ssh-image
ssh root@localhost -p 2222
docker stop gpu-ssh-container
docker rm gpu-ssh-container
```
