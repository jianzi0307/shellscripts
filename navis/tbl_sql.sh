#!/bin/sh
#==========================================================================================
#�ɼ��� �о���δ�.
#==========================================================================================
echo -n "Input Type(0:all, 1:item, 2:job, 3:skill, 4:quest, 5:ship, 6:region, 7:npc, 8:attr) : "
read type

#==========================================================================================
#�⺻ ȯ���� ���� �� �ʱ�ȭ �Ѵ�.
#==========================================================================================
#FPATH="/home/redwing/navis/config/world000/"
FPATH=""

#��� ���� �̸�
SQL_NAME="insert_table.sql"

#��� �̸�
DB_NAME="navis_log"

#�ϴ� ���Ϸ� �����
echo "use $DB_NAME;" > $SQL_NAME
#==========================================================================================

#==========================================================================================
#��� ���̺��� ���� ��Ų��.
#==========================================================================================
create_item="
create table game_item_table(
id int( 10 ) unsigned not null,
name_en varchar( 32 ) not null default 0,
name_ko varchar( 32 ) not null default 0,
name_ch varchar( 32 ) default 0,
job_kind tinyint( 2 ) not null default 0,
limit_level tinyint( 3 ) default 0,
primary key( id )
);"

create_job="
create table game_job_table(
id int( 10 ) unsigned auto_increment not null,
job_id int( 10 ) unsigned,
name_en varchar( 32 ) not null default 0,
name_ko varchar( 32 ) not null default 0,
name_ch varchar( 32 ) default 0,
job_kind tinyint( 2 ) not null default 0,
primary key( id )
);"

create_skill="
create table game_skill_table(
id int( 10 ) unsigned not null,
name_en varchar( 32 ) not null default 0,
name_ko varchar( 32 ) not null default 0,
name_ch varchar( 32 ) default 0,
char_limit_level tinyint( 3 ) default 0,
skill_limit_level tinyint( 3 ) default 0,
job_kind tinyint( 2 ) not null default 0,
primary key( id )
);"

create_quest="
create table game_quest_table(
id int( 10 ) unsigned not null,
name_en varchar( 128 ) not null default 0,
name_ko varchar( 128 ) not null default 0,
name_ch varchar( 128 ) default 0,
type int( 2 ) default 0,
primary key( id )
);"

create_ship="
create table game_ship_table(
id int( 10 ) unsigned not null,
name_en varchar( 32 ) not null default 0,
name_ko varchar( 32 ) not null default 0,
name_ch varchar( 32 ) default 0,
type tinyint( 2 ) default 0,
primary key( id )
);"

create_region="
create table game_region_table(
id int( 5 ) unsigned auto_increment not null,
region_id int( 3 ),
world_id tinyint( 2 ),
region_name_en varchar( 32 ) not null default 0,
region_name_ko varchar( 32 ) not null default 0,
region_name_ch varchar( 32 ) default 0,
primary key( id )
);"

create_npc="
create table game_npc_table(
id int( 5 ) not null,
name_en varchar( 32 ) not null default 0,
name_ko varchar( 32 ) not null default 0,
name_ch varchar( 32 ) default 0,
primary key( id )
);"

create_attr="
create table game_attr_table(
id int( 5 ) not null,
attr_ko varchar( 32 ) not null default 0,
attr_ch varchar( 32 ) not null default 0,
primary key( id )
);"
#==========================================================================================

#==========================================================================================
#�ɼǿ� ���� �����̸��� ���� �Ѵ�.
#==========================================================================================
#�޾ƿ� Ÿ�Կ� ���� �� �׸��� �н��� �����Ѵ�.
if [ $type == "0" ]; then
    ITEM=$FPATH"itbl_item.txt";
    JOB=$FPAHT"string_job_0.txt";
    SKILL=$FPATH"string_m_skill_0.txt";
    QUEST=$FPATH"string_questlist_0.txt";
    SHIP=$FPATH"string_shipinfo_0.txt";
    REGION=$FPATH"string_region000_0.txt";
    NPC=$FPATH"string_npc_0.txt";
elif [ $type == "1" ]; then
    ITEM=$FPATH"itbl_item.txt";
elif [ $type == "2" ]; then
    JOB=$FPAHT"string_job_0.txt";
elif [ $type == "3" ]; then
    SKILL=$FPATH"string_m_skill_0.txt";
