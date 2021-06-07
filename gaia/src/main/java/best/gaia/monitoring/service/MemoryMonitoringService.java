package best.gaia.monitoring.service;

import java.lang.management.GarbageCollectorMXBean;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryPoolMXBean;
import java.lang.management.MemoryUsage;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

@Service
public class MemoryMonitoringService {

	public void memorySummary(StringBuffer buffer) {
		MemoryMXBean memoryMXBean = ManagementFactory.getMemoryMXBean();
		MemoryUsage heapUsage = memoryMXBean.getHeapMemoryUsage();
		MemoryUsage nonHeapUsage = memoryMXBean.getNonHeapMemoryUsage();
		buffer.append("=================Memory Usage Summary=================\n");
		printMemoryUsage(buffer, "Heap Memory", heapUsage);
		printMemoryUsage(buffer, "Non Heap Memory", nonHeapUsage);
	}
	
	private void printMemoryUsage(StringBuffer buffer, String memoryName, MemoryUsage memoryUsage) {
		buffer.append(String.format("-----------------%s Usage-----------------\n", memoryName));
		buffer.append(String.format("init:%s, commited:%s, used:%s, max:%s\n" 
						, FileUtils.byteCountToDisplaySize(memoryUsage.getInit())
						, FileUtils.byteCountToDisplaySize(memoryUsage.getCommitted())
						, FileUtils.byteCountToDisplaySize(memoryUsage.getUsed())
						, FileUtils.byteCountToDisplaySize(memoryUsage.getMax())
					)
		);
	}

	public void memoryPoolInfo(StringBuffer buffer) {
		List<MemoryPoolMXBean> memoryPoolMXBeans = ManagementFactory.getMemoryPoolMXBeans();
		buffer.append("=================Memory Pool Usage Information=================\n");
		for(MemoryPoolMXBean memoryPoolMXBean : memoryPoolMXBeans) {
			testMemoryPoolMXBean(buffer, memoryPoolMXBean);
		}
	}
	
	private void testMemoryPoolMXBean(StringBuffer buffer, MemoryPoolMXBean memoryPoolMXBean) {
		String memoryPoolName = memoryPoolMXBean.getName();
		buffer.append(String.format("=================%s Area=================\n", memoryPoolName));
		MemoryUsage usage = memoryPoolMXBean.getUsage();
		if(memoryPoolMXBean.isUsageThresholdSupported())
			printMemoryUsage(buffer, "current ", usage);
		MemoryUsage collectionUsage = memoryPoolMXBean.getCollectionUsage();
		if(memoryPoolMXBean.isCollectionUsageThresholdSupported())
			printMemoryUsage(buffer, "after GC ", collectionUsage);
		MemoryUsage peakUsage = memoryPoolMXBean.getPeakUsage();
		printMemoryUsage(buffer, "peak ", peakUsage);
		buffer.append("=============================================================\n");
	}
	
	public void gabageCollectionInfo(StringBuffer buffer) {
		List<GarbageCollectorMXBean> garbageCollectorMXBeans = ManagementFactory.getGarbageCollectorMXBeans();
		buffer.append("=================Garbage Collection Information=================\n");
		for(GarbageCollectorMXBean garbageCollectorMXBean : garbageCollectorMXBeans) {
			testGarbageCollectorMXBean(buffer, garbageCollectorMXBean);
		}
	}
	
	private void testGarbageCollectorMXBean(StringBuffer buffer, GarbageCollectorMXBean garbageCollectorMXBean) {
		if(!garbageCollectorMXBean.isValid()) return;
		String[] poolNames = garbageCollectorMXBean.getMemoryPoolNames();
		long gcCount = garbageCollectorMXBean.getCollectionCount();
		long gcTime = garbageCollectorMXBean.getCollectionTime();
		buffer.append(String.format("%s : GC Count[%d], Time[%dms]\n"
						, Arrays.toString(poolNames), gcCount, gcTime));
	}
	

}
