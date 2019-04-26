#!/bin/bash
node_exporter --web.listen-address=":$SCRAPE_PORT"