elif [ $type == "4" ]; then
    QUEST=$FPATH"string_questlist_0.txt";
elif [ $type == "5" ]; then
    SHIP=$FPATH"string_shipinfo_0.txt";
elif [ $type == "6" ]; then
    REGION=$FPATH"string_region000_0.txt";
elif [ $type == "7" ]; then
    NPC=$FPATH"string_npc_0.txt";
elif [ $type == "8" ]; then
    ATTR=$FPATH"string_attrlist_0.txt";
fi

#if  [ -f  /var/run/confirm]	�ش� ������ �ִ��� üũ�Ѵ�.
#==========================================================================================

#echo "ITEM = $ITEM, JOB=$JOB, SKILL=$SKILL, QUEST=$QUEST, SHIP=$SHIP"

#==========================================================================================
#�ϴ� ������ ���ϵ��� �ִ����� ���� üũ����. ������ ������ ���� �ߴ�!!!
#itbl_item.txt, jtbl_item.txt, ship_shipitem.txt, string_item_1.txt, string_item_sub_1.txt, string_shipitem_1.txt
#string_job_0.txt, string_job_sub_0.txt, string_job_1.txt, string_job_sub_1.txt
#string_m_skill_0.txt, string_m_sub_skill_0.txt, string_m_skill_1.txt, string_m_sub_skill_1.txt, stbl_m_skill.txt, jtbl_m_skill.txt
#string_questlist_0.txt, string_questlist_1.txt, questlist.txt
#string_shipinfo_0.txt, string_shipinfo_1.txt, ship_shipinfo.txt
#string_region000_0.txt, string_region000_1.txt, string_region001_0.txt, string_region001_1.txt
#string_npc_0.txt, string_npc_1.txt

#itbl_item.txt, jtbl_item.txt, ship_shipitem.txt, string_item_1.txt, string_item_sub_1.txt, string_shipitem_1.txt
if [ -f $FPATH"itbl_item.txt" ]; then
    echo "itbl_item.txt ���� üũ[O]"
else
    echo "itbl_item.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"jtbl_item.txt" ]; then
    echo "jtbl_item.txt ���� üũ[O]"
else
    echo "jtbl_item.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"ship_shipitem.txt" ]; then 
    echo "ship_shipitem.txt ���� üũ[O]"
else
    echo "ship_shipitem.txt ���� üũ[X]"
    exit 0; 
fi

if [ -f $FPATH"string_item_1.txt" ]; then
    echo "string_item_1.txt ���� üũ[O]"
else
    echo "string_item_1.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_item_sub_1.txt" ]; then
    echo "string_item_sub_1.txt ���� üũ[O]"
else
    echo "string_item_sub_1.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_shipitem_1.txt" ]; then
    echo "string_shipitem_1.txt ���� üũ[O]"
else
    echo "string_shipitem_1.txt ���� üũ[X]"
    exit 0;
fi

#string_job_0.txt, string_job_sub_0.txt, string_job_1.txt, string_job_sub_1.txt
if [ -f $FPATH"string_job_0.txt" ]; then
    echo "string_job_0.txt ���� üũ[O]"
else
    echo "string_job_0.txt ���� üũ[X]"
    exit 0;
fi
if [ -f $FPATH"string_job_sub_0.txt" ]; then
    echo "string_job_sub_0.txt ���� üũ[O]"
else
    echo "string_job_sub_0.txt ���� üũ[X]"
    exit 0;
fi
if [ -f $FPATH"string_job_1.txt" ]; then
    echo "string_job_1.txt ���� üũ[O]"
else
    echo "string_job_1.txt ���� üũ[X]"
    exit 0;
fi 
if [ -f $FPATH"string_job_sub_1.txt" ]; then
    echo "string_job_sub_1.txt ���� üũ[O]"
else
    echo "string_job_sub_1.txt ���� üũ[X]"
    exit 0;
fi

#string_m_skill_0.txt, string_m_sub_skill_0.txt, string_m_skill_1.txt, string_m_sub_skill_1.txt, stbl_m_skill.txt, jtbl_m_skill.txt
if [ -f $FPATH"string_m_skill_0.txt" ]; then
    echo "string_m_skill_0.txt ���� üũ[O]"
