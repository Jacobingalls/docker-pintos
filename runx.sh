IP=${IP:=$(ipconfig getifaddr en0)}

echo "Connecting socat display server at $IP:0"

which socat
if [ "$?" != "0" ]; then
	echo "Please install socat! (brew install socat for osx)"
	exit 1
fi

nohup socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" >.socat.log 2>&1&
echo $! > .socat.pid
echo "socat X11 proxy running on PID: $(cat .socat.pid)"

args="$@"

docker run \
    --name pintos \
    -it --rm \
    -v "$PWD:/pintos" \
    -p 1234:1234 \
    -e DISPLAY="$IP:0" \
    jacobingalls/docker-pintos \
        bash -c "
export TERM=xterm
set -e
(cd $(cat make_check_module) && make)
${args}
bash
"

kill -0 $(cat .socat.pid)
if [ "$?" == "0" ]; then
	kill $(cat .socat.pid)
fi
