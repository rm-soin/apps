#! /bin/bash
server_name=$HOSTNAME
origin=$1
dir_proc=$2
dir_node=$3
app_name=$4
cfusion=$5

#verifica si el directorio de proc existe, si no lo crea
if [ -d "$dir_proc" ];
then
        echo "Si, si existe directorio de ambiente. $dir_proc"
        chmod -R 775 "$dir_proc"
else
        echo "No, no existe directorio de ambiente $dir_proc"
        mkdir "$dir_proc"
        chmod -R 775 "$dir_proc"
fi


cd "$dir_node" || exit 1

        git checkout .

        git pull origin "$origin" |& tee "$dir_proc"/resultado_pull_"$app_name"-"$server_name".txt

	git log --since=1.day --graph  |& tee "$dir_proc"/resultado_git_"$app_name".txt
        
	grep "Merge:" "$dir_proc"/resultado_git_"$app_name".txt | head -n 1 |& tee "$dir_proc"/shamerge.txt

        sha=$(cat "$dir_proc"/shamerge.txt | cut -d ':' -f2)

        git log -m -1 --name-only --pretty="format:" "$sha" |& tee "$dir_proc"/objetos.txt

        cat  "$dir_proc"/objetos.txt | sed '/^[[:space:]]*$/d' |& tee "$dir_proc"/resultado_ObjetosModificados.txt

	if [ ! -z "$cfusion" ]
	then
		if [ "$cfusion" == "SI" ]
		then
			chmod -Rf 775 ./*
                	chown -Rf cfusion:cfusion ./*
		fi
	fi
