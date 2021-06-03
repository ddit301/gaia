package best.gaia.utils.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

//존재하지 않는 프로젝트 조회시 415 에러를 보내기 위해 만든 custom Exception 입니다.
@ResponseStatus(value=HttpStatus.UNSUPPORTED_MEDIA_TYPE, reason = "not supporting mediaType")
public class UnsupportedMediaTypeException extends RuntimeException{
	
}
