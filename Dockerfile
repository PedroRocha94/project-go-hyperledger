# Use the Golang base image
FROM golang:1.21

WORKDIR /usr/src/app

# Install Hyperledger Fabric dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    ca-certificates \
    git \
    libtool \
    libltdl-dev \
    libssl-dev \
    libevent-dev \
    libffi-dev \
    libyaml-dev \
    zlib1g-dev \
    libgmp-dev \
    libboost-dev \
    libboost-chrono-dev \
    libboost-graph-dev \
    libboost-iostreams-dev \
    libboost-math-dev \
    libboost-regex-dev \
    libboost-serialization-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libpq-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libsqlite3-dev \
    libleveldb-dev \
    libsnappy-dev \
    libbz2-dev \
    libgflags-dev \
    libgmp-dev \
    libpcap-dev \
    libreadline-dev \
    libncurses5-dev \
    liblmdb-dev \
    libsodium-dev \
    libhidapi-dev \
    libsecp256k1-dev \
    libzmq3-dev \
    libczmq-dev \
    libusb-1.0-0-dev \
    libudev-dev \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .
RUN go build -v -o /usr/local/bin/app .

CMD ["app"]