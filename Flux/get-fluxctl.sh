cd "${0%/*}"

wget https://github.com/fluxcd/flux/releases/download/1.14.2/fluxctl_linux_amd64
chmod a+x fluxctl_linux_amd64
sudo mv fluxctl_linux_amd64 /usr/local/bin/fluxctl
