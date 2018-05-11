#! /bin/bash

# environment variables
. ./env_var.sh

LIST_1_NAME=$LIST_1_NAME_VAR
LIST_1_TYPE=$LIST_1_TYPE_VAR

LIST_2_NAME=$LIST_2_NAME_VAR
LIST_2_TYPE=$LIST_2_TYPE_VAR

OUTPUT_LIST=$OUTPUT_LIST_VAR

. ./scripts/db_script.sh
. ./scripts/dir_script.sh

if [ $LIST_1_TYPE = mysql ]
    then
    run_db_script $DB_URL $DB_USERNAME $DB_PASSWORD $DB_NAME $MYSQL_SCRIPT > $LISTS_DIR/$LIST_1_NAME
fi

if [ $LIST_2_TYPE = dir ]
    then
    run_dir_script $DOCS_DIR > $LISTS_DIR/$LIST_2_NAME
fi

if [ -f $LISTS_DIR/$LIST_1_NAME ] && [ -f $LISTS_DIR/$LIST_2_NAME ]
    then
    comm -13 <(sort $LISTS_DIR/$LIST_1_NAME) <(sort $LISTS_DIR/$LIST_2_NAME) > $LISTS_DIR/temp.txt
    awk -v var="$DOCS_DIR/" '{print var $0}' $LISTS_DIR/temp.txt > $LISTS_DIR/$OUTPUT_LIST
    else
    echo lists not found!
fi

xargs -I{} rm -v {} < $LISTS_DIR/$OUTPUT_LIST

rm -rf $LISTS_DIR/*.txt
