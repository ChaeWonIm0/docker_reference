FROM httpd:alpine
LABEL maintainer="dla9944@naver.com"
LABEL version="1.0.0"
LABEL description="A test docker image to understand Docker"

COPY ./EWS_diary /usr/local/apache2/htdocs

ENTRYPOINT ["/bin/echo", "hello"]
