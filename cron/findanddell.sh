#!/bin/bash
find /tmp/pgdump/ -name 'dump.*.sql' -mtime +5 -delete
find /var/log/postgresql -name 'postgresql.*.log' -mtime +30 -delete
find /tmp/datadump/ -name '*.tar.gz' -mtime +5 -delete