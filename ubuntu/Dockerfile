FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install autoconf libtool libpam-dev libssl-dev make curl

ENV IKEY=${IKEY}
ENV SKEY=${SKEY}
ENV HOST=${HOST}

RUN mkdir -p "pam_duo"

WORKDIR /pam_duo

RUN curl https://dl.duosecurity.com/duo_unix-latest.tar.gz -O
RUN tar zxf duo_unix-latest.tar.gz 
RUN cd duo_unix-1.11.2 && ./configure --with-pam --prefix=/tmp && make DESTDIR=/tmp install

COPY . .

RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]