package best.gaia.monitoring;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

@RunWith(Suite.class)
@SuiteClasses({EnvironmentResourceMonitoringTest.class, ClassResourceMonitoringTest.class, MemoryMonitoringTest.class, ThreadMonitoringTest.class})
public class MonitoringSystemTestSuite {

}
