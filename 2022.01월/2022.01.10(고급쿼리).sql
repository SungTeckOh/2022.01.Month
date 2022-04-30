join 조건 쉽게 사용하는 법(USING)
테이블끼리 관계가 없어도 두테이블 중에 데이터 타입이 같은 컬럼이면 JOIN가능! (JOIN은 데이터 타입이 중요하다!)
ex) - SELECT e.ename d.dname - FROM emp as e - JOIN dept as d ***USING (deptno) (ON 대신 USING 사용)

inner join
1.두개 이상의 테이블을조회할때
조인방법(2가지)
첫번째.
-from emp as e, dept as d
-where e.deptno = d.deptno
###두번째.
-from emp as e
inner join dept as d
on e.deptno = d.deptno
-where
##세개의 테이블을 조회할 경우
-from emp as e
inner join dept as d
on e.deptno = d.deptno
*inner join dw as dw
*on ---
.
.
.
where

join 종류
left/right outer join
inner join(내부조인 혹은 조인)
=>두 테이블을 조회할 때, 두 테이블에 모두 지정한 데이터 조회
outer join(외부조인)
=>두 테이블을 조회할 때, 1개의 테이블에만 데이터가 있어도 조회
self join(자체 조인)
=>자신이 자신과 조인, 1개의 테이블 사용
***외부조인(=outer join)(순서가 있음)

left outer join
: 왼쪽 테이블의 모든 값이 출력되는 조인
---- ex) 사원 이름하고 같이 부서 이름도 조회 바람!
단, 사원테이블에 없는 부서까지 조회 바람
select
.*
from dept as d
left join emp as e
on e.deptno = d.deptno
right outer join
: 오른쪽 테이블의 모든 값이 출력되는 조인
full outer join
: 왼쪽, 오른쪽 테이블의 모든 값이 출력
***외부조인 문법

select
(컬럼목록)
from
(첫번째 테이블 이름)
(left or RIGHT) outer(=디폴트값) join
(두번째 테이블 이름)
on
(조인 조건)
where ....

****언제 사용하는지?

대표적인 예)
쇼핑몰 사이트에서 회원가입은 했는데
구매이력이 없는 회원을 조회 할 때
--사원테이블에서 40번(dept테이블에만 있는 부서)
부서인 OPERATIONS 조회
select
-*
from emp as e (right or left) join dept as d
on e.deptno = d.deptno
right인지 left인지는 찾고자 하는것을 기준으로...

데이터 생성
insert into emp(empno, ename, job, hiredate, sal, comm)
values (8000, '손흥민', 'DEVELOPER', now(), 300, 100)
ex) ---부서번호가 없는 사원 출력
-select
.*
-from emp as e left join dept as d
on e.deptno = d.DEPTNO
-where e.deptno is null

설명) deptno가 null인 사람은 emp 테이블의 손흥민 뿐이라
from과 join을 기준으로 emp 테이블이 왼쪽에 있기때문에
left join이 되는것
*TIP(LEFT JOIN인지 RIGHT JOIN인지)

inner join 코딩.
내가 찾고자하는 테이블 위치를 확인.
left에 있는지 right에 있는지 확인 후
left를 사용할지 right를 사용할지
###self join(자체 조인)

별도의 문법이 있는 것은 아님.
inner join 문법 동일.
즉, 같은 테이블 join 할 경우(inner join 으로!)
-- 사원들의 상사 이름과 번호를 조회.
(sawon의 mgr은 boss의 empno 이므로) select
sawon.empno as '사원 번호',
sawon.ename as '사원이름',
boss.empno as '사수번호',
boss.ename as '사수이름'
from emp as sawon
join emp as boss
on sawon.mgr = boss.empno
--사수들의 사원 조회 (boss의 empno는 sawon의 mgr이므로)
select
boss.empno as '사수이름',
sawon.mgr as '사수번호',
sawon.ename as '사원이름',
sawon.empno as '사원번호'
from emp as boss
join emp as sawon
on boss.empno = sawon.mgr

***다중 조인(별칭 나누는 것 중요!)
(쿼리 순서는 첫번째join부터 순서대로 실행)

-select
(컬럼목록)
-from(테이블 별칭A)
(inner or right or left join) (테이블 별칭 B)
on (조인 조건)
(inner or right or left join) (테이블 별칭 C)
on (조인 조건)
where,group by,having,order by...
----ex)
select
.*
from emp as e
join dept as d
on e.deptno = d.DEPTNO
join emp as boss
on e.mgr = boss.empno

***서브쿼리(거의 안씀)

하나의 쿼리 문장 내에 포함된
또 하나의 쿼리
규칙
반드시 ()괄호로 묶음
->select
(select...)
from A table
서브쿼리가 먼저 실행(괄호 안에 있는 서브쿼리)된
후 외부 쿼리와 비교/연산
서브쿼리가 가능한 곳
3-1. select절(스칼라 서브쿼리)
3-2. ***from절(인라인 뷰)
3-3. where절(중첩 서브쿼리)
3-4. having
3-5. order by
3-6. insert values
3-7. update set (MYSQL에서 실행 안됨)
서브쿼리 종류
단일 서브 쿼리
다중행 서브 쿼리
delete
모델링(table을 create하는 작업)
->spring 시간에
->PK, FK작업을 모델링에서 함
테이블의 데이터타입
-> 자바 시간에
서브쿼리

