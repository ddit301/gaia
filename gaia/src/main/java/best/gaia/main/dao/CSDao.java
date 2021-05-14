package best.gaia.main.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import best.gaia.vo.CSVO;
import best.gaia.vo.PagingVO;
/**
 * 
 * @author Robin
 * @since 2021. 5. 14
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * 2021. 5. 14  Robin    Initial Commit
 * Copyright (c) 2021 by team SEED All right reserved
 * </pre>
 */

@Repository
public interface CSDao {
	
	public int countFAQ(PagingVO<CSVO> pagingVO);
	public List<CSVO> selectFAQ(PagingVO<CSVO> pagingVO);

}
