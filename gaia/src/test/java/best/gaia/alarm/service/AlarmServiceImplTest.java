package best.gaia.alarm.service;


import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import best.gaia.TestWebAppConfiguration;
import best.gaia.vo.AlarmVO;

@RunWith(SpringJUnit4ClassRunner.class)
@TestWebAppConfiguration
public class AlarmServiceImplTest {
	
	@Inject
	AlarmService service;

	@Test
	public void test() {
		List<AlarmVO> list = service.selectAlarmList(4);
		for(AlarmVO alarm : list) {
			System.out.println(alarm);
		}
	}

}
