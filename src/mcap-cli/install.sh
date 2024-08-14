#!/bin/sh
set -e

# Checks if packages are installed and installs them if not
check_packages() {
	if ! dpkg -s "$@" >/dev/null 2>&1; then
		if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
			echo "Running apt-get update..."
			apt-get update -y
		fi
		apt-get -y install --no-install-recommends "$@"
	fi
}

check_packages curl jq ca-certificates

# Check if VERSION is set, if not, set it to 'latest'
if [ -z "${VERSION}" ]; then
	VERSION=latest
fi

# Check if VERSION is set to 'latest', if so, get the latest release version from GitHub
if [ "${VERSION}" = "latest" ]; then
	versionStr=$(curl https://api.github.com/repos/foxglove/mcap/releases/latest | jq -r '.tag_name')

	# if versionStr matches 'releases/mcap-cli/' then remove 'releases/mcap-cli/' from versionStr
	case "${versionStr}" in
	releases/mcap-cli/*)
		versionStr=$(echo ${versionStr} | sed 's/releases\/mcap-cli\///g')
		echo "Latest version: ${versionStr}"
		;;
	*)

		echo "Setting version to v0.0.42 because the version provided does not match the format of a release version in the GitHub "
		versionStr=v0.0.42
		;;
	esac

else
	versionStr=${VERSION}
fi

# Verify system architecture
arch=$(dpkg --print-architecture)
case "${arch}" in
amd64) archStr=amd64 ;;
arm64) archStr=arm64 ;;
*)
	echo "MCAP cli does not support machine architecture '$arch'. Please use an x86-64 or ARM64 machine."
	exit 1
	;;
esac

# Download and install MCAP cli
echo "Downloading MCAP cli ${versionStr} for ${archStr}..."
curl -SL "https://github.com/foxglove/mcap/releases/download/releases%2Fmcap-cli%2F${versionStr}/mcap-linux-${archStr}" -o mcap

# Move the binary to /usr/local/bin
mv mcap /usr/local/bin/mcap

echo "MCAP installed!"

chmod +x /usr/local/bin/mcap

# Clean up
rm -rf /var/lib/apt/lists/*
