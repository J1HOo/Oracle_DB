-- EMPLOYEE 테이블에서 부서코드, 부서(그룹)별 급여 합계 조회
-- /* 어떤 그룹을 묶어서 조회할 것 인지를 추가 작성해줌 */ 
SELECT DEPT_CODE ,SUM(SALARY), AVG(SALARY) -- 
FROM EMPLOYEE
GROUP BY DEPT_CODE; --DEPT_CODE 컬럼 값이 같은 행들끼리 묶어서



-- 1. EMPLOYEE 테이블에서 부서코드가 'D5', 'D6'인 부서의 평균 급여 조회
SELECT DEPT_CODE, -- 부서 코드
       AVG(SALARY) -- 부서의 평균 급여
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6') -- 부서 코드가 'D5' 또는 'D6'인 경우
GROUP BY DEPT_CODE; -- 부서 코드 기준 그룹화



-- 2. EMPLOYEE 테이블에서 직급 별 2000년도 이후 입사자들의 급여 합을 조회
-- WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000 사용
SELECT JOB_CODE , -- 직급
       SUM(SALARY) -- 급여 합계
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000 -- 2000년도 이후 입사자
GROUP BY JOB_CODE ; -- 직급 기준 그룹화

SELECT * FROM EMPLOYEE

-- 3. EMPLOYEE 테이블에서 부서 별로 같은 직급인 사원의 급여 합계를 조회하고
-- 부서 코드 오름차순으로 정렬
SELECT DEPT_CODE, -- 부서 코드
       JOB_CODE , -- 직급
       SUM(SALARY) -- 같은 직급 사원의 급여 합계
FROM EMPLOYEE 
GROUP BY DEPT_CODE, JOB_CODE -- 부서 코드와 직급 기준 그룹화
ORDER BY DEPT_CODE ASC; -- 부서 코드 오름차순 정렬



-- 4. EMPLOYEE 테이블에서 부서 별로 급여 등급이 같은 직원의 수를 조회하고
-- 부서코드, 급여 등급 오름차순으로 정렬
SELECT DEPT_CODE, -- 부서 코드
       SAL_LEVEL, -- 급여 등급
       COUNT(*) -- 같은 급여 등급인 직원의 수
FROM EMPLOYEE
GROUP BY DEPT_CODE, SAL_LEVEL -- 부서 코드와 급여 등급 기준 그룹화
ORDER BY DEPT_CODE ASC, SAL_LEVEL ASC; -- 부서 코드 및 급여 등급 오름차순 정렬



-- 5. EMPLOYEE 테이블에서 부서코드, 부서별 급여의 합계, 부서별 급여의 평균(정수처리), 인원수 조회
-- 부서코드 오름차순 정렬
-- SUM FLOOR AVG COUNT SELECT FROM GROUP BY ORDER BY 사용 
SELECT DEPT_CODE, -- 부서 코드
       SUM(SALARY), -- 부서별 급여 합계
       FLOOR(AVG(SALARY)), -- 부서별 급여 평균(정수 처리)
       COUNT(*) AS 사원수 -- 부서별 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE -- DEPT_CODE 기준으로 그룹화
ORDER BY DEPT_CODE ASC; -- 부서코드 오름차순 정렬



-- 6. EMPLOYEE 테이블에서 부서코드와 부서별 보너스를 받는 사원의 수를 조회하고 부서코드 오름차순 정렬 , null인 행 빼고 카운트
SELECT DEPT_CODE, -- 부서 코드
       COUNT(BONUS) AS 보너스를_받는_사원수 -- 보너스를 받는 사원의 수 (NULL이 아닌 값만 카운트)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL -- 보너스가 NULL이 아닌 경우만 포함
GROUP BY DEPT_CODE -- 부서 코드 기준 그룹화
ORDER BY DEPT_CODE ASC; -- 부서 코드 오름차순 정렬



-- EMPLOYEE 테이블과 DEPARTMENT 테이블에서 부서코드 조회하기 
SELECT * FROM EMPLOYEE; -- EMP_ID, EMP_NAME, DEPT_CODE

SELECT * FROM DEPARTMENT; -- DEPT_ID, DEPT_TITLE, LOCATION_ID

