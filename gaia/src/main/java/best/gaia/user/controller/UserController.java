package best.gaia.user.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.context.WebApplicationContext;

import best.gaia.user.domain.User;
import best.gaia.user.repository.UserRepository;

/**
 * 
 * @author Robin
 * @since 2021. 5. 22
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * 2021. 5. 22  Robin    Initial Commit
 * Copyright (c) 2021 by team SEED All right reserved
 *      </pre>
 */

@Controller
@Component
public class UserController {

	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	private final UserRepository userRepository = new UserRepository();

    @GetMapping("/main")
    public String mainPage(Map<String, Object> model) {
        List<User> Users = userRepository.findAll();
        model.put("Users", Users);
        return "homepage";
    }

    @GetMapping("/admin")
    public String adminPage(Map<String, Object> model) {
        return "adminpage";
    }

    @GetMapping("/User/new")
    public String UserJoinForm(User UserForm) {
        return "UserJoinForm";
    }

    @PostMapping("/User/new")
    public String UserJoin(User UserForm) {
        userRepository.save(UserForm);
        return "redirect:/login";
    }

}