else
    echo "string_m_skill_0.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_m_sub_skill_0.txt" ]; then
    echo "string_m_sub_skill_0.txt ���� üũ[O]"
else
    echo "string_m_sub_skill_0.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_m_skill_1.txt" ]; then
    echo "string_m_skill_1.txt ���� üũ[O]"
else
    echo "string_m_skill_1.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_m_sub_skill_1.txt" ]; then
    echo "string_m_sub_skill_1.txt ���� üũ[O]"
else
    echo "string_m_sub_skill_1.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"stbl_m_skill.txt" ]; then
    echo "stbl_m_skill.txt ���� üũ[O]"
else
    echo "stbl_m_skill.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"jtbl_m_skill.txt" ]; then
    echo "jtbl_m_skill.txt ���� üũ[O]"
else
    echo "jtbl_m_skill.txt ���� üũ[X]"
    exit 0;
fi

#string_questlist_0.txt, string_questlist_1.txt, questlist.txt

if [ -f $FPATH"string_questlist_0.txt" ]; then
    echo "string_questlist_0.txt ���� üũ[O]"
else
    echo "string_questlist_0.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_questlist_1.txt" ]; then
    echo "string_questlist_1.txt ���� üũ[O]"
else
    echo "string_questlist_1.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"questlist.txt" ]; then
    echo "questlist.txt ���� üũ[O]"
else
    echo "questlist.txt ���� üũ[X]"
    exit 0;
fi

#string_shipinfo_0.txt, string_shipinfo_1.txt, ship_shipinfo.txt

if [ -f $FPATH"string_shipinfo_0.txt" ]; then
    echo "string_shipinfo_0.txt ���� üũ[O]"
else
    echo "string_shipinfo_0.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_shipinfo_1.txt" ]; then
    echo "string_shipinfo_1.txt ���� üũ[O]"
else
    echo "string_shipinfo_1.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"ship_shipinfo.txt" ]; then
    echo "ship_shipinfo.txt ���� üũ[O]"
else
    echo "ship_shipinfo.txt ���� üũ[X]"
    exit 0;
fi

#string_region000_0.txt, string_region000_1.txt, string_region001_0.txt, string_region001_1.txt

if [ -f $FPATH"string_region000_0.txt" ]; then
    echo "string_region000_0.txt ���� üũ[O]"
else
    echo "string_region000_0.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_region000_1.txt" ]; then
    echo "string_region000_1.txt ���� üũ[O]"
else
    echo "string_region000_1.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_region001_0.txt" ]; then
    echo "string_region001_0.txt ���� üũ[O]"
else
    echo "string_region001_0.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_region001_1.txt" ]; then
    echo "string_region001_1.txt ���� üũ[O]"
else
    echo "string_region001_1.txt ���� üũ[X]"
    exit 0;
fi

#string_npc_0.txt, string_npc_1.txt

if [ -f $FPATH"string_npc_0.txt" ]; then
    echo "string_npc_0.txt ���� üũ[O]"
else
    echo "string_npc_0.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_npc_1.txt" ]; then
    echo "string_npc_1.txt ���� üũ[O]"
else
    echo "string_npc_1.txt ���� üũ[X]"
    exit 0;
fi

#string_npc_0.txt, string_npc_1.txt

if [ -f $FPATH"string_attrlist_0.txt" ]; then
    echo "string_attrlist_0.txt ���� üũ[O]"
else
    echo "string_attrlist_0.txt ���� üũ[X]"
    exit 0;
fi

if [ -f $FPATH"string_attrlist_1.txt" ]; then
    echo "string_attrlist_1.txt ���� üũ[O]"
else
    echo "string_attrlist_1.txt ���� üũ[X]"
    exit 0;
fi

