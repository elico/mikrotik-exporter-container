#!/bin/sh

CONFIG_FILE="/config/config.yaml"

if [ ! -x /mikrotik-exporter ]; then
  chmod 755 /mikrotik-exporter
fi

DONT_START="0"

if [ -z "${ROUTER_NAME}" ];then
	DONT_START="1"
	echo "Missing variable: ROUTER_NAME"
else
	sed -i -e "s@###ROUTER_NAME###@${ROUTER_NAME}@g" "${CONFIG_FILE}"
fi

if [ -z "${ROUTER_ADDRESS}" ];then
	DONT_START="1"
	echo "Missing variable: ROUTER_ADDRESS"
else
	sed -i -e "s@###ADDRESS###@${ROUTER_ADDRESS}@g" "${CONFIG_FILE}"
fi

if [ -z "${USER}" ];then
	DONT_START="1"
	echo "Missing variable: USER"
else
	sed -i -e "s@###USER###@${USER}@g" "${CONFIG_FILE}"
fi

if [ -z "${PASSWORD}" ];then
	DONT_START="1"
	echo "Missing variable: PASSWORD"
else
	sed -i -e "s@###PASSWORD###@${PASSWORD}@g" "${CONFIG_FILE}"
fi

if [ -z "${PORT}" ];then
	sed -i -e "s@###PORT###@8728@g" "${CONFIG_FILE}"
else
	sed -i -e "s@###PORT###@${PORT}@g" "${CONFIG_FILE}"
fi

if [ -z "${BGP_METRICS}"  ];then
	sed -i -e "s@bgp: true@bgp: false@g" "${CONFIG_FILE}"
fi

if [ -z "${CONNTRACK_METRICS}"  ];then
	sed -i -e "s@conntrack: true@conntrack: false@g" "${CONFIG_FILE}"
fi

if [ -z "${DHCP_METRICS}"  ];then
	sed -i -e "s@dhcp: true@dhcp: false@g" "${CONFIG_FILE}"
fi

if [ -z "${DHCPL_METRICS}"  ];then
	sed -i -e "s@dhcpl: true@dhcpl: false@g" "${CONFIG_FILE}"
fi

if [ -z "${DHCP6_METRICS}"  ];then
	sed -i -e "s@dhcp6: true@dhcp6: false@g" "${CONFIG_FILE}"
fi

if [ -z "${FIRMWARE_METRICS}"  ];then
	sed -i -e "s@firmware: true@firmware: false@g" "${CONFIG_FILE}"
fi

if [ -z "${HEALTH_METRICS}"  ];then
	sed -i -e "s@health: true@health: false@g" "${CONFIG_FILE}"
fi

if [ -z "${ROUTES_METRICS}"  ];then
	sed -i -e "s@routes: true@routes: false@g" "${CONFIG_FILE}"
fi

if [ -z "${POE_METRICS}"  ];then
	sed -i -e "s@poe: true@poe: false@g" "${CONFIG_FILE}"
fi

if [ -z "${POOLS_METRICS}"  ];then
	sed -i -e "s@pools: true@pools: false@g" "${CONFIG_FILE}"
fi

if [ -z "${OPTICS_METRICS}"  ];then
	sed -i -e "s@optics: true@optics: false@g" "${CONFIG_FILE}"
fi

if [ -z "${W60G_METRICS}"  ];then
	sed -i -e "s@w60g: true@w60g: false@g" "${CONFIG_FILE}"
fi

if [ -z "${WLANSTA_METRICS}"  ];then
	sed -i -e "s@wlansta: true@wlansta: false@g" "${CONFIG_FILE}"
fi

if [ -z "${CAPSMAN_METRICS}"  ];then
	sed -i -e "s@capsman: true@capsman: false@g" "${CONFIG_FILE}"
fi

if [ -z "${WLANIF_METRICS}"  ];then
	sed -i -e "s@wlanif: true@wlanif: false@g" "${CONFIG_FILE}"
fi

if [ -z "${MONITOR_METRICS}"  ];then
	sed -i -e "s@monitor: true@monitor: false@g" "${CONFIG_FILE}"
fi

if [ -z "${IPSEC_METRICS}"  ];then
	sed -i -e "s@ipsec: true@ipsec: false@g" "${CONFIG_FILE}"
fi

if [ -z "${LTE_METRICS}"  ];then
	sed -i -e "s@lte: true@lte: false@g" "${CONFIG_FILE}"
fi

if [ -z "${NETWATCH_METRICS}"  ];then
	sed -i -e "s@netwatch: true@netwatch: false@g" "${CONFIG_FILE}"
fi

if [ "${DONT_START}" -gt "0" ];then
	echo "Can't start missing some env variables"
	exit 1
fi

if [ ! -f "${CONFIG_FILE}" ]
then
	echo "Missing config file"
	exit 2
else
    /mikrotik-exporter -config-file ${CONFIG_FILE}
fi
