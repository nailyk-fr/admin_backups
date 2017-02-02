# admin_backups

Make backups of your apache websites into /backups: 
- sql
- files
- certs

Crontab sample: 
```
# m h  dom mon dow   command
 15 5  *   *   *        time /root/admin_backups/backups
```

# Howto
Fill mysqlpass.txt with passwords
If specific user for database is not found, fallback user is used. 

Backup user need SELECT and LOCK on every backup DB

IGGY is space separated with DB to exclude. Example: 
IGGY="test information_schema"
