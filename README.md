# My_env

Working env base by docker image

# Local comand

Build command: "docker build -t my_env:latest ."
Run command: "docker run --hostname siema -v ./mount:/workdir/my_volumen_data -it my_env:latest"

# To Pull

docker pull narwaqazwsx/my_env

# Prometheus

start: " docker run -d -p 9090:9090 -v ./tmp/prometheus/prometheus.yaml:/etc/prometheus.yaml prom/prometheus --config.file=/etc/prometheus.yaml"
look: "http://localhost:9090/"

# Attach to contener

docker-compose up -d
docker-compose exec env1 /bin/bash
docker-compose down

# To do do

dodanie sieci
