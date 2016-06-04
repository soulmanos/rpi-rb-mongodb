# rpi-rb-mongodb
Docker Raspberry Pi2 MongoDB 3.0.9 Build

1) git clone

2) docker build -t <yourDockerhubName>/rpi-rb-mongodb .

3) docker run -d -p 27017:27017 -v /home/pi/mongodb:/data soulmanos/rpi-rb-mongodb
