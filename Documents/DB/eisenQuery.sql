-- INSERT --
INSERT INTO PROJ_MEM (MEM_NO, PROJ_NO, MEM_ROLE_NO, PROJ_JOIN_DATE, PROJ_USER_NICK)
VALUES (1, 2, 1, sysdate, '해적왕 아이젠');

-- FALSHBACK --
FLASHBACK TABLE member TO BEFORE DROP;

SELECT A.MEM_NO, A.MEM_ID, A.MEM_NICK, A.MEM_TEL, A.MEM_PIC_FILE_NAME,
        A.MEM_NM, A.MEM_BIO, A.MEM_WORKING_CITY, A.MEM_STATUS,
        B.ISSUE_NO, B.ISSUE_TITLE, B.LABEL_NO, B.MILEST_SID,
        B.ISSUE_PRIORITY, B.PROGRESS, B.ISSUE_STATUS,
        C.ISSUE_HIS_NO, C.ISSUE_HIS_CONT, C.ISSUE_HIS_DATE,
        CM.MEM_NICK AS HIS_WRITER_NICK, CM.MEM_PIC_FILE_NAME AS HIS_WRITER_PIC,
        D.LABEL_NM,
				'getContextPath()/'||E.PROJ_TITLE||'/'||EM.MEM_NICK||'/'||B.ISSUE_NO AS URL,

				G.PROJ_TITLE, G.PROJ_CONT, GM.MEM_NICK AS PROJ_MANAGER

    FROM MEMBER A
        LEFT OUTER JOIN ISSUE_ASSIGNEE BC ON (A.MEM_NO = BC.MEM_NO)
        LEFT OUTER JOIN ISSUE B ON (BC.ISSUE_SID = B.ISSUE_SID)
        LEFT OUTER JOIN ISSUE_HISTORY C ON (B.ISSUE_SID = C.ISSUE_SID)
        INNER JOIN MEMBER CM ON (C.MEM_NO = CM.MEM_NO)
        LEFT OUTER JOIN LABEL D ON (B.LABEL_NO = D.LABEL_NO)
        LEFT OUTER JOIN PROJECT E ON (B.PROJ_NO = E.PROJ_NO)
        INNER JOIN MEMBER EM ON (E.MEM_NO = EM.MEM_NO)

        LEFT OUTER JOIN PROJ_MEM GC ON (A.MEM_NO = GC.MEM_NO)
        LEFT OUTER JOIN PROJECT G ON (GC.PROJ_NO = G.PROJ_NO)
        INNER JOIN MEMBER GM ON (G.MEM_NO = GM.MEM_NO)
    WHERE A.MEM_NO = 1;

-- 결과물 --
WITH PROJECTINFO AS (
		    SELECT
		        PROJ_TITLE, PROJECT.PROJ_NO, PROJ_USER_NICK, PROJ_MEM.MEM_NO,
		        MEM_NICK AS PROD_MANAGER
		    FROM
		        PROJ_MEM
		        INNER JOIN PROJECT ON(PROJ_MEM.PROJ_NO = PROJECT.PROJ_NO)
		        INNER JOIN MEMBER ON(PROJECT.MEM_NO = MEMBER.MEM_NO)

		    ),
		ISSUEINFO AS (
		    SELECT
		        ISSUE.ISSUE_SID, ISSUE_ASSIGNEE.MEM_NO AS ASSIGNEE, ISSUE.ISSUE_NO,
		        ISSUE_HISTORY.MEM_NO AS FIXER, ISSUE_HIS_NO,
		        LABEL_NO, PROJ_NO, ISSUE_TITLE, ISSUE_HIS_CONT, ISSUE_HIS_DATE, ISSUE_ASSIGNEE.MEM_NO
		    FROM
		        ISSUE_ASSIGNEE
		            INNER JOIN ISSUE ON (ISSUE_ASSIGNEE.ISSUE_SID = ISSUE.ISSUE_SID)
		            INNER JOIN ISSUE_HISTORY ON (ISSUE.ISSUE_SID = ISSUE_HISTORY.ISSUE_SID)
		)

		SELECT
		        MEM_NICK, MEM_ID, MEMBER.MEM_NO,
		        PROJECTINFO.PROJ_NO AS PROJECT_NO, PROJ_TITLE,
		        PROD_MANAGER||'/'||PROJ_TITLE AS URI,
		        PROD_MANAGER||'/'||PROJ_TITLE||'/'||ISSUE_NO AS URL,
		        ISSUE_SID AS ISSUE_ID,
		        ISSUE_TITLE, FIXER, ASSIGNEE, ISSUE_HIS_CONT, ISSUE_HIS_DATE, ISSUE_HIS_NO
		FROM MEMBER
		        LEFT OUTER JOIN PROJECTINFO ON(MEMBER.MEM_NO = PROJECTINFO.MEM_NO)
		        LEFT OUTER JOIN ISSUEINFO ON(PROJECTINFO.PROJ_NO = ISSUEINFO.PROJ_NO)

		WHERE MEMBER.MEM_NO = 1


