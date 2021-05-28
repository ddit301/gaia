package best.gaia.utils.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

// 세션 내에 조회중인 프로젝트 번호가 없을 경우 보내는 예외
@ResponseStatus(value = HttpStatus.BAD_REQUEST, reason = "No project number selected on your session")
public class ProjNoNotExistInSessionException extends RuntimeException  {

}
