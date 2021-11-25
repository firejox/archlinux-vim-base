from archlinux:base as builder

label maintainer.name="Firejox"
label maintainer.email="firejox@gmail.com"

run pacman -Syu --noconfirm && \
    pacman -Syu --needed --noconfirm base-devel git python2 python3 ruby && \
    cd /usr/local/src && \
    git clone https://github.com/vim/vim && \
    cd vim && \
    ./configure \
      --disable-gui \
      --disable-netbeans \
      --enable-multibyte \
      --enable-pythoninterp \
      --enable-python3interp \
      --enable-rubyinterp && \
    make install

from archlinux:base-devel

copy --from=builder /usr/local/bin /usr/local/bin
copy --from=builder /usr/local/share /usr/local/share

cmd /bin/bash
