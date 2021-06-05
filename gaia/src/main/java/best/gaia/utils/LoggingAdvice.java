package best.gaia.utils;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
public class LoggingAdvice {
	private static final Logger logger = LoggerFactory.getLogger(LoggingAdvice.class);

	@Pointcut("execution(* best.gaia..service.*.*(..))")
	public void dummy() {
	}

	@Around("dummy()")
	public Object aroundAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
		Object target = joinPoint.getTarget();
		String className = target.getClass().getName();
		Signature signature = joinPoint.getSignature();
		String methodName = signature.getName();
		Object[] args = joinPoint.getArgs();

		long start = System.currentTimeMillis();

		Object retValue;
		try {
			retValue = joinPoint.proceed(args);
			long end = System.currentTimeMillis();

			logger.info("{}.{}({}) 의 실행 결과 : {}\n 소요 시간 : {}ms", className, methodName, args, retValue, (end - start));
			return retValue;
		} catch (Throwable e) {
			logger.error(String.format("%s.%s(%s)", className, methodName, args), e);
			throw e;
		}

	}
}
