# 流媒体服务器
## brpc media sever
推流：
```
ffmpeg -y -re -stream_loop -1 -i "test.mp4" -f flv -y "rtmp://host.docker.internal:8079/live/test?vhost=_"
```
rtmp: 
```
rtmp://localhost:8079/live/test
```
flv: 
```
http://localhost:8079/live/test.flv
```
hls: 
```
http://localhost:8079/live/test.m3u8?specified_host=localhost:8079
```