-- TEST--
SELECT * FROM MEMBER;
SELECT * FROM ISSUE_HISTORY;
SELECT DISTINCT(ISSUE_SID) FROM ISSUE_HISTORY;

-- ISSUE 담당자, issueㅂ, issue 히스토리 조회
SELECT
    ISSUE.ISSUE_SID, ISSUE_ASSIGNEE.MEM_NO AS ASSIGNEE,
    ISSUE_HISTORY.MEM_NO AS 수정자,ISSUE_HISTORY.ISSUE_HIS_NO, LABEL_NO, PROJ_NO, ISSUE_TITLE
FROM
    ISSUE_ASSIGNEE
        INNER JOIN ISSUE ON (ISSUE_ASSIGNEE.ISSUE_SID = ISSUE.ISSUE_SID)
        INNER JOIN ISSUE_HISTORY ON (ISSUE.ISSUE_SID = ISSUE_HISTORY.ISSUE_SID)
WHERE ISSUE_ASSIGNEE.MEM_NO = 2
ORDER BY ISSUE_SID;


SELECT
    ISSUE_ASSIGNEE.MEM_NO AS ASSIGNEE, ISSUE.ISSUE_SID, ISSUE.ISSUE_NO,
    ISSUE_HIS_NO, ISSUE_HISTORY.MEM_NO AS FIXER_NO, MEMBER.MEM_NICK AS FIXER_NICK, 
    LABEL_NO, PROJ_NO, ISSUE_TITLE, ISSUE_HIS_CONT, ISSUE_HIS_DATE, ISSUE_ASSIGNEE.MEM_NO,
    LABEL.LABEL_NM
FROM
    ISSUE_ASSIGNEE
        INNER JOIN ISSUE ON (ISSUE_ASSIGNEE.ISSUE_SID = ISSUE.ISSUE_SID)
        INNER JOIN ISSUE_HISTORY ON (ISSUE.ISSUE_SID = ISSUE_HISTORY.ISSUE_SID)
        INNER JOIN MEMBER ON (ISSUE_HISTORY.MEM_NO = MEMBER.MEM_NO)
        INNER JOIN LABEL ON (ISSUE_HISTORY.LABEL_NO = LABEL.LABEL_NO)
WHERE ISSUE_ASSIGNEE.MEM_NO = 4;

SELECT *
FROM ISSUE A
INNER JOIN ISSUE_HISTORY B ON (A.ISSUE_SID =B.ISSUE_SID)
WHERE A.ISSUE_SID = 5;


