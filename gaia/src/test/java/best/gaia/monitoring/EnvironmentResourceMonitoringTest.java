package best.gaia.monitoring;

import java.io.IOException;
import java.lang.Thread.State;
import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;
import java.lang.management.RuntimeMXBean;
import java.lang.management.ThreadInfo;
import java.lang.management.ThreadMXBean;
import java.nio.file.FileStore;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;

import org.apache.commons.io.FileUtils;
import org.junit.Test;

public class EnvironmentResourceMonitoringTest {

	@Test
	public void diskSpaceCheck() throws IOException {
		System.out.println("=================Disk Information=================");
		System.out.println("====DRIVE	TOTAL	USED	FREE	USABLE====");
		FileSystem fs = FileSystems.getDefault();
		for(Path rd : fs.getRootDirectories()) {
			if(Files.exists(rd) && Files.isDirectory(rd) && Files.isReadable(rd)) {
				FileStore store = Files.getFileStore(rd);
				long total = store.getTotalSpace();
				long usable = store.getUsableSpace();
				long free = store.getUnallocatedSpace();
				long used = total - free;
				System.out.printf("%s[%s] :	%s	%s	%s	%s\n"
						, rd, Files.isReadable(rd)?"Enabled":"Disabled"
						, FileUtils.byteCountToDisplaySize(total) 
						, FileUtils.byteCountToDisplaySize(used) 
						, FileUtils.byteCountToDisplaySize(usable) 
						, FileUtils.byteCountToDisplaySize(free) 
						);
			}else {
				System.out.printf("%s[%s]\n"
						, rd, Files.isReadable(rd)?"Enabled":"Disabled");
			}
		}
	}
	
	@Test
	public void testOSMXBean() {
		OperatingSystemMXBean operatingSystemMXBean = ManagementFactory.getOperatingSystemMXBean();
		String osName = operatingSystemMXBean.getName();
		String osVersion = operatingSystemMXBean.getVersion();
		String osArch = operatingSystemMXBean.getArch();
		int processorCount = operatingSystemMXBean.getAvailableProcessors();
		System.out.println("=================OS Information=================");
		System.out.printf("%s [version: %s %s]-%d core\n", osName, osVersion, osArch, processorCount);
		
	}
	
	@Test
	public void testRuntime() {
		RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
		System.out.println("=================JVM Information=================");
		String specName = runtimeMXBean.getSpecName();
		String specVersion = runtimeMXBean.getSpecVersion();
		String specVendor = runtimeMXBean.getSpecVendor();
		System.out.printf("%s %s [%s]\n", specName, specVersion, specVendor);
		String vmName = runtimeMXBean.getVmName();
		String vmVersion = runtimeMXBean.getVmVersion();
		String vmVendor = runtimeMXBean.getVmVendor();
		System.out.printf("%s %s [%s]\n", vmName, vmVersion, vmVendor);
	}
}









