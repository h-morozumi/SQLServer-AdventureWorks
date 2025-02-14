# SQL Server AdventureWorks Project

This project sets up a SQL Server instance using Docker and installs the AdventureWorks2022 sample database.

## Prerequisites

- Docker installed on your machine
- Docker Compose installed

## Project Structure

```
SQLServer-AdventureWorks
├── Dockerfile
├── docker-compose.yml
├── data
│   └── docker-entrypoint.sh
├── sql
│   └── install_adventureworks.sql
└── README.md
```

## Getting Started

1. **Clone the repository** (if applicable):
   ```bash
   git clone <repository-url>
   cd my-sqlserver-adventureworks
   ```

2. **Start the SQL Server container**:
   ```bash
   docker compose up -d
   ```

3. **Access the SQL Server**:
   You can connect to the SQL Server instance using any SQL client. Use the following connection details:
   - **Server**: localhost
   - **Port**: 1433
   - **Username**: sa
   - **Password**: YourStrong!Passw0rd (or the password you set in the Dockerfile)

   ```
   /opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P ${MSSQL_SA_PASSWORD} -C
   ```

   ```sql
   USE AdventureWorks2022;
   GO
   SELECT TOP (3) BusinessEntityID, FirstName, LastName
   FROM Person.Person;
   GO
   ```


## Stopping the Containers

To stop the running containers, use:
```bash
docker compose down
```

## Building the Image, Running the Container
```
docker build -t sqlserver-adventureworks .
```

```
docker run -d -p 1433:1433 --name sqlserver-adventureworks sqlserver-adventureworks
```

## References
- [AdventureWorks サンプル データベース - SQL Server | Microsoft Learn](https://learn.microsoft.com/ja-jp/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=tsql) 
- [Release AdventureWorks sample databases · microsoft/sql-server-samples](https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks) 
- [Docker:SQL Server on Linux 用のコンテナーのインストール - SQL Server | Microsoft Learn](https://learn.microsoft.com/ja-jp/sql/linux/quickstart-install-connect-docker?view=sql-server-ver16&tabs=cli&pivots=cs1-bash) 

## License

This project is licensed under the MIT License.