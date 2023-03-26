# admin_backups

Make backups of your apache websites into /backups: 
- sql
- files
- certs

Crontab sample: 
```
# m h  dom mon dow   command
 15 5  *   *   *        time /root/admin_backups/backups
 10 *  *   *   *        find /backups/ -type f -mtime +30 ! -name "authorized_keys" -delete
```

# Howto
Fill mysqlpass.txt with passwords
If specific user for database is not found, fallback user is used. 

Backup user need SELECT and LOCK on every backup DB :
```
CREATE USER 'backups'@'localhost' IDENTIFIED BY 'veryStr0ngP@ssword';

GRANT SELECT, LOCK TABLES ON *.* TO 'backups'@'localhost';
FLUSH PRIVILEGES;
```

IGGY is space separated with DB to exclude. Example: 
IGGY="test information_schema"
