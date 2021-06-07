#### 데이터베이스(DB) 연동 ####
### 1) R <-> MySQL JDBC
# R 실행 버전 유의
# 64비트에서 실행해야 에러가 적게 남
# 첨부된 mysql-connector-java-5.1.38-bin.jar 파일을 
# 다운로드 받아서 C:\ 아래에 두세요.
install.packages("rJava")
install.packages("RJDBC")

library(rJava)
library(RJDBC)
dir()

# 데이터베이스 연결 설정
jdbcDriver <- JDBC(driverClass="com.mysql.jdbc.Driver"
                   , classPath="C://mysql-connector-java-5.1.38-bin.jar")

conn <- dbConnect(jdbcDriver, 
                  "jdbc:mysql://localhost:3306/JSPBookDB", "root", "1234")

# sql을 사용해서 r로 데이터 가져오기
r <- dbGetQuery(conn, "SELECT * FROM student")
class(r)
str(r)
r

### 2) R <-> Oracle JDBC
## scott 계정
# r 실행 버젼유의
# 64비트에서 실행해야 에러가 적게남
# 첨부된 ojdbc6.jar 파일을 다운로드 받아서 C:\ 아래에 두세요.
install.packages("rJava")
install.packages("RJDBC")

library(rJava)
library(RJDBC)  

## 데이터베이스 연결 설정
jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver"
                   , classPath="C://ojdbc6.jar")

conn <- dbConnect(jdbcDriver, 
                  "jdbc:oracle:thin:@localhost:1521/xe", "scott", "tiger")

# sql을 사용해서 r로 데이터 가져오기
r <- dbGetQuery(conn, "SELECT * FROM scott.emp")
class(r)
str(r)
r

# 거의 모든 sql문이 가능
sql <- "select deptno, count(*) as cnt  
        from scott.emp 
        group by deptno
        order by deptno"
r <- dbGetQuery(conn, sql)
r

# job_id별 salary의 합계는?
sql <- "select job, sum(sal) as sum_sal   
       from emp   group by job   
       order by job desc   "
r <- dbGetQuery(conn, sql)   
r 

## hr_view.txt 파일 연동
conn <- dbConnect(jdbcDriver, 
                  "jdbc:oracle:thin:@localhost:1521/xe", "hr", "1234")

# sql을 사용해서 r로 데이터 가져오기
v_r <- dbGetQuery(conn, "SELECT * FROM hr.v1")
class(v_r)
str(v_r)
v_r
