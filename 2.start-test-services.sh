docker run -d --expose 8000 -p :8000 -e VIRTUAL_HOST=whoami3.local --name whoami3 -t jwilder/whoami
docker run -d --expose 8000 -p :8000 -e VIRTUAL_HOST=whoami4.local --name whoami4 -t jwilder/whoami