SELECT
ISSUE_ASSIGNEE.MEM_NO AS ASSIGNEE, ISSUE.ISSUE_SID, ISSUE.ISSUE_NO, ISSUE.PROJ_NO,
ISSUE_HIS_NO, ISSUE_HISTORY.MEM_NO AS FIXER_NO, MEMBER.MEM_NICK AS FIXER_NICK, 
ISSUE_TITLE, ISSUE_HIS_CONT, ISSUE_HIS_DATE, ISSUE.LABEL_NO, LABEL.LABEL_NM,
SELF.MEM_NO AS ASSIGNEES
FROM
ISSUE_ASSIGNEE
    INNER JOIN ISSUE ON (ISSUE_ASSIGNEE.ISSUE_SID = ISSUE.ISSUE_SID)
    INNER JOIN ISSUE_HISTORY ON (ISSUE.ISSUE_SID = ISSUE_HISTORY.ISSUE_SID)
    INNER JOIN MEMBER ON (ISSUE_HISTORY.MEM_NO = MEMBER.MEM_NO)
    LEFT OUTER JOIN LABEL ON (ISSUE.LABEL_NO = LABEL.LABEL_NO)
    INNER JOIN ISSUE_ASSIGNEE SELF ON(ISSUE_ASSIGNEE.ISSUE_SID = SELF.ISSUE_SID)
   WHERE ISSUE_ASSIGNEE.MEM_NO = 4;

SELECT *
FROM ISSUE_ASSIGNEE
WHERE ISSUE_SID = 6;

WITH PROJECTINFO AS (
    SELECT
        PROJ_TITLE, PROJECT.PROJ_NO, PROJ_USER_NICK, PROJ_MEM.MEM_NO,
        MEM_ID AS PROJ_MANAGER_ID, PROJECT.MEM_NO AS PROJ_MANAGER_NO
    FROM
        PROJ_MEM
        INNER JOIN PROJECT ON(PROJ_MEM.PROJ_NO = PROJECT.PROJ_NO)
        INNER JOIN MEMBER ON(PROJECT.MEM_NO = MEMBER.MEM_NO)
    ), 
ISSUEINFO AS (
    SELECT
        ISSUE_ASSIGNEE.MEM_NO AS ASSIGNEE_NO, ISSUE.ISSUE_SID, ISSUE.ISSUE_NO, ISSUE.PROJ_NO,
        ISSUE_HIS_NO, ISSUE_HISTORY.MEM_NO AS FIXER_NO, MEMBER.MEM_ID AS FIXER_ID, 
        ISSUE_TITLE, ISSUE_HIS_CONT, ISSUE_HIS_DATE, ISSUE.LABEL_NO, LABEL.LABEL_NM
    FROM
        ISSUE_ASSIGNEE
            INNER JOIN ISSUE ON (ISSUE_ASSIGNEE.ISSUE_SID = ISSUE.ISSUE_SID)
            INNER JOIN ISSUE_HISTORY ON (ISSUE.ISSUE_SID = ISSUE_HISTORY.ISSUE_SID)
            INNER JOIN MEMBER ON (ISSUE_HISTORY.MEM_NO = MEMBER.MEM_NO)
            LEFT OUTER JOIN LABEL ON (ISSUE.LABEL_NO = LABEL.LABEL_NO)
),
ASSIGNEES AS (
    SELECT A.ISSUE_SID AS ASSIGNEES_SID, C.MEM_NO AS ASSIGNEE, C.MEM_ID AS ASSIGNEE_ID
    FROM ISSUE_ASSIGNEE A
    INNER JOIN MEMBER C ON (A.MEM_NO = C.MEM_NO)
), 
MEMSTAT AS (
    SELECT COM_CODE_GRP, COM_CODE_NM, COM_CODE
    FROM COM_CODE
    WHERE COM_CODE_GRP = 'MS'
)
SELECT 
        MEMBER.MEM_NICK, MEMBER.MEM_ID, MEMBER.MEM_NO AS MEM_NO, MEMBER.MEM_BIO,
        MEMBER.MEM_PIC_FILE_NAME, MEMSTAT.COM_CODE_NM AS MEM_STATUS,
        PROJECTINFO.PROJ_NO AS PROJECT_NO, PROJ_TITLE, PROJ_MANAGER_NO, PROJ_MANAGER_ID, PROJ_USER_NICK,
        PROJ_MANAGER_ID||'/'||PROJ_TITLE AS PROJECT_URI, 
        PROJ_MANAGER_ID||'/'||PROJ_TITLE||'/issue/'||ISSUE_NO AS ISSUE_URL,
        ISSUE_SID AS ISSUE_ID, ISSUE_TITLE, FIXER_NO, FIXER_ID, ISSUE_HIS_CONT, ISSUE_HIS_DATE, ISSUE_HIS_NO,
        LABEL_NO, LABEL_NM, ASSIGNEES.ASSIGNEE, ASSIGNEES.ASSIGNEE_ID
