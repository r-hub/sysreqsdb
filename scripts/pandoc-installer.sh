#! /bin/bash

URL="https://files.r-hub.io/pandoc/pandoc-latest"
TARGET="/usr/local/bin"
mkdir -p $TARGET

# Download and install Pandoc binaries, works on Linux and OSX, for now

if uname > /dev/null && [ $(uname) == 'Darwin' ]; then
    >&2 echo "macOS detected"
    type="OSX"
    PANDOC="${URL}/mac/pandoc"
    PANDOC_CITEPROC="${URL}/mac/pandoc-citeproc"

elif uname > /dev/null && [ $(uname) == 'Linux' ] ;then
    >&2 echo "Linux detected"
    if [ -f /etc/debian_version ]; then
	>&2 echo "DEB distro detected"
	distro=debian
	arch=$(uname -p)
    elif [ -f /etc/redhat-release ]; then
	>&2 echo "RPM distro detected"
	distro=rpm
	arch=$(uname -p)
    else
	>&2 echo "Unknown distro, try DEB"
	distro=debian
	arch=$(uname -p)
    fi

    # Some Docker images report unknown, try to use 64 bit then
    if [ "$arch" == "unknown" ]; then
	arch="x86_64"
    fi

    PANDOC="${URL}/linux/${distro}/${arch}/pandoc"
    PANDOC_CITEPROC="${URL}/linux/${distro}/${arch}/pandoc-citeproc"
else
    >&2 echo "Unknown OS type."
    exit 1
fi

cd $TARGET
curl -O ${PANDOC}
curl -O ${PANDOC_CITEPROC}

chmod +x pandoc
chmod +x pandoc-citeproc
