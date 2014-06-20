FROM ubuntu
MAINTAINER "Eugene Petrenko <eugene.petrenko@gmail.com>"

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y git
RUN apt-get install -y build-essential 
RUN apt-get install -y cmake 
RUN apt-get install -y python 
RUN apt-get install -y nodejs
RUN apt-get install -y openjdk-7-jdk 
RUN apt-get install -y clang-3.3 
RUN apt-get install -y llvm-3.3


RUN git clone --depth=1 --branch 1.16.0 https://github.com/kripken/emscripten /opt/emscripten

RUN for prog in em++ em-config emar emcc emconfigure emmake emranlib emrun emscons; do \
  ln -sf /opt/emscripten/$prog /usr/local/bin; done

ENV LLVM=/usr/lib/llvm-3.3/bin


# partially forked from https://github.com/hanazuki/docker-ubuntu-emscripten/blob/master/Dockerfile
# build an example code in order to cache the standard libraries and relooper
RUN emcc --version && \
  mkdir -p /tmp/emscripten_temp && cd /tmp/emscripten_temp && \
  EMCC_FORCE_STDLIBS=1 em++ -O2 /opt/emscripten/tests/hello_world_sdl.cpp -o hello.js && \
  (nodejs hello.js 2> /dev/null | grep hello) && \
  rm -rf /tmp/emscripten_temp

