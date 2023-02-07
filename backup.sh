docker compose run server-backup
#  do-backup: 
#    image: restic/restic:latest
#    command: -r /backup-repo backup /data
#    volumes:
#      - mc-server:/data
#      - mc-backup:/backup-repo
