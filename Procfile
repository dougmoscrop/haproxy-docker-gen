haproxy: haproxy -f /app/haproxy.cfg
dockergen: docker-gen -watch -only-exposed -notify "pkill haproxy" /app/haproxy.tmpl /app/haproxy.cfg
