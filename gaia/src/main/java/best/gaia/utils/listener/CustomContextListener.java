package best.gaia.utils.listener;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;

@Component
public class CustomContextListener {
	private static final Logger logger = LoggerFactory.getLogger(CustomContextListener.class);
	
	@EventListener(classes = ContextRefreshedEvent.class)
	public void init(ContextRefreshedEvent event) {
		WebApplicationContext root = (WebApplicationContext) event.getApplicationContext();
		ServletContext application = root.getServletContext();
		application.setAttribute("cPath", application.getContextPath());
		logger.info("컨텍스트 시작");
	}
}
