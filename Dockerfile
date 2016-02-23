FROM alpine:latest
MAINTAINER Florian CAUZARD <florian.cauzardjarry@gmail.com>


RUN apk --update add py-pip tar \
    && pip install --upgrade pip \
    && pip install Pygments
ENV VERSION 0.15
ENV BINARY hugo_${VERSION}_linux_amd64

ADD https://github.com/spf13/hugo/releases/download/v${VERSION}/${BINARY}.tar.gz /usr/local
RUN tar xzf /usr/local/${BINARY}.tar.gz -C /usr/local \
    && ln -s /usr/local/${BINARY}/${BINARY} /usr/local/bin/hugo \
    && rm /usr/local/${BINARY}.tar.gz

WORKDIR /hugo

RUN git clone https://github.com/resyst-it/blog-hugo

EXPOSE 1313

ENV BIND --bind=0.0.0.0
ENV THEME hugo-redlounge
CMD hugo server -w -v ${BIND} -t ${THEME}