SELECT * EMPLOYEE.EMP_ID, EMPLOYEE.EMP_NAME, EMPLOYEE.DEPT_CODE, DEPARTMENT.DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT -- 테이블 조회를 2개 이상 가능
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID;



-- EMP ID, EMP NAME 이용해 JOB NAME 출력
SELECT EMPLOYEE.EMP_ID, EMPLOYEE.EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_NAME
FROM EMPLOYEE, JOB;

-- 간추려서 쓰기 가능
SELECT E.EMP_ID, E.EMP_NAME, E.JOB_CODE, J.JOB_NAME
FROM EMPLOYEE E, JOB J;



-- DEPT ID, DEPT TITLE 이용해 LOCAL NAME 출력
SELECT D.DEPT_ID, D.DEPT_TITLE, D.LOCATION_ID, L.LOCAL_NAME
FROM DEPARTMENT D, LOCATION L



-- DEPARTMENT 테이블과 LOCATION 테이블 NATIONAL 테이블을 이용해서
-- DEPT_ID DEPT_TITLE LOCATION_ID NATIONAL_CODE NATIONAL_NAME 출력
-- DEPARTMENT 테이블에서 LOCATION_ID 와 LOCATION 테이블에서 LOCAL_CODE 가 일치하고
-- LOCATION 테이블에서 NATIONAL_CODE 와 NATIONAL 테이블에서 NATIONAL_CODE 가 일치
SELECT D.DEPT_ID, D.DEPT_TITLE, D.LOCATION_ID, L.NATIONAL_CODE, N.NATIONAL_NAME
FROM DEPARTMENT D, LOCATION L, NATIONAL N
WHERE D.LOCATION_ID = L.LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE;


-- 1. EMPLOYEE 테이블에서 각 부서에 속한 사원들의 평균 급여
-- 평균 급여 컬럼명은 [평균 급여]로 표기
SELECT DEPT_CODE,
       AVG(SALARY) AS "평균 급여" -- 평균 급여 컬럼명 [평균 급여]로 지정
FROM EMPLOYEE
GROUP BY DEPT_CODE;



-- 2. EMPLOYEE 테이블에서 각 직급마다 급여가 가장 높은 사원의 이름과 급여 조회
SELECT JOB_CODE,
       EMP_NAME, 
       SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (
    SELECT JOB_CODE, MAX(SALARY) -- 각 직급별 최고 급여 조회
    FROM EMPLOYEE
    GROUP BY JOB_CODE
)
ORDER BY JOB_CODE;



-- 3. 부서별로 입사한 직원들의 평균 급여
SELECT DEPT_CODE,
       AVG(SALARY) AS AVG_SALARY 
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- 부서 코드 기준으로 그룹화



-- 4. 부서이름이 '인사관리부'인 직원의 이름 출력
SELECT E.EMP_NAME 
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID -- EMPLOYEE와 DEPARTMENT 테이블 조인
WHERE D.DEPT_TITLE = '인사관리부'; -- 부서 이름이 '인사관리부'인 경우



-- 1. 이메일 주소가 등록된 직원의 이름과 부서명을 출력하시오.
SELECT E.EMP_NAME, D.DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID -- EMPLOYEE와 DEPARTMENT 테이블 조인
WHERE E.EMAIL IS NOT NULL; -- 이메일 주소가 등록된 경우



-- 2. 각 부서의 최고 급여를 출력하시오.
SELECT DEPT_CODE,
       MAX(SALARY) AS MAX_SALARY -- 최고 급여
FROM EMPLOYEE
GROUP BY DEPT_CODE;



-- 2. 각 부서의 최고 급여를 출력하시오.(이름도 불러오기)
   SELECT DEPT_CODE, EMP_NAME, MAX(SALARY)
   FROM EMPLOYEE
   GROUP BY DEPT_CODE, EMP_NAME
   ORDER BY dept_code, MAX(SALARY) DESC; -- DESC 적용안됨, EMP_NAME까지 GROUP BY로 묶여 있기 때문 