----ex)
10번 부서 사람들중에
회사의 평균 급여 보다 많이 받는 사람 조회
힌트) where절에 서브쿼리
select

from emp
where
deptno = 10
and
sal >= (select avg(sal) from emp)
----ex)
사원번호가 7876인 사원과
job이 같은 사람 모두 조회
힌트 where절에 서브쿼리
select
from emp
where job = (select job from emp where empno = 7876)
01월10일문제

부서명이 RESEARCH인 사원의 이름,급여,근무 지역 출력 select e.ename, e.sal, d.LOC, d.dname from emp as e join dept as d on e.deptno = d.DEPTNO where d.dname = 'research'
보너스를 받는 사원에 대해 이름, 업무, 급여, 부서명을 출력 select e.comm, e.ename, e.job, e.SAL, d.dname from emp as e join dept as d on e.deptno=d.deptno where e.comm is not null and e.comm != 0
이름 첫글자가 A자를 가진 사원에 대해 이름, 업무, 부서명, 부서 위치를 출력 select e.ename as '이름', e.job as '업무', d.dname as '부서명', d.loc as '부서 위치' from emp as e left join dept as d on e.deptno = d.deptno where e.ename like 'A%'
###4) 사원명, 사수번호, 사수 이름을 출력 단, ***사수가 없는 사원도 포함 select sawon.ename as "사원명", sawon.mgr as '사수번호', boss.ename as '사수이름' from emp as sawon left join emp as boss on sawon.mgr = boss.empno

###5) 사원명, 사수번호, 사수 이름을 출력 단, ***사수가 없는 사원만
select sawon.ename as '사원명', sawon.mgr as '사수번호', boss.ename as '사수이름' from emp as sawon left join emp as boss on sawon.mgr = boss.empno where sawon.mgr is null

상사번호가 7698인 사원의 이름, 사원번호, 상사번호, 상사명을 출력 select sawon.ename as '사원이름', sawon.empno as '사원번호', sawon.mgr as '상사 번호', boss.ename as '상사이름' from emp as sawon join emp as boss on sawon.mgr = boss.EMPNO where sawon.mgr = 7698
상사보다 먼저 입사한 사원의 사원이름, 사원의 입사일, 상사 이름, 상사 입사일을 출력 select sawon.ename as '사원 이름', sawon.hiredate as '사원입사일', boss.ename as '상사 이름', boss.hiredate as '상사 입사일' from emp as sawon join emp as boss on sawon.hiredate < boss.hiredate
업무가 MANAGER이거나 CLERK고 입사날짜가 1982년에 입사한 사원의 사원번호, 이름, 급여, 직업, 부서명을 출력. select e.empno as '사원번호', e.ename as '사원이름', e.sal as '급여', e.job as '직업', d.dname as '부서명', date_format(e.hiredate,'%Y') from emp as e join dept as d on e.deptno = d.DEPTNO where ( e.job = 'manager' or e.job = 'clerk' ) and date_format(e.hiredate, '%Y') = 1982
부서별 급여 총합을 구하시오.
단, 사원이 ***존재하지 않는 부서도 포함해서 급여 순으로 내림차순 하시오.
select e.deptno as '부서', d.deptno as '부서', sum(e.sal) as '급여합계' from emp as e right join dept as d on e.deptno = d.DEPTNO group by e.DEPTNO, d.deptno order by e.sal asc

_ 아래 난이도 상 문제 _

사원 이름, 사원의 부서명, 상사 이름, 상사의 근무지역을 출력.
단, 사원이 존재하지 않는 부서번호와 부서명도 출력.
select
e.ename as '사원명', d.DNAME as '부서명', boss.ENAME as '상사이름', d.LOC as '근무지역' from emp as e right join dept as d on e.DEPTNO = d.DEPTNO join emp as boss on e.MGR = boss.EMPNO

부서 위치가 CHICAGO이고 사수 급여가 5000 미만인 사원 번호,사원 이름,사수 번호, 사수 이름, 사수 급여, 부서명을 출력 단, 사원의 입사날짜로 오름차순. select sawon.empno as '사원번호', sawon.ename as '사원이름', sawon.mgr as '사수번호', boss.ename as '사수이름', boss.sal as '사수급여', d.dname as '부서명' from emp as sawon join emp as boss on sawon.mgr = boss.empno join dept as d on sawon.deptno = d.DEPTNO where d.loc = 'chicago' and boss.sal < 5000 order by sawon.hiredate asc
부서이름이 sales인 사원 이름 조회 select d.dname, e.ename from emp as e join dept as d on e.deptno = d.deptno where d.dname = 'sales'

모든사원의 직업과 부서이름 조회 단, 부서가 없는 사원도 조회 select e.ename, e.job, d.dname from emp as e left join dept as d on e.deptno = d.deptno

사원이름, 사수 이름 조회 부서 번호가 20번인 사원만 select sawon.ename as '사원이름', boss.ename as '사수 이름' from emp as sawon join emp as boss on sawon.mgr = boss.empno where sawon.deptno = 20

-- ex) 사원 이름하고 같이 부서 이름도 조회 바람!
단, 사원테이블에 없는 부서까지 조회 바람
select e.ename as'사원이름', d.dname as'부서이름', d.deptno as '부서' from emp as e left join dept as d on e.deptno = d.deptno