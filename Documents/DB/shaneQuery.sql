------------------------------------------------------------------------
-- Shane Query list

-- Index

-- 1. issue
-- 2. News
-- 3. Kanban
-- 4. Milestone
-- 5. Project

------------------------------------------------------------------------

-----------------------------1. Issue----------------------------------------
-- a. 이슈 목록 조회
-- b. 이슈 상세정보 보기 
----------------------------------------------------------------------
-- a. 이슈 목록 조회 
------------------------------------------------------------------------
SELECT ISSUE.ISSUE_SID AS ISSUE_ID ,ISSUE_NO ,ISSUE.PROJ_NO ,ISSUE_TITLE 
    ,ISSUE_CREATE_DATE ,ISSUE_START_DATE ,ISSUE_END_DATE ,ISSUE_STATUS
    ,ISSUE_PRIORITY ,PROGRESS
    ,MILESTONE.MILEST_SID, milestone.milest_title AS MILEST_TITLE
    ,WRITER.MEM_NO AS writer_no, writer.mem_pic_file_name AS writer_pic
    ,label.label_no, label.label_nm
    ,ASSIGNEE.mem_no, assignee.mem_pic_file_name
    ,(select count(*) -1
        from issue_history
        where issue_history.issue_sid = ISSUE.issue_sid
                and issue_history.issue_his_type = 'RE'
    ) as replyCount
FROM ISSUE
    LEFT OUTER JOIN MILESTONE ON (ISSUE.MILEST_SID = milestone.milest_sid)
    INNER JOIN MEMBER WRITER ON (ISSUE.MEM_NO = WRITER.MEM_NO)
    LEFT OUTER JOIN LABEL ON (issue.label_no = label.label_no)
    LEFT OUTER JOIN issue_assignee ON (issue.issue_sid = issue_assignee.issue_sid)
    LEFT OUTER JOIN MEMBER ASSIGNEE ON (issue_assignee.mem_no = assignee.mem_no)
WHERE ISSUE.proj_no = 1
order by ISSUE.issue_no desc;
------------------------------------------------------------------------
-- b. 이슈 상세정보 보기 
------------------------------------------------------------------------
select issue.issue_sid, issue_no, issue_title, progress, issue_status, issue_priority
        ,issue_create_date, issue_start_date, issue_end_date
        ,milestone.milest_sid, milestone.milest_title
        ,label.label_no, label.label_nm
        ,issue.proj_no
        ,writer.mem_no as writer_no, writer.mem_pic_file_name as writer_pic
        ,writer_pm.proj_user_nick as writer_nick
        ,assignee.mem_no, assignee.mem_id, assignee.mem_pic_file_name, assignee_pm.proj_user_nick as mem_nick
        ,issue_history.issue_his_no, issue_history.issue_his_cont, issue_history.issue_his_date
        ,issue_history.issue_his_type, issue_history.atch_file_sid
        ,his_writer.mem_no as his_writer_no, his_writer.mem_pic_file_name as his_writer_pic
        ,his_writer_pm.proj_user_nick as his_writer_nick
from issue
    left outer join milestone on (issue.milest_sid = milestone.milest_sid)
    left outer join label on (issue.proj_no = label.proj_no and issue.label_no = label.label_no)
    inner join member writer on (issue.mem_no = writer.mem_no)
    left outer join proj_mem writer_pm on (issue.proj_no = writer_pm.proj_no and writer.mem_no = writer_pm.mem_no)
    left outer join issue_assignee is_assignee on (issue.issue_sid = is_assignee.issue_sid)
    left outer join member assignee on (is_assignee.mem_no = assignee.mem_no)
    left outer join proj_mem assignee_pm on (issue.proj_no = assignee_pm.proj_no and assignee.mem_no = assignee_pm.mem_no)
    left outer join issue_history on (issue.issue_sid = issue_history.issue_sid)
    left outer join member his_writer on (issue_history.mem_no = his_writer.mem_no)
    left outer join proj_mem his_writer_pm on (issue.proj_no = his_writer_pm.proj_no and his_writer.mem_no = his_writer_pm.mem_no)
where issue.issue_no = 1 and issue.proj_no = 1;

------------------------------------------------------------------------




-----------------------------2. News ------------------------------------
--a. 뉴스 목록 조회

