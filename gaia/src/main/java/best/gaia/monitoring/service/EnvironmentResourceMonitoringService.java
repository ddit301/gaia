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
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

@Service
public class EnvironmentResourceMonitoringService {
//3
	public Map<String, Object> diskSpaceCheck() throws IOException {
		Map<String, Object> result = new LinkedHashMap<>();

		FileSystem fs = FileSystems.getDefault();
		for (Path rd : fs.getRootDirectories()) {
			if (Files.exists(rd) && Files.isDirectory(rd) && Files.isReadable(rd)) {
				FileStore store = Files.getFileStore(rd);
				long total = store.getTotalSpace();
				long usable = store.getUsableSpace();
				long free = store.getUnallocatedSpace();
				long used = total - free;
				result.put("drive", rd + "- " + (Files.isReadable(rd) ? "Enabled" : "Disabled"));
				result.put("total", FileUtils.byteCountToDisplaySize(total));
				result.put("used", FileUtils.byteCountToDisplaySize(used));
				result.put("usable", FileUtils.byteCountToDisplaySize(usable));
				result.put("free", FileUtils.byteCountToDisplaySize(free));
			}
		}
		return result;
	}

	// 1
	public Map<String, Object> osInfo() {
		Map<String, Object> result = new LinkedHashMap<>();
		OperatingSystemMXBean operatingSystemMXBean = ManagementFactory.getOperatingSystemMXBean();
		String osName = operatingSystemMXBean.getName();
		String osVersion = operatingSystemMXBean.getVersion();
		String osArch = operatingSystemMXBean.getArch();
		int processorCount = operatingSystemMXBean.getAvailableProcessors();
		result.put("osName", osName);
		result.put("osVersion", osVersion);
		result.put("osArch", osArch);
		result.put("processorCount", processorCount + "core");

		return result;
	}

	// 2
	public Map<String, Object> runtimeInfo() {
		Map<String, Object> result = new LinkedHashMap<>();
		RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
		String specName = runtimeMXBean.getSpecName();
		String specVersion = runtimeMXBean.getSpecVersion();
		String specVendor = runtimeMXBean.getSpecVendor();
		result.put("specName", specName);
		result.put("specVersion", specVersion);
		result.put("specVendor", "[" + specVendor + "]");
		String vmName = runtimeMXBean.getVmName();
		String vmVersion = runtimeMXBean.getVmVersion();
		String vmVendor = runtimeMXBean.getVmVendor();
		result.put("vmName", vmName);
		result.put("vmVersion", vmVersion);
		result.put("vmVendor", "[" + vmVendor + "]");
		return result;
	}
}
