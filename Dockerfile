FROM mcr.microsoft.com/mssql/server:2022-latest

ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=YourStrong!Passw0rd

EXPOSE 1433

# ビルド時は root で必要なディレクトリを作成し、アクセス権限を mssql ユーザーに変更
USER root
RUN mkdir -p /var/opt/mssql/backup && \
    mkdir -p /usr/src/app && \
    chown -R mssql:mssql /var/opt/mssql/backup /usr/src/app

# AdventureWorks2022.bak のダウンロード
RUN wget -O /var/opt/mssql/backup/AdventureWorks2022.bak https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak && \
    chown mssql:mssql /var/opt/mssql/backup/AdventureWorks2022.bak

# sql/install.sql をコンテナにコピー
COPY sql/install_adventureworks.sql /usr/src/app/install_adventureworks.sql
RUN chown mssql:mssql /usr/src/app/install_adventureworks.sql

# エントリポイントスクリプトをコピー
COPY /data/docker-entrypoint.sh /usr/src/app/docker-entrypoint.sh
RUN chmod +x /usr/src/app/docker-entrypoint.sh && \
    chown mssql:mssql /usr/src/app/docker-entrypoint.sh

# 実行時は非 root ユーザー (mssql) でエントリポイントスクリプトを実行
USER mssql
CMD ["/usr/src/app/docker-entrypoint.sh"]