#!/bin/sh

set -ex

BALENA_SUPERVISOR_ADDRESS=${BALENA_SUPERVISOR_ADDRESS:?missing balena-supervisor address}
BALENA_SUPERVISOR_API_KEY=${BALENA_SUPERVISOR_API_KEY:?missing API key}

TEXTFILEDIR=${TEXTFILEDIR:-/textfiles}
commit_metric() {
	fname="${TEXTFILEDIR}/${1}.prom"
	tee "${fname}\$$"
	mv "${fname}\$$" "${fname}"
}

supervisor_healthy() {
	curl -SsfL "$BALENA_SUPERVISOR_ADDRESS/v1/healthy"
}
supervisor_version() {
	curl -SsfL "$BALENA_SUPERVISOR_ADDRESS/v2/version" |
		jq -r '.version'
}

supervisor_metrics() {
	printf "# HELP balena_device_supervisor Information about balena-supervisor\n# TYPE balena_device_supervisor gauge\nbalena_device_supervisor{version=\"$(supervisor_version)\",healthy=\"$(supervisor_healthy)\"} 1\n" | commit_metric "balena_device_supervisor"
}

supervisor_metrics
