CREATE TABLE EATS AS SELECT * FROM CAFE;

SELECT * FROM EATS; 

CREATE TABLE EATS_MENU AS SELECT * FROM MENU;

SELECT * FROM EATS_MENU;


--11번째 빠나프레쏘 '경기도 고양시' 031-123-4567 

INSERT INTO EATS 
		VALUES(11,'빠나쁘레쏘','경기도 고양시','031-123-4567'); 
	COMMIT; -- INSERT UPDATE DELETE 추가 수정 삭제 한 기록 저장하기 !!! 
	
--	DELETE FROM EATS 
--	WHERE CAFE_NAME = '빠나쁘레쏘';
--COMMIT;
	
--12번째 : 로맨틱블루 부산 해운대구 051-987-6543 카페 추가하기 
INSERT INTO EATS 
	VALUES(12,'로맨틱블루','부산 해운대구','051-987-6543');
	COMMIT;

--	
--13'티하우스' 카페  인천 남동구에 위치, 연락처 032-345-6789
INSERT INTO eats 
VALUES (13,'티하우스','인천 남동구','032-345-6789');
COMMIT;

--14'라떼아트' 카페  경기도 성남시에 위치, 연락처 031-654-3210
INSERT INTO EATS 
VALUES (14,'라떼아트','경기도 성남','031-654-3210');
COMMIT;

--15'커피클럽' 카페 대구 중구에 위치, 연락처 053-222-1111
INSERT INTO EATS 
VALUES (15,'커피클럽','대구 중구','053-222-1111');
COMMIT;

--2번 방법 이용해서 선택적으로 데이터 추가하기 
----주의할점 : NOT NULL은 선택적으로 작성 불가. 필수로 작성해야하는 컬럼 
--16'브루윙랩'카페 대전 서구에 위치, 연락처 042-333-4444
---PRIMARY KEY -> 고유의 숫자값을 가지는 키 가입한 명단 순서 NULL
---TRIGGER SEQUENCER -> ORACLE PRIMARY KEY 는 자동으로 번호를 측정해주는 동작을 설정해줘야함 

--빈 포레스트라는 cafe-name을 찾아서 삭제하기 
--DELETE FROM EATS WHERE CAFE_NAME = '빈포레스트';

--INSERT INTO EATS(CAFE_ID,CAFE_NAME,LOCATION,CONTACT_NUMBER) 
----VALUE(16번부터 18번까지 추가해주기)
--16'브루윙랩'카페 대전 서구에 위치, 연락처 042-333-4444
INSERT INTO EATS(CAFE_ID,CAFE_NAME,LOCATION,CONTACT_NUMBER) VALUES (16,'브루윙랩','대전 서구','042-333-4444');
COMMIT;

--DELETE FROM EATS WHERE CAFE_ID = 16;
--COMMIT;

--17'스윗빈즈' 카페 광주 북구에 위치, 연락처 062-567-8901
INSERT INTO EATS(CAFE_ID,CAFE_NAME,LOCATION,CONTACT_NUMBER) VALUES (17,'스윗빈즈','광주 북구','062-567-8901');
COMMIT;

--DELETE FROM EATS WHERE CAFE_ID = 17;
--COMMIT;

--18'카페 블랙' 울산 남구에 위치, 연락처 052-444-5555
INSERT INTO EATS(CAFE_ID,CAFE_NAME,LOCATION,CONTACT_NUMBER) VALUES (18,'카페 블랙','울산 남구','052-444-5555');
COMMIT;

--DELETE FROM EATS WHERE CAFE_ID = 18;
--COMMIT;

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (19, '비바라떼', '전주시 덕진구', '063-111-2222');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (20, '바닐라하우스', '경기도 안양시', '031-987-1234');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (21, '카페 베르디', '서울 은평구', '010-2345-6780');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (22, '샌드커피', '경상남도 창원시', '055-765-4321');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (23, '헤이조이', '제주특별자치도 제주시', '064-987-6543');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (24, '스마일빈즈', '강원도 춘천시', '033-654-7890');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (25, '모닝커피', '충청북도 청주시', '043-876-5432');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (26, '빈하우스', '전라남도 목포시', '061-654-1234');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (27, '핸드드립존', '경기도 수원시', '031-765-8765');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (28, '어반커피', '서울 서대문구', '010-5432-9876');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (29, '테라스카페', '서울 동작구', '010-9876-1234');

INSERT INTO EATS (CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (30, '그린티라떼', '서울 송파구', '010-1234-5678');


--빠나쁘레쏘 카페에 메뉴 추가 
-- 메뉴이름 : 화이트 모카 
-- 메뉴설명 : 화이트 초콜릿과 에스프레소의 조화 
-- 메뉴가격 : 5500원 

INSERT INTO EATS_MENU (MENU_ID,CAFE_ID,MENU_NAME,DESCRIPTION,PRICE)
VALUES (31, 11, '화이트 모카','화이트 초콜릿과 에스프레소의 조화',5500);

SELECT * FROM EATS_MENU EM;


INSERT INTO EATS_MENU (MENU_ID,CAFE_ID,MENU_NAME,DESCRIPTION,PRICE)
VALUES (32, 12, '얼그레이 티','향긋한 얼그레이 티',4500);

INSERT INTO EATS_MENU (MENU_ID,CAFE_ID,MENU_NAME,DESCRIPTION,PRICE)
VALUES (33, 13, '밀크티','부드러운 우유와 홍차의 조화',5000);

INSERT INTO EATS_MENU (MENU_ID,CAFE_ID,MENU_NAME,DESCRIPTION,PRICE)
VALUES (34, 14, '초코칩 프라페','달콤한 초코칩과 커피의 만남',6000);

INSERT INTO EATS_MENU (MENU_ID,CAFE_ID,MENU_NAME,DESCRIPTION,PRICE)
VALUES (35, 15, '코코럿 라떼','코코넛 향이 가미된 독특한 라떼',5800);

INSERT INTO EATS_MENU (MENU_ID,CAFE_ID,MENU_NAME,DESCRIPTION,PRICE)
VALUES (36, 16, '복숭아 에이드','상큼한 복숭아와 탄산수',5500);

INSERT INTO EATS_MENU (MENU_ID,CAFE_ID,MENU_NAME,DESCRIPTION,PRICE)
VALUES (37, 17, '라즈베리 티','상큼한 라즈베리 향의 티',5000);

INSERT INTO EATS_MENU (MENU_ID,CAFE_ID,MENU_NAME,DESCRIPTION,PRICE)
VALUES (38, 18, '오렌지 주스','신선한 오렌지를 착즙한 주스',4500);

INSERT INTO EATS_MENU (MENU_ID,CAFE_ID,MENU_NAME,DESCRIPTION,PRICE)
VALUES (39, 19, '헤이즐넛 라떼','헤이즐넛 향이 풍부한 라떼',5500);

INSERT INTO EATS_MENU (MENU_ID,CAFE_ID,MENU_NAME,DESCRIPTION,PRICE)
VALUES (40, 20, '그린티 프라페','녹차와 우유의 달콤한 음료',6000);

UPDATE EATS_MENU
SET PRICE = 6000
WHERE MENU_NAME ='화이트 모카';

UPDATE EATS_MENU
SET DESCRIPTION = '홍차와 우유가 어우러진 진한 맛의 밀크티'
WHERE MENU_NAME ='밀크티';

UPDATE EATS_MENU
SET PRICE = PRICE * 1.1
WHERE PRICE < 5500;

SELECT * FROM EATS_MENU;