FROM MEMBER
        LEFT OUTER JOIN PROJECTINFO ON(MEMBER.MEM_NO = PROJECTINFO.MEM_NO)
        LEFT OUTER JOIN ISSUEINFO ON(PROJECTINFO.PROJ_NO = ISSUEINFO.PROJ_NO AND MEMBER.MEM_NO = ISSUEINFO.ASSIGNEE_NO)
        LEFT OUTER JOIN ASSIGNEES ON(ISSUEINFO.ISSUE_SID = ASSIGNEES.ASSIGNEES_SID)
        INNER JOIN MEMSTAT ON(MEMBER.MEM_STATUS = MEMSTAT.COM_CODE)
WHERE MEMBER.MEM_NO = 4
ORDER BY ISSUE_HIS_NO DESC;

-- 함수 등록(1:1채팅 전에 검증 쿼리 등록하기) -- 
create or replace FUNCTION TEST(
    MYNO NUMBER,
    TARNO NUMBER    
)
RETURN NUMBER
IS
V_NO NUMBER;
BEGIN
WITH TMPROOM AS (
    SELECT DISTINCT A.*
    FROM CHAT_ROOM A INNER JOIN MEM_CHAT B 
    ON (A.CHATROOM_NO = B.CHATROOM_NO)
    WHERE MEM_NO = MYNO
),
LASTROOM AS (
SELECT R.CHATROOM_NO, MEM_NO
FROM TMPROOM R LEFT OUTER JOIN MEM_CHAT M
    ON(R.CHATROOM_NO = M.CHATROOM_NO)
WHERE R.CHATROOM_NO IN (
    SELECT CHATROOM_NO
    FROM (
        SELECT  CHATROOM_NO, COUNT(MEM_NO)CNT
        FROM MEM_CHAT
        GROUP BY CHATROOM_NO
    ) 
    WHERE CNT = 2
)
)
SELECT DISTINCT CHATROOM_NO INTO V_NO
FROM LASTROOM
WHERE MEM_NO = TARNO;
RETURN V_NO;
END;


-- milestoneList, issueList --
-- 서로 존재할수도 있고 존재하지 않을 수도 있기 때문에 full outer join을 사용. --
WITH ISSUEINFO AS (
    SELECT A.ISSUE_SID, B.MEM_NO, M.MEM_ID, A.ISSUE_TITLE,  A.PROJ_NO 
        , A.MILEST_SID, A.ISSUE_START_DATE, A.ISSUE_END_DATE
        , A.ISSUE_STATUS
    FROM ISSUE A
        LEFT OUTER JOIN ISSUE_ASSIGNEE B ON (A.ISSUE_SID = B.ISSUE_SID)
        LEFT OUTER JOIN MEMBER M ON (B.MEM_NO = M.MEM_NO)
        LEFT OUTER JOIN LABEL C ON (A.LABEL_NO = C.LABEL_NO)
)
SELECT D.MILEST_SID, D.MILEST_TITLE, D.MILEST_START_DATE, D.MILEST_END_DATE 
    , D.MILEST_NO, D.MILEST_CONT, D.MILEST_STATUS, D.PROJ_NO
    , F.ISSUE_SID AS ISSUE_ID, F.MEM_NO AS ISSUE_ASSIN_MEM_NO, F.MEM_ID, F.ISSUE_TITLE
    , F.MILEST_SID AS MILEST_ID, F.ISSUE_START_DATE, F.ISSUE_END_DATE
    , F.ISSUE_STATUS 
FROM MILESTONE D
FULL OUTER JOIN ISSUEINFO F ON (D.MILEST_SID = F.MILEST_SID)
WHERE D.PROJ_NO = ${proj_no} OR F.PROJ_NO=${proj_no}