#! /bin/bash


run_db_script() {
    mysql -h $1 -u $2 -p$3 $4 < $5
}
