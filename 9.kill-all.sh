docker stop $(docker ps -a -q) -t 1
docker rm $(docker ps -a -q)
