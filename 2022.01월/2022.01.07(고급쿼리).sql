>- 다중행 함수  
 -group by  
 -sum, avg ,max, min, count

null 처리하는 방법
>- ifnull : 데이터가 nul인 행에 임의 데이터를 넣는것  
***(데이터를 update하는것이 아님)      
-ifnull은 데이터베이스 마다 입력하는것이 다름
>- ifnull(컬럼, null을 대체할 값을 입력)은 ##select절에 오는 것   
<-> is (not) null은 where 절에 오는 코드  
------
ex)
select   
ename,  
ifnull(comm,100)  
from emp   

#####DATE_FORMAT#####
>- 날짜 함수  (구글링으로 date_format 치면 함수 나옴)
>- date_Format(날짜로 되어 있는 컬럼명)(##select절에 옴)  
-select    
date_format(hiredate, '%Y(연도,대문자 구분)-(연도와 월을 구분하는 기호)%m(월,소문자 구분')     
-from    
emp   
>- date_format(hiredate '%Y-%m) = 1996-01  
>- date_format(hiredate,'%Y/%m) = 1996/01
>- date_format(hiredate,'%Y-%M) = 1996-December  
--------ex)  
-select  
date_format(hiredate,'%Y/%m')  
-from emp   
>- date_Format을 활용한 그룹핑 방법   
--------ex)  년도별(group by) 입사한 사원 수 조회  
-select  
count(*),  
date_format(hiredate, '%Y')  
-from emp  
-group by date_format(hiredate, '%y')    
>- date_format은 <, >, <= >=, =, !=(관계연산자)와 같이 사용 될 수 있다.  
이때는 where에 온다.   
---------ex) 1983년 이후 입사한 사원의 보너스가 null이면 100 주고,  
사원의 이름과 부서이름 직업을 조회하시오.  
-select     
e.ename,  
d.dname,  
e.job,  
ifnull(comm, 100),  
e.hiredate,  
date_format(e.hiredate, '%Y')  
-from  
emp as e  
-join   
dept as d   
-on  
e.deptno = d.DEPTNO    
-where   
date_format(e.hiredate, '%Y') >= 1983   
----------ex)응용문제  
----------1981년01월 이후 입사한 사원의 보너스가 null이면 100 주고,
사원의 이름과 부서이름 직업을 조회하시오.  
-select   
e.ename,  
d.dname,  
e.job,  
ifnull(comm, 100),  
e.hiredate,   
date_format(e.hiredate, '%Y.%m')  
-from  
emp as e  
-join  
dept as d   
-on  
e.deptno = d.DEPTNO   
-where   
date_format(e.hiredate, '%Y.%m') >= '1981-01'  
### 고급쿼리(join,  subquery...) 
- INNER JOIN : 기준 테이블과 조인 테이블 모두 데이터가 존재해야 조회됨
>- inner join을 알기전에 알아야 하는 개념.  
>1. foreign key(fk) : 두개 이상의 table에서 교집합이 되는 data(컬럼)를 의미 한다.  
ex) emp table-deptno / dept table-deptno  deptno = fk
>- 두개 이상의 테이블을 조회할때 사용.  
##단) 조회 하고자 하는 테이블 들이 관계(교집합)가 있어야함.   
-ex) emp table의 deptno 와 dept table의 deptno 처럼
>1. inner join하는 방법  
-select   
e.ename  
-from emp e, dept d   
-where e.deptno = d.deptno    
>2. ###inner join하는 방법(권장)  
-select  
 e.ename  
-from  
emp  as e  
-join  
dept as d   
-on  
e.deptno = d.deptno    
->on절은 emp table과 dept table의 교집합 인것을 입력하는 것  
>- from 절에 emp as e의 e는 emp table의 별칭(as는 별칭을 붙이는 코드)  
>- 그러므로 select절에 어느table의 컬럼을 조회 하는지 알 수 있게 하기 위해서는  
select절에서 컬럼을 칠때 e.ename 으로 친다.    
------ex)  
-select  
e.ename,  
e.sal,  
d.dname  
-from  
emp as e  
-join  
dept as d  
-on  
e.deptno = d.deptno