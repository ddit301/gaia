package best.gaia.monitoring.service;

import java.lang.management.ClassLoadingMXBean;
import java.lang.management.CompilationMXBean;
import java.lang.management.ManagementFactory;

import org.springframework.stereotype.Service;

@Service
public class ClassResourceMonitoringService {

	public void compilerCheck(StringBuffer buffer) {
		CompilationMXBean compilationMXBean =  ManagementFactory.getCompilationMXBean();
		if(compilationMXBean.isCompilationTimeMonitoringSupported()) {
			String compilerName = compilationMXBean.getName();
			long compileTime = compilationMXBean.getTotalCompilationTime();
			buffer.append("=================Compiler Information=================\n");
			buffer.append(String.format("%s : %.3fms\n", compilerName, compileTime/1000d));
		}
	}
	
	public void classLoaderCheck(StringBuffer buffer) {
		ClassLoadingMXBean classLoadingMXBean = ManagementFactory.getClassLoadingMXBean();
		int loadedCount = classLoadingMXBean.getLoadedClassCount();
		long unloadedCount = classLoadingMXBean.getUnloadedClassCount();
		long totalCount = classLoadingMXBean.getTotalLoadedClassCount();
		buffer.append("=================Class Loading Information=================\n");
		buffer.append(String.format("%d[loaded class count] + %d[unloaded class count] = %d[total loaded class since JVM started]\n"
				, loadedCount, unloadedCount, totalCount));
	}

}
