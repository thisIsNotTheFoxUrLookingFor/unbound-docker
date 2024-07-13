#!/bin/bash
chown unbound:unbound /config/unbound.conf
unbound -c /config/unbound.conf -d
