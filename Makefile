
build:
	docker build -t sebfrie/css-server .

run:
	docker run -d -e PUID=1029 -e PGID=100 \
		      -p 27015:27015 \
	              -p 27015:27015/udp \
	              -p 1200:1200 \
	              -p 27005:27005/udp \
	              -p 27020:27020/udp \
	              -p 26901:26901/udp \
	              --name css-server \
	              sebfrie/css-server
