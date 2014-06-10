FROM ubuntu
MAINTAINER "Eugene Petrenko <eugene.petrenko@gmail.com>"

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y git
RUN apt-get install -y build-essential 
RUN apt-get install -y cmake 
RUN apt-get install -y scons 
RUN apt-get install -y python 
RUN apt-get install -y nodejs 
RUN apt-get install -y default-jre-headless 
RUN apt-get install -y clang 
RUN apt-get install -y llvm


RUN git clone --depth=1 --branch 1.16.0 https://github.com/kripken/emscripten /opt/emscripten

RUN for prog in em++ em-config emar emcc emconfigure emmake emranlib emrun emscons; do \
  ln -sf /opt/emscripten/$prog /usr/local/bin; done