#==========================================================================================
#������ ���� sql���� �����.
#�䱸 ���� ����Ʈ
#1. itbl_item.txt
#2. jtbl_item.txt
#3. ship_shipitem.txt	    ������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#4. string_item_1.txt	    ������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#5. string_item_sub_1.txt   ������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#6. string_shipitem_1.txt   ������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#==========================================================================================
if [ $ITEM ]; then
    echo "drop table game_item_table;" >> $SQL_NAME
    echo $create_item >> $SQL_NAME
    echo "---------------------------------------------------------"
    echo "itbl_item.txt�� �������� �����."
    echo "---------------------------------------------------------"
    #���� ������ �о insert ���� �����.
    #=======================================================
    #���⿡�� ����� �ѱ��� �Է� �Ѵ�.
    echo "--itbl_item.txt�� �������� �����." >> $SQL_NAME
    CMD="cat "$ITEM;
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_item_table (id, name_en, name_ko, job_kind, limit_level) values (\""$1"\"" ",\""$2"\"" ",\""$2"\"" ",\""1"\"" ",\""$10"\");"
    }' >> $SQL_NAME;
    echo "---------------------------------------------------------"
    echo "jtbl_item.txt�� �������� �����."
    echo "---------------------------------------------------------"
    echo "--jtbl_item.txt�� �������� �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"jtbl_item.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_item_table (id, name_en, name_ko, job_kind, limit_level) values (\""$1"\"" ",\""$2"\"" ",\""$2"\"" ",\""2"\"" ",\""$10"\");"
    }' >> $SQL_NAME;
    echo "---------------------------------------------------------"
    echo "ship_shipitem.txt�� �������� �����."
    echo "---------------------------------------------------------"
    echo "--ship_shipitem.txt�� �������� �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"ship_shipitem.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_item_table (id, name_en, name_ko, job_kind, limit_level) values (\""$1"\"" ",\""$2"\"" ",\""$2"\"" ",\""3"\"" ",\""$10"\");"
    }' >> $SQL_NAME;   
    #=======================================================
    #�� ������ ������ ��Ʈ���� �о� ������Ʈ �Ѵ�.(���� ��� ���� ������ �߱�� ������Ʈ �Ѵ�.)
    echo "---------------------------------------------------------"
    echo "string_item_1.txt�� �߱�� ������Ʈ �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--string_item_1.txt�� �߱�� ������Ʈ �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_item_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_item_table set name_ch=\""$3"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_item_sub_1.txt�� �߱�� ������Ʈ �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--string_item_sub_1.txt�� �߱�� ������Ʈ �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_item_sub_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_item_table set name_ch=\""$3"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_shipitem_1.txt�� �߱�� ������Ʈ �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--string_shipitem_1.txt�� �߱�� ������Ʈ �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_shipitem_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_item_table set name_ch=\""$3"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 

fi
#==========================================================================================
#���� ���� sql���� �����.
#�䱸 ���� ����Ʈ
#1. string_job_0.txt	    ������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#2. string_job_sub_0.txt    ������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#3. string_job_1.txt	    ������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#4. string_job_sub_1.txt    ������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#==========================================================================================
if [ $JOB ]; then
    echo "drop table game_job_table;" >> $SQL_NAME
    echo $create_job >> $SQL_NAME
    echo "---------------------------------------------------------"
    echo "string_job_0.txt�� ������ �����."
    echo "---------------------------------------------------------"
    echo "--string_job_0.txt�� ������ �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_job_0.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_job_table (job_id, name_en, name_ko, job_kind) values (\""$1"\"" ",\""$2"\"" ",\""$3"\"" ",\""1"\");"
    }' >> $SQL_NAME; 
    echo "---------------------------------------------------------"
    echo "string_job_sub_0.txt�� ������ �����."
    echo "---------------------------------------------------------"
    echo "--string_job_sub_0.txt�� ������ �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_job_sub_0.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_job_table (job_id, name_en, name_ko, job_kind) values (\""$1"\"" ",\""$2"\"" ",\""$3"\"" ",\""2"\");"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_job_1.txt�� �߱��� ������Ʈ�� �Ѵ�.."
    echo "---------------------------------------------------------"
    echo "--string_job_1.txt�� �߱��� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_job_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_job_table set name_ch=\""$3"\"" " where id=\""$1"\"" "and job_kind=\""1"\";"
    }' >> $SQL_NAME; 
    echo "---------------------------------------------------------"
    echo "string_job_sub_1.txt�� �߱��� ������Ʈ�� �Ѵ�.."
    echo "---------------------------------------------------------"
    echo "--string_job_sub_1.txt�� �߱��� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_job_sub_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_job_table set name_ch=\""$3"\"" " where id=\""$1"\"" "and job_kind=\""2"\";"
    }' >> $SQL_NAME; 