----------------------------------------------------------------------
-- a. 뉴스 목록 조회
------------------------------------------------------------------------
select news.news_sid, news.proj_no, news_no, news_title, news_cont, news_write_date
        ,atch_file_sid
        ,writer.mem_no
        ,writer.mem_pic_file_name
        ,writerp.proj_user_nick as mem_nick
        ,news_com_no, news_com_cont, news_com_date
        ,commenter.mem_no commenterMemno
        ,commenter.mem_pic_file_name as commenterPicture
        ,commenterp.proj_user_nick as commenterNickname
from news
    inner join member writer on (news.mem_no = writer.mem_no)
    inner join proj_mem writerp on (news.proj_no = writerp.proj_no
                                    and writer.mem_no = writerp.mem_no)
    left outer join news_comment nc on (news.news_sid = nc.news_sid)
    left outer join member commenter on (nc.mem_no = commenter.mem_no)
    left outer join proj_mem commenterp on (news.proj_no = commenterp.proj_no
                                    and commenter.mem_no = commenterp.mem_no)
where proj_no = 1                               
order by news.news_sid desc;
-----------------------------------------------------------------------------------




-----------------------------3. Kanban--------------------------------------------------
-- a. 칸반 불러오기

-----------------------------------------------------------------------------------

-- a. 칸반 불러오기
with cards as (
    select rownum rn, kb_col_no, kb_card_no 
            ,kb_card_priv_no, issue_sid, kb_card_cont, kb_card_write_date
            , mem_no
    from  kanban_card 
    start with kb_card_priv_no is null
    connect by prior kb_card_no = kb_card_priv_no
)
, issues as (
    select issue.issue_sid, issue.issue_no
            ,issue_title, issue_end_date, issue_status, issue_priority
            ,writer.mem_no as issue_writer_no
            ,writer.mem_pic_file_name as issue_writer_pic
            ,writer_pm.proj_user_nick as issue_writer_nick
            ,milestone.milest_sid, milestone.milest_title
            ,label.label_no, label.label_nm
            ,assignee_pm.mem_no as assignee_mem_no
            ,assignee_pm.proj_user_nick as assignee_mem_nick
    from issue
        inner join member writer on (issue.mem_no = writer.mem_no)
        left outer join proj_mem writer_pm on (writer.mem_no = writer_pm.mem_no and issue.proj_no = writer_pm.proj_no)
        left outer join milestone on (issue.milest_sid = milestone.milest_sid)
        left outer join label on (issue.label_no = label.label_no)
        left outer join issue_assignee on (issue.issue_sid = issue_assignee.issue_sid)
        left outer join member assignee on (issue_assignee.mem_no = assignee.mem_no)
        left outer join proj_mem assignee_pm on (assignee.mem_no = assignee_pm.mem_no and issue.proj_no = assignee_pm.proj_no)
)
select kanban.KB_COL_NO
        , KB_COL_PRIV_NO , kanban.PROJ_NO , KB_COL_NM 
        , cards.*
        , card_writer.mem_no as card_writer_mem_no
        , card_writer_proj.proj_user_nick as card_writer_nick
        , issues.*
from kanban_col kanban
        left outer join cards on (kanban.kb_col_no =cards.kb_col_no)
        left outer join member card_writer on (cards.mem_no = card_writer.mem_no)
        left outer join proj_mem card_writer_proj on (card_writer.mem_no = card_writer_proj.mem_no and kanban.proj_no = card_writer_proj.proj_no)
        left outer join issues on (cards.issue_sid = issues.issue_sid)
where kanban.proj_no = 1
start with kanban.kb_col_priv_no is null
connect by prior kanban.kb_col_no = kanban.kb_col_priv_no
order siblings by rn;
-----------------------------------------------------------------------------------


-----------------------------4. Milestone------------------------------------------
-- a. milestone 완성도 조회

-----------------------------------------------------------------------------------
-- a. milestone 완성도 조회
select milest_title, sum(issue.issue_status)/count(issue.issue_status) * 100 as milest_percent
from milestone
    left outer join issue on (milestone.milest_sid = issue.milest_sid)
where milestone.proj_no = 1
group by milest_title;

-----------------------------5. Project ------------------------------------------
-- a. member 닉네임과 project 이름으로 (url) 프로젝트 번호 알아내기

-----------------------------------------------------------------------------------

-- a. member 닉네임과 project 이름으로 (url) 프로젝트 번호 알아내기
-----------------------------------------------------------------------------------
select proj_no
from project 
    inner join member on (project.mem_no = member.mem_no)
where proj_title = 'testproject'
    and mem_nick = 'kkobuk';
-----------------------------------------------------------------------------------


