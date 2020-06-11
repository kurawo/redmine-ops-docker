#!/bin/bash
pg_dumpall -f /tmp/pgdump/dump.`date "+%Y%m%d_%H%M%S"`.sql -U redmine
