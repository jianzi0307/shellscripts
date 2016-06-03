#!/bin/sh
echo -n "Input Server ID(s:single table, #:server group id): "
read ServerID
HOSTNAME="localhost"
USER="root"
PWD=""
DB_NAME="navis_log"
SQL="tmp_s.sql"
echo "use $DB_NAME" > $SQL

if [ $ServerID == "s" ]; then
    #----------------------------------------------------------------------------
    # 단일 디비 테이블들(서버와 관계 없는 테이블 들이다.)
    #----------------------------------------------------------------------------
    #일단 드랍부터 시키자
#echo "drop table statistic;" >> $SQL
#    echo "drop table game_svr_state;" >> $SQL
#    echo "drop table gm_user;" >> $SQL
#    echo "drop table gm_log;" >> $SQL
#    echo "drop table account_event;" >> $SQL
#    echo "drop table conc_conn_report;" >> $SQL
#    echo "drop table account_regist_report;" >> $SQL
    #statistic
    statistic="create table statistic
    (
    id int( 11 ) default null auto_increment,
    log_time datetime not null default '0000-00-00 00:00:00',
    log_id tinyint( 2 ) not null default 0,
    field_1 int( 11 ) default null,
    field_2 int( 11 ) default null,
    field_3 int( 11 ) default null,
    text_field varchar( 32 ) not null,
    primary key( id )
    );"
    echo "$statistic" >> $SQL

    #game_svr_state
    game_svr_state="create table game_svr_state
    (
    id int( 11 ) default null auto_increment,
    log_time datetime not null default '0000-00-00 00:00:00',
    server_id int( 3 ) not null,
    max_conn int( 15 ) not null,
    conc_conn int( 15 ) not null,
    primary key( id )
    );"
    echo "$game_svr_state" >> $SQL
    #gm_user
    gm_user="create table gm_user(
    id int( 11 ) not null auto_increment,
    login varchar( 32 ) not null,
    password varchar( 32 ) not null,
    name varchar( 32 ) not null,
    email varchar( 32 ) not null,
    zipcode varchar( 16 ),
    address text,
    phone1 varchar( 32 ) not null,
    phone2 varchar( 32 ),
    sex tinyint( 1 ),
    last_login timestamp,
    permission int( 5 ),
    status tinyint( 2 ),
    birthday date default '0000-00-00 00:00:00',
    create_date datetime not null,
    primary key( id )
    );"
    echo "$gm_user" >> $SQL
    #gm_log
    gm_log="create table gm_log(
    id int( 11 ) not null auto_increment,
    log_time datetime not null default '0000-00-00 00:00:00',
    acc_uid int( 11 ) not null,
    acc_name varchar( 32 ) not null default '',
    acc_auth tinyint( 2 ) not null,
    ip varchar( 16 ) not null,
    act_id int( 11 ),
    act_desc varchar( 64 ),
    primary key( id )
    );"
    echo "$gm_log" >> $SQL
    #account_event
    account_event="create table account_event
    (
    id int default null auto_increment,
    log_time datetime not null,
    log_id tinyint( 2 ) not null default 0,
    ip_addr varchar(30) NOT NULL default '',
    acc_uid int not null,
    acc_name varchar( 32 ) not null default '',
    acc_sex tinyint( 1 ) not null default 1,
    acc_region int not null,
    acc_age tinyint( 2 ) not null,
    acc_auth tinyint( 2 ) not null,
    type tinyint( 1 ),
    time int(11) NOT NULL default '0', 
    primary key( id )
    );"
    echo "$account_event" >> $SQL
    #conc_conn_report
    conc_conn_report="create table conc_conn_report(
    id int( 11 ) not null auto_increment,
    log_time datetime not null default '0000-00-00 00:00:00',
    channel_kind int( 5 ) not null,
    channel varchar( 32 ) not null,
    conc_conn_cnt int( 11 ) not null default '',
    primary key( id )
    );"
    echo "$conc_conn_report" >> $SQL
    #account_regist_report
    account_regist_report="create table account_regist_report(
    id int( 11 ) not null auto_increment,
    log_time datetime not null default '0000-00-00 00:00:00',
    channel_kind int( 5 ) not null,
    channel varchar( 32 ) not null,
    regist_cnt int( 11 ) not null default '',
    primary key( id )
    );"
    echo "$account_regist_report" >> $SQL
    #----------------------------------------------------------------------------
    if [ -x $PWD ] ; then
	CMD="/usr/local/mysql/bin/mysql -u$USER -h$HOSTNAME";
    else
	CMD="/usr/local/mysql/bin/mysql -u$USER -p$PWD -h$HOSTNAME";
    fi

    $CMD < $SQL

    rm -rf $SQL