fi
#==========================================================================================
#��ų ���� sql���� �����.
#�䱸 ���� ����Ʈ
#1. string_m_skill_0.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#2. string_m_sub_skill_0.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#3. string_m_skill_1.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#4. string_m_sub_skill_1.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#5. stbl_m_skill.txt
#6. jtbl_m_skill.txt
#==========================================================================================
if [ $SKILL ]; then
    echo "drop table game_skill_table;" >> $SQL_NAME
    echo $create_skill >> $SQL_NAME
    
    echo "---------------------------------------------------------"
    echo "string_m_skill_0.txt�� ��ų�� �����."
    echo "---------------------------------------------------------"
    echo "--string_m_skill_0.txt�� ��ų�� �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_m_skill_0.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_skill_table (id, name_en, name_ko, job_kind) values (\""$1"\"" ",\""$2"\"" ",\""$3"\"" ",\""1"\");"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_m_sub_skill_0.txt�� ��ų�� �����."
    echo "---------------------------------------------------------"
    echo "--string_m_sub_skill_0.txt�� ��ų�� �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_m_sub_skill_0.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_skill_table (id, name_en, name_ko, job_kind) values (\""$1"\"" ",\""$2"\"" ",\""$3"\"" ",\""2"\");"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_m_skill_1.txt�� �߱��� ������Ʈ�� �Ѵ�.."
    echo "---------------------------------------------------------"
    echo "--string_m_skill_1.txt�� �߱��� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_m_skill_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_skill_table set name_ch=\""$3"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_m_sub_skill_1.txt�� �߱��� ������Ʈ�� �Ѵ�.."
    echo "---------------------------------------------------------"
    echo "--string_m_sub_skill_1.txt�� �߱��� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_m_sub_skill_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_skill_table set name_ch=\""$3"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "stbl_m_skill.txt�� ���淹���� �ʱ� ��ų ������ ������Ʈ�� �Ѵ�.."
    echo "---------------------------------------------------------"
    echo "--stbl_m_skill.txt�� ���淹���� �ʱ� ��ų ������ ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"stbl_m_skill.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_skill_table set char_limit_level=\""$32"\"" ", skill_limit_level=\""$40"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "jtbl_m_skill.txt�� ���淹���� �ʱ� ��ų ������ ������Ʈ�� �Ѵ�.."
    echo "---------------------------------------------------------"
    echo "--jtbl_m_skill.txt�� ���淹���� �ʱ� ��ų ������ ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"jtbl_m_skill.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_skill_table set char_limit_level=\""$32"\"" ", skill_limit_level=\""$40"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 

fi
#==========================================================================================
#����Ʈ ���� sql���� �����.
#�䱸 ���� ����Ʈ
#1. string_questlist_0.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#2. string_questlist_1.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#3. questlist.txt
#==========================================================================================
if [ $QUEST ]; then
    echo "drop table game_quest_table;" >> $SQL_NAME
    echo $create_quest >> $SQL_NAME
    echo "---------------------------------------------------------"
    echo "string_questlist_0.txt�� ����Ʈ�� �����."
    echo "---------------------------------------------------------"
    echo "--string_questlist_0.txt�� ����Ʈ�� �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_questlist_0.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_quest_table (id, name_en, name_ko) values (\""$1"\"" ",\""$2"\"" ",\""$2"\");"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_questlist_1.txt�� �߱��� ������Ʈ�� �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--string_questlist_1.txt�� �߱��� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_questlist_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_quest_table set name_ch=\""$2"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "questlist.txt�� Ÿ���� ������Ʈ�� �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--questlist.txt�� Ÿ���� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"questlist.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_quest_table set type=\""$8"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 

fi
#==========================================================================================
#�� ���� sql���� �����.
#�䱸 ���� ����Ʈ
#1. string_shipinfo_0.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#2. string_shipinfo_1.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#3. ship_shipinfo.txt
#==========================================================================================
if [ $SHIP ]; then
    echo "drop table game_ship_table;" >> $SQL_NAME
    echo $create_ship >> $SQL_NAME
    echo "---------------------------------------------------------"
    echo "string_shipinfo_0.txt�� �Լ��� �����."
    echo "---------------------------------------------------------"
    echo "--string_shipinfo_0.txt�� �Լ��� �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_shipinfo_0.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_ship_table (id, name_en, name_ko) values (\""$1"\"" ",\""$3"\"" ",\""$3"\");"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_shipinfo_1.txt�� �߱��� ������Ʈ�� �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--string_shipinfo_1.txt�� �߱��� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_shipinfo_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_ship_table set name_ch=\""$3"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "ship_shipinfo.txt�� Ÿ���� ������Ʈ�� �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--ship_shipinfo.txt�� Ÿ���� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"ship_shipinfo.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_ship_table set type=\""$4"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 
