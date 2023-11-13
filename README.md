**This is Sonarqube community edition that is for my personal use only**
**Available to everyone [here](https://www.sonarsource.com/products/sonarqube/downloads/)**

- Run `sonar.sh start`
- [Open the UI](http://localhost:9999)

# Installation
- Installed in `/usr/local/bin/sonarqube`
- PATH defined in `~/.bash_aliases`
- User antti owns everything
- Not running as systemd service atm
- Using debians openjdk

# TODO

## WEBUI not working
- For some reason web ui is not working

## Postgresql
- Allow normal socket connection
- Configure sonarqube to use postgresql
- Hide password somehow on machine (unix socket works with delegation but normal socket wont i think)
- Create scripts to backup/restore when switching machines

## Projects
- Add AJE

# Java
```bash
sudo apt install openjdk-17-jdk

# .bash_aliases
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
```

# Path setup
```bash
# .bash_aliases add sonarqube path
export PATH=$PATH:/usr/local/bin/sonarqube/bin/linux-x86-64
```

# Starting
```bash
# start
sonar.sh start
# clean logs
sonar-clean-logs.sh
```

# creating user, role & db
```bash
# set access to sonarqube folder
sudo chown -R antti:sonar /usr/local/bin/sonarqube

# create role and db
sudo -u postgres psql -c "CREATE ROLE sonar LOGIN PASSWORD 'sonar';"
sudo -u postgres createdb -O sonar sonar
# this seems ot work fine and I can login as sonar to the db from vscode
# but sonarqube fails as elasticsearch does not work...
```

# sonar.properties
```ini
# After installation of JDK, Sonarcube & Configuration
# exec: sonar.sh start
# open: http://127.0.0.1:9000
sonar.web.javaOpts=-Xmx512m -Xms128m -XX:+HeapDumpOnOutOfMemoryError
sonar.web.host=127.0.0.1
sonar.web.port=9999
sonar.web.context=/
sonar.ce.javaOpts=-Xmx512m -Xms128m -XX:+HeapDumpOnOutOfMemoryError
sonar.search.javaOpts=-Xmx512m -Xms512m -XX:MaxDirectMemorySize=256m -XX:+HeapDumpOnOutOfMemoryError
sonar.search.port=9998

# Supported values are INFO, DEBUG and INFO
sonar.log.level=DEBUG
sonar.log.level.app=DEBUG
sonar.log.level.web=DEBUG
sonar.log.level.ce=DEBUG
sonar.log.level.es=DEBUG
sonar.path.logs=logs
sonar.log.rollingPolicy=time:yyyy-MM-dd
sonar.log.maxFiles=7
sonar.web.accessLogs.enable=true
sonar.path.data=data
sonar.path.temp=temp
sonar.telemetry.enable=false

# Database, works fine from VSCode but elasticsearch fails to start
#sonar.jdbc.username=sonar
#sonar.jdbc.password=sonar
#sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonar?currentSchema=public
``````
