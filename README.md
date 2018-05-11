
## This was created to remove duplicate documents in a local directory.

Given:
A list of documents in a table on an online mysql database.
A local directory with the same documents present (other older documents will also be present, more on that later).

Output:
Remove the older documents from the directory.

### Note that the following steps will discuss what commands should be added to a file you must create, env_var.sh. A final version of the file will be shown in the end.
## Steps:
1. Obtain the online list of documents by getting the db credentials, as well as a mysql script to run a query and return documents, like so:
```
DB_URL="location_of_db"
DB_USERNAME="username"
DB_PASSWORD="password"
DB_NAME="db_name"
MYSQL_SCRIPT="script_that_returns_doc_names.sql"
```
The mysql script would look something like this:
```
SELECT file_name FROM documents;
```
This list will be stored in a txt file, specified by:
```
LIST_1_NAME_VAR=list1.txt
```
2. Obtain the list of documents from the local directory. It's a simple xargs ls command (see dir_script.sh).

This list will also be stored in a txt file.
```
LIST_2_NAME_VAR=list2.txt
```
3. Compare both lists to see what extra documents the local directory (list2) contains

4. Remove extra documents from the local directory

5. Remove generated lists


## Extra notes:
-The main script also wants to ensure that the first list comes from a mysql db, while the second is from a local directory, hence the if statements. You will also be required to add the following:
```
LIST_1_TYPE_VAR=mysql
LIST_2_TYPE_VAR=dir
```

-There are three main directories, scripts (that store db and dir list generators), docs (where local documents are present), and lists (which is where the lists will be created).


## The final env_var.sh should like like so:

```
#! /bin/bash

SCRIPTS_DIR=./scripts
LISTS_DIR=./lists
DOCS_DIR=./docs

DB_URL="location_of_db"
DB_USERNAME="username"
DB_PASSWORD="password"
DB_NAME="db_name"
MYSQL_SCRIPT="script_that_returns_doc_names.sql"
LIST_1_TYPE_VAR=mysql
LIST_1_NAME_VAR=list1.txt

LIST_2_TYPE_VAR=dir
LIST_2_NAME_VAR=list2.txt

OUTPUT_LIST_VAR=output.txt
```

# Other notes
Some work should be done to make the code more generic, as well as minor fixes here and there.
