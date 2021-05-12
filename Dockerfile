FROM archlinux:base as builder

MAINTAINER Firejox <firejox@gmail.com>

RUN pacman -Syu --noconfirm
RUN pacman -Syu --needed --noconfirm base-devel git python2 python3 ruby

WORKDIR /usr/local/src

RUN git clone https://github.com/vim/vim \
  && cd vim \
  && ./configure \
      --disable-gui \
      --disable-netbeans \
      --enable-multibyte \
      --enable-pythoninterp \
      --enable-python3interp \
      --enable-rubyinterp \
  && make install

FROM archlinux:base-devel

COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/share /usr/local/share

ENTRYPOINT ["vim"]
