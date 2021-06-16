#! /bin/bash
#nombre del server
server_name=$HOSTNAME


yarn_start=$1
dir_proc=$2
dir_node=$3
app_name=$4
#es_api=$5

cd $dir_node 

	yarn install > $dir_proc/resultado_yarn_install_$app_name_$server_name.txt

        yarn $yarn_start > $dir_proc/resultado_yarn_start_$app_name_$server_name.txt

        pm2 list > $dir_proc/resultado_pm2_list_$app_name_$server_name.txt
		
        #pm2 update > $dir_proc/resultado_pm2_update_$app_name_$server_name.txt
 
	pm2 list
#if [ $es_api == 1 ]
#then
#	pm2 scale api-core-dgme 3
#	pm2 scale api-migracion-dgme 3
#fi	
