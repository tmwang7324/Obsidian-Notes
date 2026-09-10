
# Introduction to Microservices

### Drawbacks of Monolithic Architecture

- Hard to organize
- Hard to upgrade
- Errors crash the entire application
- Only supports one language / framework / database

Try to use asynchronous, only  use synchronous when necessary (if statements)

![image.png](image%201.png)

## Horizontal Scaling vs Vertical Scaling

### Vertical Scaling:
Increasing the processing power limit with CPU and RAM

**Drawbacks:** too expensive and not feasible for our activity
single point of failure (SPF) → If a single area fails, then the program fails

### Horizontal Scaling:
Increasing the amount of servers

**Pros:** Protects against SPF

---

# Docker
When I install Docker Desktop on Windows, containers do not run directly on *Windows* - they run inside a lightweight Linux VM (the WSL2 backend). That VM is a separate "machine" as far as networking goes, so Windows creates a **virtual network adapter** to connect itself to it. I can see it if I run **ipconfig:** it shows up as something liek **vEthernet (WSL)** with its own IP address (e.g. **172.x.x.x**), alongside my real Wi-Fi adapter.

***DNS:*** Domain Name System is a hierarchical and distributed name service that **provides a naming system for computers, services, and other resrouces** on the world-wide web.

An example of a ***DNS*** is **localhost** being **127.0.0.1.** This means that in Docker, **127.0.0.1** does not point to the local machine localhost. 

## Purpose
set up env ⇒ java react, java 1.20 library
let’s say that the organization still uses java 1.15.

dependency issues will be very expensive.
So, we store all dependencies on containers

![image.png](image%203.png)

| Containers | Virtual Machines |
| --- | --- |
| Containers share operating systems | Virtual Machines each have their own operating systems |
| 40 MB | 1 GB of memory |
| ~5 seconds to create | ~1 minute |

![image.png](image%204.png)

template contains all of the functionality/code of your project

![image.png](image%205.png)

do


## Docker Commands

```bash

docker pull node  #pulls image from dockerhub
docker run mongo #runs the image
docker ps # list active containers
docker ps -a # lists all containers (even inactive)
docker run -a mongo #Attach Mode 
docker run -d mongo #Detach Mode - if terminal is shut down then the docker still runs
docker stop $id1 #stops docker process with id id1
docker rm $(docker ps -aq) #removes all docker processes
docker images #shows all images
docker rmi $id1 # removes docker image with id id1
docker rmi $(docker images -q) # removes all docker images
docker image prune # removes all dangling images
docker run -p 80:5000 webApp #runs webApp image on host port 80 to container port 5000


docker logs rabbitmq          # dump all logs
docker logs -f rabbitmq       # follow (like tail -f), Ctrl+C to stop
docker logs --tail 50 rabbitmq  # last 50 lines
docker logs -f --since 5m rabbitmq  # follow, starting from 5 minutes ago

```

We cannot use two of the same host ports.
We can mount temp data 

## Volume

Saving data in order to prevent data loss

## DockerFile

Let’s say we have a DockerFile

```docker
# base go image
FROM golang:1.22-alpine as builder

# Create a directory for the app
RUN mkdir /app

# Copy the app source code into the container
COPY . /app

# Set the working directory to the app directory
WORKDIR /app

# Build the app
RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

# Make the binary executable
RUN chmod +x /app/brokerApp

# Build a tiny docker image
FROM alpine:latest

# Create a directory for the app
RUN mkdir /app

# Copy the built binary from the builder stage to the final image
COPY --from=builder /app/brokerApp /app

# Specify the command to run when the container starts
# Runs the actual application 
CMD [ "/app/brokerApp" ]
```

**IMPORTANT:** Creates two app repos, One raw that contains all dependencies and one optimized repo that contains the binary compilation of your code. 

```bash
cd DockerFile's Folder
docker build -t goapp #builds the docker file present in the dockerfile folder
#everything will be located in the goapp is sent to
#creates template
docker run -d -p 8005:8000 pyapp

```

## dockercompose.yml

```bash
docker compose up -d #runs the docker-compose and starts the container
#builds from the cache, does not keep track of change
docker compose up -d --build #rebuilds docker container
docker compose -f docker-compose.yml build # creates new images according to docker-compose.yml
#keeps track of change, similar to nodemon
docker compose down #stops the container
```

The yml is basically a config file.
Running it using the build flag or build command creates the Docker network/image.

# MakeFile

How stable is this instance

# Javascript

```jsx
function getData() {
}

getData();

let x = 0; //changeable variables
x = 2;
const y = 0; //non-changeable constants

```