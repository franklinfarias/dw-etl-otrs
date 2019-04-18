# dw-etl-otrs
Data Warehouse with ETL and Saiku for OTRS

## Installation

```bash
cd /opt
yum install git java-1.7.0-openjdk -y
git clone https://github.com/franklinfarias/dw-etl-otrs.git
cd saiku-server
tar -zxvf saiku-server.tar.gz
mv saiku-server /opt
chmod a+x /opt/saiku-server/*.sh
cd /opt/saiku-server/tomcat/webapps/saiku/WEB-INF/classes/
mkdir otrs-cube
cp /opt/dw-etl-otrs/mondrian-cube/mondrian-cube.xml otrs-cube/otrs-olap.xml

mysql otrs -p -e "source /opt/dw-etl-otrs/sql/script_initial_mysql.sql;"
mysql -p -e "create database otrsv6_olap;"
mysql otrsv6_olap -p -e "source /opt/dw-etl-otrs/script_olap.sql;"
mysql -p -e "grant all privileges on *.* to remote@'%';"
cd /opt/saiku-server
./start-saiku.sh
```
Access environment to url http://your_server:8080
Use following credentials: franklin.farias / 2f3a90
In the Administration Area configure the Database Datasource, following:
* OTRS OLAP
`
type=OLAP
name=otrsv6_olap
driver=mondrian.olap4j.MondrianOlap4jDriver
location=jdbc:mondrian:Jdbc=jdbc:mysql://localhost/otrsv6_olap;Catalog=res:otrs-cube/otrs-olap.xml;JdbcDrivers=com.mysql.jdbc.Driver;
username=root
password=root
security.enabled=false
`
