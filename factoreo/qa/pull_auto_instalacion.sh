#! /bin/bash
#formato para logs
fecha=$(date +%y%m%d)
hora=$(date +%H%M%S)
pull=pullrequest_"$fecha"_"$hora".log
serverRemoto=(192.168.116.4 192.168.116.6)
di_data_remoto=/home/labs/proc_auto/

#variables dentro de jenkins
#variables para pull
usuRemoto=root
serverRemoto=192.168.116.4
origin=qa-ce
dir_serverremoto=/home/labs/proc_auto/pull_pagos_ce
dir_proc=/home/labs/proc_auto/pull_pagos_ce
dir_node=/app/adobe/coldfusion2016/corePagos/wwwroot
pref_release=TramiteYa
dir_data=/wrk2/app_jenkins/Repositorios/PULL_Proyectos/tramiteya_pagos_ce
app_name=pagos_ce
cfusion=SI

echo -e "Inicio Bitacora de Instalacion\t $fecha:$hora\n" | tee $dir_data/data/resultado_bitacora.txt;
	if [ ! -z "$serverRemoto" ]
        then
		for i in "${serverRemoto[@]}";
        	do
		   server_remote=$i;
		   if [ ! -z "$cfusion" ]
		   then	
		   	ssh $usuRemoto@$server_remote "$di_data_remoto/pull_auto.sh $origin $dir_proc $dir_node $app_name $cfusion"
		   	echo -e "Se ejecuta el pull del server $server_remote\t $fecha:$hora\n" |& tee -a $dir_data/data/resultado_bitacora.txt;
		   else
			cfusion=NO
			ssh $usuRemoto@$server_remote "$di_data_remoto/pull_auto.sh $origin $dir_proc $dir_node $app_name $cfusion"
                        echo -e "Se ejecuta el pull del server $server_remote\t $fecha:$hora\n" |& tee -a $dir_data/data/resultado_bitacora.txt;
		   fi
		   if [ ! -z "$yarn_start" ]
		   then 
		   	ssh $usuRemoto@$server_remote "$di_data_remoto/yarn_auto.sh $yarn_start $dir_proc $dir_node $app_name"
                   	echo -e "Se ejecuta el yarn del server $server_remote\t $fecha:$hora\n" |& tee -a $dir_data/data/resultado_bitacora.txt;
		   fi
		done
	else
		echo -e "No se encuentra la variable server remote\t $fecha:$hora\n" |& tee -a $dir_data/data/resultado_bitacora.txt;
		exit 1
	fi
