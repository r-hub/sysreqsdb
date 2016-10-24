#! /bin/bash

URL="https://files.r-hub.io/pandoc/pandoc-latest"
TARGET="$HOME/bin"
mkdir -p $TARGET

# Download and install Pandoc binaries, works on Linux and OSX, for now

if uname > /dev/null && [ $(uname) == 'Darwin' ]; then
    echo "macOS detected"
    type="OSX"
    PANDOC="${URL}/mac/pandoc"
    PANDOC_CITEPROC="${URL}/mac/pandoc-citeproc"

elif uname > /dev/null && [ $(uname) == 'Linux' ] ;then
    echo "Linux detected"
    if [ -f /etc/debian_version ]; then
	echo "DEB distro detected"
	distro=debian
	arch=$(uname -p)
    elif [ -f /etc/redhat-release ]; then
	echo "RPM distro detected"
	distro=rpm
	arch=$(uname -p)
    else
	echo "Unknown distro, try DEB"
	distro=debian
	arch=$(uname -p)
    fi

    PANDOC="${URL}/linux/${distro}/${arch}/pandoc"
    PANDOC_CITEPROC="${URL}/linux/${distro}/${arch}/pandoc-citeproc"
else
    echo "Unknown OS type."
    exit 1
fi

cd $TARGET
curl -O ${PANDOC}
curl -O ${PANDOC_CITEPROC}

chmod +x pandoc
chmod +x pandoc-citeproc
