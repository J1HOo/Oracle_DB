USE KHTUSER;

-- 1. 'MySQL'   ' ' 'is'   'Awesome!' -> 붙여서 출력
SELECT CONCAT('MySQL', ' ', 'is', ' ', 'Awesome!') AS result;

-- 2. hello.world.program 에서 hello.world 까지만 출력
SELECT SUBSTRING_INDEX('hello.world.program', '.', 2) AS result;

-- 3. 전화번호에 5678이 들어가는 USER 수 확인
SELECT COUNT(*) AS user_count
FROM USER
WHERE phone_number LIKE '%5678%';

-- 4. PRODUCT
-- CONCAT을 이용해서 제품명 : 울트라 게이밍 키보드, 가격 89000원 으로 출력
SELECT CONCAT(product_name, ' : ', '가격 ', price, '원') AS product_info
FROM PRODUCT;

-- 5. REVIEW 테이블에서 제품아이디 3번의 댓글 길이
SELECT LENGTH(comment) AS comment_length
FROM REVIEW
WHERE product_id = 3;

-- 6. REVIEW 제품아이디 4번에 작성된 댓글에서 좋고 -> 훌륭하고 바꿔서 출력
SELECT REPLACE(comment, '좋고', '훌륭하고') AS updated_comment
FROM REVIEW
WHERE product_id = 4;