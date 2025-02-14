#!/bin/bash
# SQL Server をバックグラウンドで起動
/opt/mssql/bin/sqlservr &

# SQL Server の起動完了を待つ
sleep 30

# 初回起動の場合のみ install.sql を実行
if [ ! -f /var/opt/mssql/backup/database_initialized ]; then
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P "${MSSQL_SA_PASSWORD}" -C -i /usr/src/app/install_adventureworks.sql
    # マーカーとなるファイルを作成
    touch /var/opt/mssql/backup/database_initialized
fi

# フォアグラウンドで待機
wait