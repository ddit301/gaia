------------------------------------------------------------------------
-- 이슈 목록 조회 
------------------------------------------------------------------------
SELECT ISSUE_SID ,ISSUE_NO ,MEM_NO ,LABEL_NO ,MILEST_SID ,PROJ_NO ,ISSUE_TITLE 
    ,ISSUE_CREATE_DATE ,ISSUE_START_DATE ,ISSUE_END_DATE ,ISSUE_STATUS
    ,ISSUE_PRIORITY ,PROGRESS
FROM ISSUE
WHERE proj_no = 1;
------------------------------------------------------------------------
-- 이슈 상세정보 보기 
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
-- 뉴스 목록 조회
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
-- member 닉네임과 project 이름으로 (url) 프로젝트 번호 알아내기
-----------------------------------------------------------------------------------
select proj_no
from project 
    inner join member on (project.mem_no = member.mem_no)
where proj_title = 'testproject'
    and mem_nick = 'kkobuk'
-----------------------------------------------------------------------------------