-- 2-1. 각 부서의 최고 급여만 받는 사람을 출력하시오.
SELECT DEPT_CODE, SALARY, EMP_NAME
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) -- 이 조건을 포함한다면
IN (
       SELECT DEPT_CODE, MAX(SALARY)
       FROM EMPLOYEE
       GROUP BY DEPT_CODE
)
ORDER BY DEPT_CODE;



-- 3. 각 급여 등급별 직원 수를 출력하시오.
SELECT SAL_LEVEL,
       COUNT(*) AS EMPLOYEE_COUNT -- 직원 수
FROM EMPLOYEE
GROUP BY SAL_LEVEL;



-- 4. 부서 이름과 평균 급여를 급여가 높은 순으로 정렬 출력하시오.
SELECT D.DEPT_TITLE,
       AVG(E.SALARY) AS AVG_SALARY -- 평균 급여
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID -- EMPLOYEE와 DEPARTMENT 테이블 조인
GROUP BY D.DEPT_TITLE
ORDER BY AVG_SALARY DESC;



-- 5. 지역별 부서 수를 출력하시오.
SELECT L.LOCAL_NAME,
       COUNT(D.DEPT_ID) AS DEPT_COUNT
FROM DEPARTMENT D
JOIN LOCATION L ON D.LOCATION_ID =L.LOCAL_CODE -- DEPARTMENT와 LOCATION 테이블 조인
GROUP BY L.LOCAL_NAME;



-- 6. 각 부서(DEPT_CODE)별 보너스 비율(BONUS)의 평균을 구하되, 평균 보너스 비율이 높은 순으로 정렬
SELECT DEPT_CODE,
       AVG(BONUS) AS AVG_BONUS -- 평균 보너스 비율
FROM EMPLOYEE
GROUP BY DEPT_CODE 
ORDER BY AVG_BONUS DESC;



-- 7. 각 부서(DEPT_CODE)별 평균 급여(SALARY)와 평균 보너스 비율(BONUS)을 조회하되, 부서명(DEPT_TITLE)을 기준으로 오름차순 정렬
SELECT D.DEPT_TITLE, 
       AVG(E.SALARY) AS AVG_SALARY, -- 평균 급여
       AVG(E.BONUS) AS AVG_BONUS -- 평균 보너스 비율
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID -- EMPLOYEE와 DEPARTMENT 테이블 조인
GROUP BY D.DEPT_TITLE 
ORDER BY D.DEPT_TITLE ASC;



-- 8. 각 부서별 퇴사자 수를 조회하고, 퇴사자 수가 많은 순으로 정렬
-- 퇴사자 정보가 EMPLOYEE 테이블에 있다고 가정하고 퇴사 여부를 RESIGN_FLAG 컬럼으로 표현
SELECT DEPT_CODE,
       COUNT(*) AS RESIGNED_COUNT -- 퇴사자 수
FROM EMPLOYEE
WHERE RESIGN_FLAG = 'Y' -- 또는 UPPER('y'), 퇴사자만 포함
GROUP BY DEPT_CODE 
ORDER BY RESIGNED_COUNT DESC; 

------------------------------------------------------------------------

-- 부서별 평균 급여가 3000000원 이상인 부서를 조회하여 부서코드 오름차순 정렬
----- where 절과 having절 비교 -----
--- 1. where 절 --급여가 300만원 이상인 사원만 조회 
SELECT dept_code, AVG(salary)
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE ,EMP_NAME;
---SQL Error [937] [42000]: ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
---- select 에 작성한 컬럼명을 group by 에 컬럼명을 작성해서 표기하면 에러 해결
--- 2. having 절 -- 그룹 급여 평균이 300만원 이상인 그룹만 조회
SELECT dept_code, AVG(salary)
FROM EMPLOYEE
GROUP BY DEPT_CODE ,EMP_NAME
HAVING AVG(SALARY) >= 3000000;
-- having 절 로 cafe 테이블 menu 테이블 확인
--- 평균 메뉴  가격이 5000 원 이상인 카페의 이름과 평균 메뉴 가격을 출력
SELECT  c.CAFE_NAME, AVG(m.PRICE)
FROM CAFE C, MENU M
GROUP BY c.CAFE_NAME
HAVING avg(m.PRICE) >= 5000;
--> 카페들로 그룹화 한 다음에 평균 가격이 5000원 이상인 카페만 필터링
----> A카페 (100~9000) B카페(2000~100000) C카페(10000~ 100000)
------> A카페 평균가격은 5000원이 안되므로 탈락
SELECT  c.CAFE_NAME, AVG(m.PRICE)
FROM CAFE C, MENU M
where m.PRICE >= 5000
GROUP BY c.CAFE_NAME;
--> 메뉴들에서 5000원 이하인 메뉴들은 모두 제외
---> A카페 : 9000  B카페 : 100000   C카페 : 10000 , 100000
--- HAVING 절의 경우 0원부터 최대금액까지 모두 가져온 후 합산의 결과가 5000원 이상인 카페만 OK
--- WHERE  절의 경우 각 카페에서 5000원 미만인 메뉴는 제외한 후 합산의 결과를 보여줌


