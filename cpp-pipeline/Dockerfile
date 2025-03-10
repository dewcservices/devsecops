FROM registry.access.redhat.com/ubi9/ubi:latest

RUN dnf update -y; \
# Install git, nano & clang, cmake, gcc-c++, ninja-build, meson, gdb
dnf install git nano clang cmake gcc-c++ ninja-build meson gdb -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
rm -rf /var/cache

# OPTIONAL DEPLOYMENT EXAMPLE:
#-----------------------------
## Make App folder, copy project into container
# WORKDIR /app
# COPY . .

## Install project requirements, build project
# RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -G "Ninja"
# RUN cmake --build build --config Release

## Expose port and run app
# EXPOSE 8080
# CMD [ /app/out/build/example  ]