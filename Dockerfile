FROM debian:testing

# toolbox-base: essential dev tools + dotfiles, openssh server for pairing
MAINTAINER evey@7pr.xyz

RUN apt-get update && apt-get install -y zsh vim-nox tmux build-essential git \
htop atop nmap iftop iotop mc net-tools xfsprogs stow curl wget file tree silversearcher-ag \
ncurses-term ctags openssh-server

RUN echo 'root:pairwithme' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd

WORKDIR /root/

ADD http://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new uuid

RUN git clone https://github.com/robbyrussell/oh-my-zsh .oh-my-zsh
RUN git clone https://github.com/evq/dotfiles

WORKDIR /root/dotfiles/
RUN stow tmux
RUN stow zsh
RUN stow vim
RUN stow inputrc

RUN mkdir vim/.vim/bundle
RUN git clone https://github.com/gmarik/Vundle.vim vim/.vim/bundle/vundle
RUN  vim --noplugin +BundleInstall +qall

ENV TERM screen-256color

EXPOSE 22
WORKDIR /root/
CMD /bin/zsh
