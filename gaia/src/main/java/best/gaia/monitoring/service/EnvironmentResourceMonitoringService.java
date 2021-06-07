package best.gaia.monitoring.service;

import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;
import java.lang.management.RuntimeMXBean;
import java.nio.file.FileStore;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;


import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

@Service
public class EnvironmentResourceMonitoringService {

	public void diskSpaceCheck(StringBuffer buffer) throws IOException {
		buffer.append("=================Disk Information=================\n");
		buffer.append("====DRIVE	TOTAL	USED	FREE	USABLE====\n");
		FileSystem fs = FileSystems.getDefault();
		for(Path rd : fs.getRootDirectories()) {
			if(Files.exists(rd) && Files.isDirectory(rd) && Files.isReadable(rd)) {
				FileStore store = Files.getFileStore(rd);
				long total = store.getTotalSpace();
				long usable = store.getUsableSpace();
				long free = store.getUnallocatedSpace();
				long used = total - free;
				buffer.append(String.format("%s[%s] :	%s	%s	%s	%s\n"
							, rd, Files.isReadable(rd)?"Enabled":"Disabled"
							, FileUtils.byteCountToDisplaySize(total) 
							, FileUtils.byteCountToDisplaySize(used) 
							, FileUtils.byteCountToDisplaySize(usable) 
							, FileUtils.byteCountToDisplaySize(free) 
						)
				);
			}
		}
	}
	
	public void osInfo(StringBuffer buffer) {
		OperatingSystemMXBean operatingSystemMXBean = ManagementFactory.getOperatingSystemMXBean();
		String osName = operatingSystemMXBean.getName();
		String osVersion = operatingSystemMXBean.getVersion();
		String osArch = operatingSystemMXBean.getArch();
		int processorCount = operatingSystemMXBean.getAvailableProcessors();
		buffer.append("=================OS Information=================\n");
		buffer.append(String.format("%s [version: %s %s]-%d core\n", osName, osVersion, osArch, processorCount));
		
	}
	
	public void runtimeInfo(StringBuffer buffer) {
		RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
		buffer.append("=================JVM Information=================\n");
		String specName = runtimeMXBean.getSpecName();
		String specVersion = runtimeMXBean.getSpecVersion();
		String specVendor = runtimeMXBean.getSpecVendor();
		buffer.append(String.format("%s %s [%s]\n", specName, specVersion, specVendor));
		String vmName = runtimeMXBean.getVmName();
		String vmVersion = runtimeMXBean.getVmVersion();
		String vmVendor = runtimeMXBean.getVmVendor();
		buffer.append(String.format("%s %s [%s]\n", vmName, vmVersion, vmVendor));
	}
}









