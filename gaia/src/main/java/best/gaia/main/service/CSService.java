package best.gaia.main.service;

import java.util.List;

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

public interface CSService {
	
	public int retrieveBoardCount(PagingVO<CSVO> pagingVO);
	public List<CSVO> retrieveBoardList(PagingVO<CSVO> pagingVO);

}
