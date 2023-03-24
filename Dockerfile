# Use an official C++ base image
FROM gcc:latest

# Install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends cmake libboost-all-dev libasio-dev && \
    apt-get clean
# Set the working directory
WORKDIR /app

# Copy the necessary files
COPY . .

# Build the Crow library
RUN git clone https://github.com/CrowCpp/crow.git && \
    cd crow && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# Compile the application
RUN g++ -o my_api main.cpp -pthread -lboost_system

# Set the entry point for the container
ENTRYPOINT ["./my_api"]