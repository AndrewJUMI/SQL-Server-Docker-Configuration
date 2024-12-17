#!/bin/bash

# Wait for SQL Server to start
echo "Waiting for SQL Server to start..."
until /opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U SA -P Password123 -Q "SELECT 1" > /dev/null 2>&1; do
    echo "Waiting for SQL Server to start (part 2)..."
    sleep 1
done

echo "SQL Server is up and running."

# Restore the database from the backup
echo "Restoring the database..."

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Password123 -Q "
RESTORE DATABASE HETRONIC_Test 
FROM DISK = '/tmp/test.bak'
WITH MOVE 'HETRONIC' TO '/tmp/HetronicSQLTest.mdf',
MOVE 'HETRONIC_log' TO '/tmp/HetronicSQLTest_log.ldf';
GO
"
echo "Database restored successfully."

