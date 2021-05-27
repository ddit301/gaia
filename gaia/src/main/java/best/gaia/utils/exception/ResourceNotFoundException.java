package best.gaia.utils.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

//존재하지 않는 프로젝트 조회시 404 에러를 보내기 위해 만든 custom Exception 입니다.
	@ResponseStatus(value = HttpStatus.NOT_FOUND, reason = "No such project")
public class ResourceNotFoundException extends RuntimeException  {

}
