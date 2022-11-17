/interface/bridge/add name=dockers
/ip/address/add address=172.20.0.254/24 interface=dockers

/interface/veth/add name=veth5 address=172.20.0.5/24 gateway=172.20.0.254
/interface/bridge/port add bridge=dockers interface=veth5

/ip/firewall/filter/add chain=input protocol=tcp dst-port=8728 connection-state=new src-address=172.20.0.5 action=accept place-before=0

/container/config/set registry-url=https://registry-1.docker.io tmpdir=disk1/pull

/container/envs/add name=prom_exporter_envs key=TZ value="Asia/Jerusalem"
/container/envs/add name=prom_exporter_envs key=ROUTER_NAME value="RB4011"
/container/envs/add name=prom_exporter_envs key=ROUTER_ADDRESS value="172.20.0.254"
/container/envs/add name=prom_exporter_envs key=USER value="prometheus"
/container/envs/add name=prom_exporter_envs key=PASSWORD value="changeme"
/container/envs/add name=prom_exporter_envs key=PORT value="8728"
/container/envs/add name=prom_exporter_envs key=CONNTRACK_METRICS value="1"
/container/envs/add name=prom_exporter_envs key=DHCP_METRICS value="1"
/container/envs/add name=prom_exporter_envs key=DHCPL_METRICS value="1"
/container/envs/add name=prom_exporter_envs key=FIRMWARE_METRICS value="1"
/container/envs/add name=prom_exporter_envs key=HEALTH_METRICS value="1"
/container/envs/add name=prom_exporter_envs key=ROUTES_METRICS value="1"
/container/envs/add name=prom_exporter_envs key=NETWATCH_METRICS value="1"

/container/add dns=172.20.0.254 remote-image=elicro/mikrotik-exporter:latest interface=veth5 root-dir=disk1/mt-exporter envlist=prom_exporter_envs start-on-boot=yes
