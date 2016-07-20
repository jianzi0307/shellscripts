# gitlab install script
# by jianzi 20160718

yum install -y curl openssh-server openssh-clients postfix cronie
service postfix start
chkconfig postfix on
lokkit -s http -s ssh

curl -sS http://packages.gitlab.cc/install/gitlab-ce/script.rpm.sh | bash
yum install -y gitlab-ce

gitlab-ctl reconfigure
