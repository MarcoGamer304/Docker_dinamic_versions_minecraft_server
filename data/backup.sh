#!/bin/bash

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
echo "[$(date)] Iniciando backup..."
zip -r "/backups/world_backup_${TIMESTAMP}.zip" /server/world
echo "[$(date)] Backup creado: /backups/world_backup_${TIMESTAMP}.zip"
