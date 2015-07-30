#!/usr/bin/env bash
# see https://github.com/l3iggs/docker-owncloud/wiki/Store-your-data-outside-of-the-container
#
# ocfiles
chmod -R 770 ./oc/volumes/data/
chgrp -R 33 ./oc/volumes/data/
#
# config
chmod -R g+rw ./oc/volumes/config/
chgrp -R 33 ./oc/volumes/config/