else
    #----------------------------------------------------------------------------
    # 서버 의존 디비 테이블들(서버와 관계 있는 테이블 들이다.)
    #----------------------------------------------------------------------------
    #일단 드랍부터 시키자
#echo "drop table statistic_svr_$ServerID;" >> $SQL
#    echo "drop table statistic_level_svr_$ServerID;" >> $SQL
#    echo "drop table statistic_job_svr_$ServerID;" >> $SQL
#    echo "drop table statistic_guild_svr_$ServerID;" >> $SQL
#    echo "drop table snap_svr_$ServerID;" >> $SQL
#    echo "drop table snap_text_svr_$ServerID;" >> $SQL
#    echo "drop table char_event_svr_$ServerID;" >> $SQL
#    echo "drop table char_die_svr_$ServerID;" >> $SQL
##    echo "drop table char_item_svr_$ServerID;" >> $SQL
##    echo "drop table char_operator_svr_$ServerID;" >> $SQL
#    echo "drop table char_job_level_svr_$ServerID;" >> $SQL
#    echo "drop table char_return_svr_$ServerID;" >> $SQL
#    echo "drop table char_quest_svr_$ServerID;" >> $SQL
#    echo "drop table char_ship_svr_$ServerID;" >> $SQL
#    echo "drop table char_skill_svr_$ServerID;" >> $SQL
    #statistic_svr_#
    statistic_svr="create table statistic_svr_$ServerID
    (
    id int( 11 ) not null auto_increment,
    log_time datetime default '0000-00-00 00:00:00' not null,
    log_id tinyint( 2 ) default 0 not null,
    field_1 int( 11 ) default NULL,
    field_2 int( 11 ) default NULL,
    field_3 int( 11 ) default NULL,
    field_4 int( 11 ) default NULL,
    field_5 int( 11 ) default NULL,
    primary key( id )
    );"
    echo "$statistic_svr" >> $SQL

    #statistic_level_svr_#
    statistic_level_svr="create table statistic_level_svr_$ServerID(
    id int( 11 ) not null auto_increment,
    log_time datetime default '0000-00-00 00:00:00' not null,
    level int( 3 ),
    char_cnt int( 5 ),
    game_time int( 11 ),
    primary key( id )
    );"
    echo "$statistic_level_svr" >> $SQL

    #statistic_job_svr_#
    statistic_job_svr="create table statistic_job_svr_$ServerID(
    id int( 11 ) not null auto_increment,
    log_time datetime default '0000-00-00 00:00:00' not null,
    job_id int( 11 ),
    char_cnt int( 11 ),
    game_time int( 11 ),
    primary key( id )
    );"
    echo "$statistic_job_svr" >> $SQL

    #statistic_guild_svr_#
    statistic_guild_svr="create table statistic_guild_svr_$ServerID(
    id int( 11 ) not null auto_increment,
    log_time datetime default '0000-00-00 00:00:00' not null,
    guild_id int( 5 ) not null,
    guild_name varchar( 32 ) not null,
    master_name varchar( 32 ) not null,
    member_cnt int( 2 ) not null default '0',
    level int( 2 ),
    point int( 10 ),
    member_level int( 2 ),
    primary key( id )
    );"
    echo "$statistic_guild_svr" >> $SQL
    #snap_svr_#
    snap_svr="create table snap_svr_$ServerID
    (
    id int( 11 ) default null auto_increment,
    log_time datetime default '0000-00-00 00:00:00' not null,
    log_id tinyint( 2 ) not null default 0,
    field_1 int( 11 ) default NULL,
    field_2 int( 11 ) default NULL,
    field_3 int( 11 ) default NULL,
    primary key( id )
    );"
    echo "$snap_svr" >> $SQL
    
    #snap_text_svr_#
    snap_text_svr="create table snap_text_svr_$ServerID(
    id int( 11 ) not null auto_increment,
    log_time datetime default '0000-00-00 00:00:00' not null,
    log_id tinyint( 2 ) not null default 0,
    text_field varchar( 32 ),
    field_1 int( 11 ) default NULL,
    field_2 int( 11 ) default NULL,
    field_3 int( 11 ) default NULL,
    primary key( id )
    );"
    echo "$snap_text_svr" >> $SQL

    #char_event_svr_#
    char_event_svr="create table char_event_svr_$ServerID
    (
    id int( 11 ) default null auto_increment,
    log_time datetime not null default '0000-00-00 00:00:00',
    log_id tinyint( 2 ) not null default 0,
    ip_addr varchar(30) NOT NULL default '',
    acc_uid int( 11 ) not null default 0,
    acc_name varchar( 32 ),
    acc_sex tinyint( 1 ) not null default 0,
    acc_region tinyint( 2 ) not null default 0,
    acc_age tinyint( 2 ) not null default 0,
    acc_auth tinyint( 2 ) not null default 0,
    char_uid int( 11 ) not null default 0,
    char_name varchar( 32 ),
    char_job tinyint( 1 ) not null default 0,
    char_level int( 3 ) not null default 0,
    char_pos_x int( 5 ) not null default 0,
    char_pos_y int( 5 ) not null default 0,
    world tinyint( 2 ),
    region int( 3 ),
    type int( 3 ) not null default 0,
    time int( 11 ) not null default 0,
    primary key( id )
    );"
    echo "$char_event_svr" >> $SQL
    
    #char_die_svr_#
    char_die_svr="create table char_die_svr_$ServerID(
    id int( 11 ) not null,
    killer_uid int( 11 ) not null,
    killer_name varchar( 32 ) default '',
    killer_job tinyint( 2 ) not null,
    killer_level int( 3 ),
    primary key( id )
    );"
    echo "$char_die_svr" >> $SQL

    #char_item_svr_#
    char_item_svr="create table char_item_svr_$ServerID
    (
    id int( 11 ) default null auto_increment,
    char_uid int( 11 ) not null default 0,
    char_name varchar(32) not null,
    char_job tinyint( 2 ),
    char_level int( 3 ) not null default 0,
    item_serial int( 10 ) not null,
    item_id int( 5 ) unsigned,
    item_level int( 3 ) unsigned,
    item_kind int( 3 ) unsigned,
    item_att_0 int( 5 ) unsigned,
    item_att_1 int( 5 ) unsigned,
    item_att_2 int( 5 ) unsigned,
    item_att_3 int( 5 ) unsigned,
    item_price int( 11 ) not null default 0,
    primary key( id )
    );"
    echo "$char_item_svr" >> $SQL
    
    #char_operator_svr_#
    char_operator_svr="create table char_operator_svr_$ServerID
    (
    id int( 11 ) not null auto_increment,
    command varchar( 64 ),
    primary key( id )
    );"
    
    echo "$char_operator_svr" >> $SQL
    
    #char_job_level_svr_#
    char_job_level_svr="create table char_job_level_svr_$ServerID(
    id int( 11 ) not null,
    job_id int( 5 ) not null,
    job_level int( 5 ) not null,
    primary key( id )
    );"
    echo "$char_job_level_svr" >> $SQL

    #char_return_svr_#
    char_return_svr="create table char_return_svr_$ServerID(
    id int( 11 ) not null,
    from_x int( 10 ) not null,
    from_y int( 10 ) not null,
    world tinyint( 2 ),
    region int( 3 ),
    primary key( id )
    );"
    echo "$char_return_svr" >> $SQL

    #char_quest_svr_#
    char_quest_svr="create table char_quest_svr_$ServerID
    (
    id int( 11 ) not null,
    quest_id int( 5 ) not null,
    share_char_uid int( 10 ) not null,
    share_char_name varchar( 32 ) not null,
    primary key( id )
    );"
    echo "$char_quest_svr" >> $SQL

    #char_ship_svr_#
    char_ship_svr="create table char_ship_svr_$ServerID
    (
    id int( 11 ) not null,
    ship_uid int( 11 ) not null,
    ship_tid int( 5 ) not null,
    ship_level int( 3 ) not null,
    ship_name varchar( 32 ) not null,
    target_char_uid int( 10 ) not null,
    target_char_name varchar( 32 ) not null default '',
    target_char_job tinyint( 2 ) not null,
    target_char_level int( 3 ) not null,
    target_ship_uid int( 11 ),
    target_ship_tid int( 5 ),
    target_ship_level int( 5 ),
    target_ship_name varchar( 32 ),
    primary key( id )
    );"
    echo "$char_ship_svr" >> $SQL

    #char_skill_svr_#
    char_skill_svr="create table char_skill_svr_$ServerID
    (
    id int( 11 ) not null,
    skill_id int( 5 ) not null,
    skill_level int( 5 ) not null,
    primary key( id )
    );"
    echo "$char_skill_svr" >> $SQL
    #----------------------------------------------------------------------------
    if [ -x $PWD ] ; then
	CMD="/usr/local/mysql/bin/mysql -u$USER -h$HOSTNAME";
    else
	CMD="/usr/local/mysql/bin/mysql -u$USER -p$PWD -h$HOSTNAME";
    fi

    $CMD < $SQL

    #rm -rf $SQL
fi
