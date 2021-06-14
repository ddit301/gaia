package best.gaia.monitoring.service;

import java.lang.management.ClassLoadingMXBean;
import java.lang.management.CompilationMXBean;
import java.lang.management.ManagementFactory;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class ClassResourceMonitoringService {

	public Map<String, Object> compilerCheck() {
		Map<String, Object> result = new LinkedHashMap<>();
		CompilationMXBean compilationMXBean = ManagementFactory.getCompilationMXBean();
		if (compilationMXBean.isCompilationTimeMonitoringSupported()) {
			String compilerName = compilationMXBean.getName();
			long compileTime = compilationMXBean.getTotalCompilationTime();
			result.put("compilerName", compilerName);
			result.put("compileTime", compileTime / 1000d + "fms");
		}
		return result;
	}

	public Map<String, Object> classLoaderCheck() {
		Map<String, Object> result = new LinkedHashMap<>();
		ClassLoadingMXBean classLoadingMXBean = ManagementFactory.getClassLoadingMXBean();
		int loadedCount = classLoadingMXBean.getLoadedClassCount();
		long unloadedCount = classLoadingMXBean.getUnloadedClassCount();
		long totalCount = classLoadingMXBean.getTotalLoadedClassCount();
		result.put("loaded class count", loadedCount);
		result.put("unloaded class count", unloadedCount);
		result.put("total loaded class", totalCount);
		return result;
	}

}
