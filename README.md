# docker-2048

simple is better

a smaller docker version of 2048

Based on alexwhen/docker-2048(https://github.com/alexwhen/docker-2048)

Based on alpine

using nginx

#dockerfile

	FROM alpine:latest

	MAINTAINER alex <alexwhen@gmail.com> 

	RUN apk --update add nginx

	COPY 2048 /usr/share/nginx/html

	RUN mkdir -p /run/nginx/ && \
		chmod a+w /run/nginx/ && \
		mkdir -p /usr/share/nginx/logs && \
		chmod a+w /usr/share/nginx/logs

	RUN cp /usr/share/nginx/html/TEMPLATES / && \
		for file in $(cat /TEMPLATES); do touch "$file"; done

	EXPOSE 80

	CMD ["nginx", "-p", "/usr/share/nginx", "-g", "daemon off;"]


# Rebuild and push the docker container

	docker build -t "docker-2048" .
	curtag=$(docker images | grep ^docker-2048| awk '{print $3}')
	docker tag ${curtag} jamiesmithnc/docker-2048:latest
	docker push jamiesmithnc/docker-2048

# Pull & Run on apcera

	apc app delete game-jamie -q
	apc docker run game-jamie --image jamiesmithnc/docker-2048 --port 80 --routes http://game.demo.proveapcera.io

# Access the game

	open http://game.demo.proveapcera.io
	(or just click the link)