---------------------------------------------------------------------------------------

-- EMPLOYEE 테이블에서 부서코드, 부서(그룹) 별 급여 합계 조회
--	   /*어떤 그룹을 묶어서 조회할 것인지를 추가로 작성해줌*/
SELECT DEPT_CODE                                  , SUM(SALARY) , AVG(SALARY) --그룹 별로 월급합계 / 평균월급 조회
FROM EMPLOYEE     -- EMPLOYEE 테이블에서
GROUP BY DEPT_CODE; -- DEPT_CODE 컬럼 값이 같은 행들끼리 묶어서
-- EMPLOYEE 테이블에서 
-- 부서코드, 부서 별 급여의 합계, 부서 별 급여의 평균(정수처리), 인원수 조회하고
-- 부서코드 오름차순으로 정렬  
---- SUM FLOOR AVG COUNT
---- SELECT FROM GROUP BY ORDER BY
SELECT dept_code, SUM(salary), FLOOR(AVG(salary)), COUNT(*) AS 사원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
--– 1. EMPLOYEE 테이블에서 부서코드가 'D5', 'D6'인 부서의 평균 급여 조회
------ UPPER 함수는 문자열 하나를 변환하기 위해 사용, 다중 값 사용 불가
SELECT dept_code, FLOOR(AVG(salary)) AS 평균_급여
FROM EMPLOYEE
WHERE UPPER(DEPT_CODE) IN ('D5', 'D6')
GROUP BY dept_code;
--– 2. EMPLOYEE 테이블에서 직급 별 2000년도 이후 입사자들의 급여 합을 조회
------ WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000 -- 특정 날짜 열에서 년도만 가져오기
GROUP BY JOB_CODE;
--– 3. EMPLOYEE 테이블에서 부서 별로 같은 직급인 사원의 급여 합계를 조회하고
---- 부서 코드 오름차순으로 정렬  GROUP BY DEPT_CODE, JOB_CODE
----- sum이나 avg 같이 특정 함수로 계산한 결과를 나타낼 때 조회하고자 하는 컬럼명을 작성해줄경우
----- GROUP BY 절에 sum,avg 같이 계산 함수가 적용되지 않은 컬럼명을 모두 작성해줘야 함 
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;
--– 4. EMPLOYEE 테이블에서 부서 별로 급여 등급이 같은 직원의 수를 조회하고
---- 부서코드, 급여 등급 오름차순으로 정렬 
------ GROUP BY DEPT_CODE, SAL_LEVEL
SELECT dept_code, sal_level, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, SAL_LEVEL
--  첫 번째로 부서코드 ABCD 순으로 정렬 , 부서 안에 존재하는 급여레벨 ABCD순으로 정렬
ORDER BY DEPT_CODE, SAL_LEVEL;
--– 5. EMPLOYEE 테이블에서 부서코드와 부서별 보너스를 받는 사원의 수를 조회하고
------ 부서코드 오름차순 정렬
SELECT dept_code, COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
--– 6. EMPLOYEE 테이블에서 부서코드와 부서별 보너스를 받는 사원의 수를 조회하고
------ 부서코드 오름차순 정렬 null 인 행 빼고 카운트 카운트 함수 내부에 BONUS 작성하면
------- BONUS 컬럼명에서 null 값은 제외하고 수 측정을 진행함   null = 아무것도 들어있지 않은 빈 값
SELECT dept_code, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
-- EMPLOYEE 테이블과 DEPARTMENT 테이블에서 부서코드 조회하기
SELECT * FROM EMPLOYEE; --emp_id emp_name dept_code 
SELECT * FROM DEPARTMENT; --dept_id dept_title, location_id
SELECT EMPLOYEE.emp_id, EMPLOYEE.emp_name, EMPLOYEE.dept_code, DEPARTMENT.DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT  --테이블 조회를 2개이상 가능
WHERE EMPLOYEE.dept_code = DEPARTMENT.DEPT_ID; 
SELECT E.EMP_ID, E.emp_name, E.JOB_CODE, n.JOB_NAME
FROM EMPLOYEE E, JOB n;
SELECT d.DEPT_ID, d.DEPT_TITLE, d.LOCATION_ID, l.LOCAL_NAME
FROM DEPARTMENT d, LOCATION l;
-- DEPARTMENT 테이블과 LOCATION 테이블 NATIONAL 테이블을 이용해서
-- DEPT_ID DEPT_TITLE LOCATION_ID NATIONAL_CODE NATIONAL_NAME 출력
-- WHERE 절 사용 -> 서로 같다는 표기를 2개 이상의 테이블에서 진행해야할 때는 WHERE절을 필수로 사용!
--- DEPARTMENT 테이블에서    LOCATION_ID 와 LOCATION 테이블에서 LOCAL_CODE 일치하고
---  LOCATION  테이블에서  NATIONAL_CODE 와 NATIONAL 테이블에서 NATIONAL_CODE 일치
SELECT D.DEPT_ID, D.DEPT_TITLE, D.LOCATION_ID, L.NATIONAL_CODE, N.NATIONAL_NAME
FROM DEPARTMENT D, LOCATION L, NATIONAL N
WHERE D.LOCATION_ID = L.LOCAL_CODE  
AND L.NATIONAL_CODE = N.NATIONAL_CODE;
-- 1. EMPLOYEE 테이블에서 각 부서에 속한 사원들에 평균 급여
--  평균급여 컬럼명은 [평균 급여] 표기
--- DEPT_CODE AVG(SALARY)
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) AS "평균 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 2. EMPLOYEE 테이블에서 각 직급마다 급여가 가장 높은 사원의 이름과 급여 MAX(SALARY)
--- GROUP BY ORDER BY
-- JOB_CODE, EMP_NAME, 가장높은 사원의 급여
SELECT JOB_CODE, EMP_NAME, MAX(SALARY) AS "가장 높은 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE, EMP_NAME
ORDER BY JOB_CODE, MAX(SALARY) DESC;
-- 3. 부서별로 입사한 직원들의 평균 급여 GROUP BY
---GROUP BY
--- DEPT_CODE AVG(SALARY)
-- 4. 부서이름이 인사관리부 인 직원의 이름 출력
--- WHERE AND 
---- TABLE : EMPLOYEE DEPARTMENT


