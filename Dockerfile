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
