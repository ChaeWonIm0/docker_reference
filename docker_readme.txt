

도커 컨테이너 확인
docker ps -a
docker images

숨김파일까지 전부 확인
ls -al

죄다 삭제
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi -f $(docker images -q)

가상환경 돌입
cd venvs
. myproject.sh


docker run -d -p 

dockerfile 제작한 디렉토리
cd projects
vi Dockerfile

dockerfile 메모
FROM httpd:alpine

LABEL maintainer="dla9944@naver.com"

COPY ./ /usr/local/apache2/htdocs
ENTRYPOINT ["/bin/sh"]

docker build --tag myweb3 .

docker build --tag myflask .

docker run -dit 9999:80 --name httpweb3 myweb3

docker stop
docker rm

docker run -dit -p 9999:80 --name flask2 myflask

vi Dockerfile-apache

EXPOSE 80

docker build --tag myweb -f Dockerfile-apache .

도커 컨테이너 상태확인
docker inspect myweb
docker logs myweb

(pc의 랜덤 port로 시작)
docker run -P -d myweb

FROM mysql:5.7

ENV MYSQL_ROOT_PASSWORD=12345678
ENV MYSQL_DATABASE=funcoding

docker build --tag mysqldb -f Dockerfile-mysql

docker run -dit -p 9999:80

자연어처리 영어일기 
이거 기록
set FLASK_APP=pybo
set FLASK_DEBUG=true
set APP_CONFIG_FILE=home\ubuntu\ai26\myproject\config\development.py
아니면 이거
ENV FLASK_APP=pybo
ENV APP_CONFIG_FILE=home\ubuntu\ai26\myproject\config\development.py

CMD ["flask", "run", "--host=0.0.0.0"]

dockerfile 메모
FROM ubuntu:18.04
LABEL maintainer="dla9944@naver.com"
RUN apt-get update
RUN apt-get install -y apache2

COPY ./EWS_diary /var/www/html

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

docker build --tag myweb -f Dockerfile-ubuntu .

이미지 수정기록
docker history myweb
docker run -dit -p 9999:80 --name ubuntu1 myweb

이미지와 컨테이너 비교
docker diff mywebserver
jupyter notebook 오픈
docker run --rm -d -p 8888:8888 -v /home/ubuntu/2023_learn:/home/jovyan/work --link mydb:myjupyterdb jupyter/datascience-notebook
jupyter notebook 토큰
844482e7aae56288c89e2e3200bfde8e73f1537583cddaf8

링크 기능
docker run --rm -d -p 8888:8888 -v /home/ubuntu/2023_learn:/home/jovyan/work --link mydb:myjupyterdb jupyter/datascience-notebook

sql = ''' CREATE TABLE product (Product_CODE VARCHAR(20) NOT NULL,
TITLE VARCHAR(200) NOT NULL,
ORI_PRICE INT,
DISCOUNT_PRICE INT,
DISCOUNT_PERCENT INT,
DELIVERY VARCHAR(2),
PRIMARY KEY(PRODUCT_CODE)
);
'''

도커 컴포즈 작업 폴더
cd projects/00_FINAL_CODE/02_FLASK_MYSQL
vi docker-compose.yml 파일
version: "3"


services:
  app:
    build:
      context: ./01_FLASK_DOCKER
      dockerfile: Dockerfile
    links:
      - "db:mysqldb"
    ports:
      - "80:8080"
    container_name: appcontainer
    depends_on:
      - db

  db:      
    image: mysql:5.7
    restart: always
    volumes:
      - ./mysqldata:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=funcoding
      - MYSQL_DATABASE=fundb
    ports:
       - "3306:3306"
    container_name: dbcontainer     

.dockerignore

*/flask*
*/*/flask*
flask*
flask?

app.run(host='0.0.0.0', port='8080')

cd ../
docker-compose up -d

from flask import Flask
import pymysql

app = Flask(__name__)

MYSQL_HOST = 'mysqldb'
MYSQL_PORT = 3306

def conn_mysqldb():
    MYSQL_CONN = pymysql.connect(
        host=MYSQL_HOST,
        port=MYSQL_PORT,
        user='root',
        passwd='funcoding',
        db='fundb',
        charset='utf8'
    )
    return MYSQL_CONN


@app.route('/')
def hello_world():
    mysql_db = conn_mysqldb()
    db_cursor = mysql_db.cursor()
    sql = "SHOW TABLES"
    # print (sql)
    db_cursor.execute(sql)
    user = db_cursor.fetchone()
    print (user, MYSQL_HOST)
    return 'SUCCESS'


if __name__ == '__main__':
    app.run(host='0.0.0.0', port='8080')

도커 컴포즈 전부중단
docker-compose down

도커 컴포즈 상태확인
docker-compose config

도커 컴포즈된 파일을 bash 진입수정
docker-compose exec

Nginx 기본 사용법(포트 9999로 교체)
docker run -dit -p 80:8080 --name myos ubuntu:20.04
docker run -dit -p 9999:8080 --name myos ubuntu:20.04
docker exec -it myos /bin/bash

apt-get update
apt-get install nginx=1.18.0-0ubuntu1
버전 대체
apt-get install nginx
apt-get install vim

특정 문구를 찾는 (경로 위치를 가르쳐주는) 명령어
find -name nginx.conf
수정
vi /etc/nginx/nginx.conf

nginx를 어떻게 서리하느냐에 따라 설정 file의 position이 달라질수 있음
cd sites-available
sites-avaliable에 심볼릭 링크를 넣어놓음
vi default

nginx 재시작하기 (default 수정시 재실행 확인)
service nginx restart

cd /var/www/html
vi index.nginx-debian.html
html 파일 수정
location /blog {
/var/www/;
}

location /flask {
root /var/www;
}

nginx reverse proxy
프록시 서버는 클라이언트가 자신을 통해, 다른 네트워크 서비스에 접속할
수 있게 해주는 서버

대신 접속
cd projects/00_FINAL_CODE/03_NGINX_PROXY_PORT/nginx$


wordpress 폴더에서 사이트 제작
nginx reserve proxy 서버 사용
wordpress 사용 > https를 꼭 사용하도록 권장
