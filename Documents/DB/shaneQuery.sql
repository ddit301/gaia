------------------------------------------------------------------------
-- 이슈 상세정보 보기 
------------------------------------------------------------------------
select a.issue_sid, a.issue_no, a.label_no, label.label_nm
        ,d.mem_no as writer_no, dm.proj_user_nick as writer_nick, d.mem_pic_file_name as writer_pic
        ,a.milest_sid, a.proj_no, a.issue_title
        ,a.issue_create_date, a.issue_start_date, a.issue_end_date
        ,a.issue_status, a.priority, a.progress
        ,c.mem_no, c.mem_id, cm.proj_user_nick as mem_nick, c.mem_pic_file_name
        ,e.issue_his_no, e.issue_sid 
        ,f.mem_no as his_writer_no
        ,fm.proj_user_nick as his_writer_nick, f.mem_pic_file_name as his_writer_pic
        , e.issue_his_cont, e.issue_his_date, e.issue_his_type, e.atch_file_sid
        ,g.milest_title
from issue a
    left outer join issue_assignee b on (a.issue_sid = b.issue_sid)
    inner join member c on (b.mem_no = c.mem_no)
    left outer join proj_mem cm on (a.proj_no = cm.proj_no and c.mem_no = cm.mem_no)
    inner join member d on (a.mem_no = d.mem_no)
    left outer join proj_mem dm on (a.proj_no = dm.proj_no and d.mem_no = dm.mem_no)
    left outer join issue_history e on (a.issue_sid = e.issue_sid)
    left outer join member f on (e.mem_no = f.mem_no)
    left outer join proj_mem fm on (a.proj_no = fm.proj_no and f.mem_no = fm.mem_no)
    left outer join milestone g on (a.milest_sid = g.milest_sid)
    left outer join label on (a.proj_no = label.proj_no and a.label_no = label.label_no)
    inner join project on (a.proj_no = project.proj_no)
    inner join member pm on (project.mem_no = pm.mem_no)
where a.issue_no = 1
      and proj_no = 1;

------------------------------------------------------------------------
-- 뉴스 목록 조회
------------------------------------------------------------------------
select news.news_sid, news.proj_no, news_no, news_title, news_cont, news_write_date
        ,atch_file_sid
        ,writer.mem_no as writerMemno
        ,writer.mem_pic_file_name as writerPicture
        ,writerp.proj_user_nick as writerNickname
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

