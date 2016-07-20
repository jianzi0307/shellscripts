#!/bin/sh
# default backup directory: /var/opt/gitlab/backups
# change it by edit the file: /etc/gitlab/gitlab.rb
gitlab-rake gitlab:backup:create
