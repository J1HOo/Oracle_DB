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


