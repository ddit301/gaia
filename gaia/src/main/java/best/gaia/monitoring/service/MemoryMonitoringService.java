package best.gaia.monitoring.service;

import java.lang.management.GarbageCollectorMXBean;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryPoolMXBean;
import java.lang.management.MemoryUsage;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

@Service
public class MemoryMonitoringService {
//1
	public Map<String, Object> memorySummary() {
		Map<String, Object> result = new LinkedHashMap<>();
		MemoryMXBean memoryMXBean = ManagementFactory.getMemoryMXBean();
		MemoryUsage heapUsage = memoryMXBean.getHeapMemoryUsage();
		MemoryUsage nonHeapUsage = memoryMXBean.getNonHeapMemoryUsage();
//		buffer.append("=================Memory Usage Summary=================\n");
		result.put("Heap Memory Usage", printMemoryUsage(heapUsage));
		result.put("Non Heap Memory Usage", printMemoryUsage(nonHeapUsage));
		
		return result;
	}
	
	private Map<String, Object> printMemoryUsage(MemoryUsage memoryUsage) {
		Map<String, Object> result = new LinkedHashMap<>();
		result.put("init", memoryUsage.getInit());
		result.put("commited", memoryUsage.getCommitted());
		result.put("used", memoryUsage.getUsed());
		result.put("max", memoryUsage.getMax());
//		
//		buffer.append(String.format("-----------------%s Usage-----------------\n", memoryName));
//		buffer.append(String.format("init:%s, commited:%s, used:%s, max:%s\n" 
//						, FileUtils.byteCountToDisplaySize(memoryUsage.getInit())
//						, FileUtils.byteCountToDisplaySize(memoryUsage.getCommitted())
//						, FileUtils.byteCountToDisplaySize(memoryUsage.getUsed())
//						, FileUtils.byteCountToDisplaySize(memoryUsage.getMax())
//					)
//		);
		return result;
	}
//3
	public Map<String, Object> memoryPoolInfo() {
		Map<String, Object> result = new LinkedHashMap<>();
		
		List<MemoryPoolMXBean> memoryPoolMXBeans = ManagementFactory.getMemoryPoolMXBeans();
//		buffer.append("=================Memory Pool Usage Information=================\n");
		for(MemoryPoolMXBean memoryPoolMXBean : memoryPoolMXBeans) {
			result.put(memoryPoolMXBean.getName() + "Area", testMemoryPoolMXBean(memoryPoolMXBean));
		}
		return result;
	}
	
	private Map<String, Object> testMemoryPoolMXBean(MemoryPoolMXBean memoryPoolMXBean) {
		Map<String, Object> result = new LinkedHashMap<>();
//		String memoryPoolName = memoryPoolMXBean.getName();
//		buffer.append(String.format("=================%s Area=================\n", memoryPoolName));
		MemoryUsage usage = memoryPoolMXBean.getUsage();
		if(memoryPoolMXBean.isUsageThresholdSupported())
			result.put("current Usage", printMemoryUsage(usage));
		MemoryUsage collectionUsage = memoryPoolMXBean.getCollectionUsage();
		if(memoryPoolMXBean.isCollectionUsageThresholdSupported())
			result.put("after GC Usage", printMemoryUsage(collectionUsage));
		MemoryUsage peakUsage = memoryPoolMXBean.getPeakUsage();
		result.put("peak Usage", printMemoryUsage(peakUsage));
//		buffer.append("=============================================================\n");
		return result;
	}
	//2
	public Map<String, Object> gabageCollectionInfo() {
		Map<String, Object> result = new LinkedHashMap<>();
		List<GarbageCollectorMXBean> garbageCollectorMXBeans = ManagementFactory.getGarbageCollectorMXBeans();
//		buffer.append("=================Garbage Collection Information=================\n");
		for(GarbageCollectorMXBean garbageCollectorMXBean : garbageCollectorMXBeans) {
			if(!garbageCollectorMXBean.isValid()) return null;
			String[] poolNames = garbageCollectorMXBean.getMemoryPoolNames();
			long gcCount = garbageCollectorMXBean.getCollectionCount();
			long gcTime = garbageCollectorMXBean.getCollectionTime();
			result.put(Arrays.toString(poolNames), (String.format("GC Count[%d], Time[%dms]\n", gcCount, gcTime)).toString());
		}
		return result;
	}
	
//	private Map<String, Object> testGarbageCollectorMXBean(GarbageCollectorMXBean garbageCollectorMXBean) {
//		Map<String, Object> result = new LinkedHashMap<>();
//		if(!garbageCollectorMXBean.isValid()) return null;
//		String[] poolNames = garbageCollectorMXBean.getMemoryPoolNames();
//		long gcCount = garbageCollectorMXBean.getCollectionCount();
//		long gcTime = garbageCollectorMXBean.getCollectionTime();
//		result.put(Arrays.toString(poolNames), (String.format("%s : GC Count[%d], Time[%dms]\n"
//						, gcCount, gcTime)).toString());
//		return result;
//	}
//	

}
