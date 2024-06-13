#!/usr/bin/env sh

# Diretórios de backup  
backup_path="/home/usuario/Documentos /etc/password /teste/backup"

# Diretório para onde o backup vai
external_storage="/mnt/backup"

# formato do arquivo
date_format=$(date "=%d-%m-%Y")
final_archive="backup-$date_format.tar.gz"

# onde vai o Log
log_file="/var/log/daily-backup.log"

###################
#testes
###################
# checando se o dispositivo esta montado na maquina
if ! mountpoint -q -- $external_storage; then
    printf "[$date_format] Dispositivo não montado em: $external_storage verifique-o.\n" >> $log_file
    exit 1
fi

###################
# Inicio do backup.
###################
if tar -czSpf "$external_storage/$final_archive" "$backup_path" >> $log_file
    printf "[$date_format] Backup realizado.\n" >> $log_file
else 
    printf "[$date_format] Backup ERRO.\n" >> $log_file
fi

# uxcluir backup antigos
find $external_storage -mtime +30