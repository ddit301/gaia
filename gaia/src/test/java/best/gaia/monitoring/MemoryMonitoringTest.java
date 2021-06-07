package best.gaia.monitoring;

import java.lang.management.GarbageCollectorMXBean;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryPoolMXBean;
import java.lang.management.MemoryUsage;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.Test;

public class MemoryMonitoringTest {

	@Test
	public void memoryCheck() {
		MemoryMXBean memoryMXBean = ManagementFactory.getMemoryMXBean();
		MemoryUsage heapUsage = memoryMXBean.getHeapMemoryUsage();
		MemoryUsage nonHeapUsage = memoryMXBean.getNonHeapMemoryUsage();
		System.out.println("=================Memory Usage Summary=================");
		printMemoryUsage("Heap Memory", heapUsage);
		printMemoryUsage("Non Heap Memory", nonHeapUsage);
	}
	
	private void printMemoryUsage(String memoryName, MemoryUsage memoryUsage) {
		System.out.printf("-----------------%s Usage-----------------\n", memoryName);
		System.out.printf("init:%s, commited:%s, used:%s, max:%s\n" 
				, FileUtils.byteCountToDisplaySize(memoryUsage.getInit())
				, FileUtils.byteCountToDisplaySize(memoryUsage.getCommitted())
				, FileUtils.byteCountToDisplaySize(memoryUsage.getUsed())
				, FileUtils.byteCountToDisplaySize(memoryUsage.getMax())
				);
	}

	@Test
	public void testMemoryPools() {
		List<MemoryPoolMXBean> memoryPoolMXBeans = ManagementFactory.getMemoryPoolMXBeans();
		System.out.println("=================Memory Pool Usage Information=================");
		for(MemoryPoolMXBean memoryPoolMXBean : memoryPoolMXBeans) {
			testMemoryPoolMXBean(memoryPoolMXBean);
		}
	}
	
	private void testMemoryPoolMXBean(MemoryPoolMXBean memoryPoolMXBean) {
		String memoryPoolName = memoryPoolMXBean.getName();
		System.out.printf("=================%s Area=================\n", memoryPoolName);
		MemoryUsage usage = memoryPoolMXBean.getUsage();
		if(memoryPoolMXBean.isUsageThresholdSupported())
			printMemoryUsage("current ", usage);
		MemoryUsage collectionUsage = memoryPoolMXBean.getCollectionUsage();
		if(memoryPoolMXBean.isCollectionUsageThresholdSupported())
			printMemoryUsage("after GC ", collectionUsage);
		MemoryUsage peakUsage = memoryPoolMXBean.getPeakUsage();
		printMemoryUsage("peak ", peakUsage);
		System.out.println("=============================================================");
	}
	
	@Test
	public void testGC() {
		List<GarbageCollectorMXBean> garbageCollectorMXBeans = ManagementFactory.getGarbageCollectorMXBeans();
		System.out.println("=================Garbage Collection Information=================");
		for(GarbageCollectorMXBean garbageCollectorMXBean : garbageCollectorMXBeans) {
			testGarbageCollectorMXBean(garbageCollectorMXBean);
		}
	}
	
	private void testGarbageCollectorMXBean(GarbageCollectorMXBean garbageCollectorMXBean) {
		if(!garbageCollectorMXBean.isValid()) return;
		String[] poolNames = garbageCollectorMXBean.getMemoryPoolNames();
		long gcCount = garbageCollectorMXBean.getCollectionCount();
		long gcTime = garbageCollectorMXBean.getCollectionTime();
		System.out.printf("%s : GC Count[%d], Time[%dms]\n"
						, Arrays.toString(poolNames), gcCount, gcTime);
	}
	

}