-----------------------------------------------------------------

-- 1. EMPLOYEE 테이블에서 모든 데이터를 조회하세요.
SELECT * FROM EMPLOYEE;
-- 2. DEPARTMENT 테이블에서 DEPT_TITLE과 LOCATION_ID를 조회하세요.
SELECT DEPT_TITLE, LOCATION_ID FROM DEPARTMENT;
-- 3. EMPLOYEE 테이블에서 SALARY가 3,000,000 이상인 직원들의 EMP_NAME과 SALARY를 조회하세요.
SELECT EMP_NAME, SALARY 
FROM EMPLOYEE 
WHERE SALARY >= 3000000;
-- 4. DEPARTMENT 테이블에서 LOCATION_ID가 'L1'인 부서를 조회하세요.
SELECT * 
FROM DEPARTMENT 
WHERE LOCATION_ID = 'L1';
-- 5. EMPLOYEE 테이블에서 BONUS가 NULL인 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE BONUS IS NULL;
-- 6. EMPLOYEE 테이블에서 SALARY가 2,500,000 이상이고 BONUS가 0.2 이상인 직원의 EMP_NAME을 조회하세요.
SELECT EMP_NAME 
FROM EMPLOYEE 
WHERE SALARY >= 2500000 AND BONUS >= 0.2;
-- 7. EMPLOYEE 테이블에서 JOB_CODE가 'J6'이거나 'J7'인 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE JOB_CODE IN ('J6', 'J7');
-- 8. DEPARTMENT 테이블에서 DEPT_TITLE에 '영업'이라는 단어가 포함된 부서를 조회하세요.
SELECT * 
FROM DEPARTMENT 
WHERE DEPT_TITLE LIKE '%영업%';
-- 9. EMPLOYEE 테이블에서 입사일(HIRE_DATE)이 2000년 이후인 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE HIRE_DATE > TO_DATE('2000-01-01', 'YYYY-MM-DD');
-- 10. EMPLOYEE 테이블에서 퇴직 여부가 'Y'이고 퇴사일이 2015년 이후인 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE TERMINATION_FLAG = 'Y' AND TERMINATION_DATE > TO_DATE('2015-01-01', 'YYYY-MM-DD');
-- 11. EMPLOYEE 테이블에서 EMP_NAME의 첫 글자가 '김'인 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '김%';
-- 12. EMPLOYEE 테이블에서 JOB_CODE가 'J1', 'J2', 'J3'인 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE JOB_CODE IN ('J1', 'J2', 'J3');
-- 13. EMPLOYEE 테이블에서 특정 DEPT_CODE('D1', 'D5', 'D9')를 제외한 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE DEPT_CODE NOT IN ('D1', 'D5', 'D9');
-- 14. EMPLOYEE 테이블에서 MANAGER_ID가 NULL인 직원들의 EMP_NAME과 DEPT_CODE를 조회하세요.
SELECT EMP_NAME, DEPT_CODE 
FROM EMPLOYEE 
WHERE MANAGER_ID IS NULL;
-- 15. EMPLOYEE 테이블에서 EMP_NAME에 '김'이 포함된 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '%김%';
-- 16. EMPLOYEE 테이블에서 EMAIL 주소에 'gmail'이 포함된 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE EMAIL LIKE '%gmail%';
-- 17. EMPLOYEE 테이블에서 PHONE 번호가 '010'으로 시작하는 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE PHONE LIKE '010%';
-- 18. EMPLOYEE 테이블에서 PHONE 번호가 '1234'로 끝나는 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE PHONE LIKE '%1234';
-- 19. DEPARTMENT 테이블에서 DEPT_TITLE이 '영업'으로 끝나는 부서를 조회하세요.
SELECT * 
FROM DEPARTMENT 
WHERE DEPT_TITLE LIKE '%영업';
-- 20. DEPARTMENT 테이블에서 DEPT_TITLE에 '관리'라는 단어가 포함된 부서를 조회하세요.
SELECT * 
FROM DEPARTMENT 
WHERE DEPT_TITLE LIKE '%관리%';
-- 21. EMPLOYEE 테이블에서 EMP_NAME이 '이'로 시작하는 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '이%';
-- 22. EMPLOYEE 테이블에서 JOB_CODE가 'J'로 시작하고 두 번째 문자가 '1'인 직원을 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE JOB_CODE LIKE 'J1%';
-- 23. EMPLOYEE 테이블에서 EMAIL이 'com'으로 끝나는 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE EMAIL LIKE '%com';
-- 24. EMPLOYEE 테이블에서 HIRE_DATE의 연도가 2021년인 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE TO_DATE(HIRE_DATE, 'YYYY') = TO_DATE('2021', 'YYYY');
-- 25. EMPLOYEE 테이블에서 EMP_NAME의 마지막 글자가 '호'인 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '%호';
-- 26. EMPLOYEE 테이블에서 EMAIL에 'company'라는 단어가 포함된 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE EMAIL LIKE '%company%';
-- 27. EMPLOYEE 테이블에서 EMP_NAME에 '수'로 시작하거나 끝나는 직원들의 정보를 조회하세요.
SELECT * 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '수%' OR EMP_NAME LIKE '%수';
SELECT * 
FROM EMPLOYEE 
WHERE TO_DATE(HIRE_DATE, 'YYYY') = TO_DATE('2021', 'YYYY');