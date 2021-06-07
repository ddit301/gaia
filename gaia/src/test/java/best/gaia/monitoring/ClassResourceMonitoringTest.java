package best.gaia.monitoring;

import static org.junit.Assert.*;

import java.lang.management.ClassLoadingMXBean;
import java.lang.management.CompilationMXBean;
import java.lang.management.ManagementFactory;

import org.junit.Test;

public class ClassResourceMonitoringTest {

	@Test
	public void compilerCheck() {
		CompilationMXBean compilationMXBean =  ManagementFactory.getCompilationMXBean();
		if(compilationMXBean.isCompilationTimeMonitoringSupported()) {
			String compilerName = compilationMXBean.getName();
			long compileTime = compilationMXBean.getTotalCompilationTime();
			System.out.println("=================Compiler Information=================");
			System.out.printf("%s : %.3fms\n", compilerName, compileTime/1000d);
		}
	}
	
	@Test
	public void classLoaderCheck() {
		ClassLoadingMXBean classLoadingMXBean = ManagementFactory.getClassLoadingMXBean();
		int loadedCount = classLoadingMXBean.getLoadedClassCount();
		long unloadedCount = classLoadingMXBean.getUnloadedClassCount();
		long totalCount = classLoadingMXBean.getTotalLoadedClassCount();
		System.out.println("=================Class Loading Information=================");
		System.out.printf("%d[loaded class count] + %d[unloaded class count] = %d[total loaded class since JVM started]\n"
				, loadedCount, unloadedCount, totalCount);
	}

}
