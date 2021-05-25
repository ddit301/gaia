------------------------------------------------------------------------
이슈 상세정보 쿼리
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
        , e.issue_his_cont, e.issue_his_date, e.issue_his_type, e.atch_file_no
        ,g.milest_title
from issue a
    left outer join issue_assignee b on (a.issue_sid = b.issue_sid)
    left outer join member c on (b.mem_no = c.mem_no)
    left outer join proj_mem cm on (a.proj_no = cm.proj_no and c.mem_no = cm.mem_no)
    left outer join member d on (a.mem_no = d.mem_no)
    left outer join proj_mem dm on (a.proj_no = dm.proj_no and d.mem_no = dm.mem_no)
    left outer join issue_history e on (a.issue_sid = e.issue_sid)
    left outer join member f on (e.mem_no = f.mem_no)
    left outer join proj_mem fm on (a.proj_no = fm.proj_no and f.mem_no = fm.mem_no)
    left outer join milestone g on (a.milest_sid = g.milest_sid)
    left outer join label on (a.proj_no = label.proj_no and a.label_no = label.label_no)
where a.issue_sid = 1;

------------------------------------------------------------------------