fi

#==========================================================================================
#���� ���� sql���� �����.
#�䱸 ���� ����Ʈ
#1. string_region000_0.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#2. string_region000_1.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#3. string_region001_0.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#4. string_region001_1.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#==========================================================================================
if [ $REGION ]; then
    echo "drop table game_region_table;" >> $SQL_NAME
    echo $create_region >> $SQL_NAME
    echo "---------------------------------------------------------"
    echo "string_region000_0.txt�� ������ �����."
    echo "---------------------------------------------------------"
    echo "--string_region000_0.txt�� ������ �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_region000_0.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_region_table (region_id, world_id, region_name_en, region_name_ko) values (\""$1"\"" ",\""0"\"" ",\""$2"\"" ",\""$3"\");"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_region001_0.txt�� ������ �����."
    echo "---------------------------------------------------------"
    echo "--string_region001_0.txt�� ������ �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_region001_0.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_region_table (region_id, world_id, region_name_en, region_name_ko) values (\""$1"\"" ",\""1"\"" ",\""$2"\"" ",\""$3"\");"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_region000_1.txt�� �߱��� ������Ʈ�� �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--string_region000_1.txt�� �߱��� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_region000_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_region_table set region_name_ch=\""$3"\"" " where region_id=\""$1"\"" " and world_id=\""0"\";"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_region001_1.txt�� �߱��� ������Ʈ�� �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--string_region001_1.txt�� �߱��� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_region001_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_region_table set region_name_ch=\""$3"\"" " where region_id=\""$1"\"" " and world_id=\""1"\";"
    }' >> $SQL_NAME; 
fi

#==========================================================================================
#npc ���� sql���� �����.
#�䱸 ���� ����Ʈ
#1. string_npc_0.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#2. string_npc_1.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#==========================================================================================
if [ $NPC ]; then
    echo "drop table game_npc_table;" >> $SQL_NAME
    echo $create_npc >> $SQL_NAME
    echo "---------------------------------------------------------"
    echo "string_npc_0.txt�� npc�� �����."
    echo "---------------------------------------------------------"
    echo "--string_npc_0.txt�� npc�� �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_npc_0.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_npc_table (id, name_en, name_ko) values (\""$1"\"" ",\""$2$3"\"" ",\""$4$5"\");"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_npc_1.txt�� �߱��� ������Ʈ�� �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--string_npc_1.txt�� �߱��� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_npc_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_npc_table set name_ch=\""$4$5"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 
fi

#==========================================================================================
#attr ���� sql���� �����.
#�䱸 ���� ����Ʈ
#1. string_attrlist_0.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#2. string_attrlist_1.txt	������ ���� �����̹Ƿ� Ŭ���̾�Ʈ���� ī���ؼ� �����
#==========================================================================================
if [ $ATTR ]; then
    echo "drop table game_attr_table;" >> $SQL_NAME
    echo $create_attr >> $SQL_NAME
    echo "---------------------------------------------------------"
    echo "string_attrlist_0.txt�� npc�� �����."
    echo "---------------------------------------------------------"
    echo "--string_attrlist_0.txt�� npc�� �����." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_attrlist_0.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "insert into game_attr_table (id, attr_ko) values (\""$1"\"" ",\""$4"\");"
    }' >> $SQL_NAME; 

    echo "---------------------------------------------------------"
    echo "string_attrlist_1.txt�� �߱��� ������Ʈ�� �Ѵ�."
    echo "---------------------------------------------------------"
    echo "--string_attrlist_1.txt�� �߱��� ������Ʈ�� �Ѵ�." >> $SQL_NAME
    ITEM="";
    CMD="";
    ITEM=$FPATH"string_attrlist_1.txt";
    CMD="cat $ITEM";
    $CMD | awk -F "\t" '($1 !~ /#/) { 
	print "update game_attr_table set attr_ch=\""$4"\"" " where id=\""$1"\";"
    }' >> $SQL_NAME; 
fi
