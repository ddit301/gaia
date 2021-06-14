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

import org.springframework.stereotype.Service;

@Service
public class MemoryMonitoringService {
//1
	public Map<String, Object> memorySummary() {
		Map<String, Object> result = new LinkedHashMap<>();
		MemoryMXBean memoryMXBean = ManagementFactory.getMemoryMXBean();
		MemoryUsage heapUsage = memoryMXBean.getHeapMemoryUsage();
		MemoryUsage nonHeapUsage = memoryMXBean.getNonHeapMemoryUsage();
		result.put("Heap Memory Usage", printMemoryUsage(heapUsage));
		result.put("Non Heap Memory Usage", printMemoryUsage(nonHeapUsage));

		return result;
	}

	private Map<String, Object> printMemoryUsage(MemoryUsage memoryUsage) {
		Map<String, Object> result = new LinkedHashMap<>();
		result.put("init", Long.valueOf(memoryUsage.getInit()).intValue());
		result.put("commited", Long.valueOf(memoryUsage.getCommitted()).intValue());
		result.put("used", Long.valueOf(memoryUsage.getUsed()).intValue());
		result.put("max", Long.valueOf(memoryUsage.getMax()).intValue());
		return result;
	}

//3
	public Map<String, Object> memoryPoolInfo() {
		Map<String, Object> result = new LinkedHashMap<>();

		List<MemoryPoolMXBean> memoryPoolMXBeans = ManagementFactory.getMemoryPoolMXBeans();
		for (MemoryPoolMXBean memoryPoolMXBean : memoryPoolMXBeans) {
			result.put(memoryPoolMXBean.getName() + " Area", testMemoryPoolMXBean(memoryPoolMXBean));
		}
		return result;
	}

	private Map<String, Object> testMemoryPoolMXBean(MemoryPoolMXBean memoryPoolMXBean) {
		Map<String, Object> result = new LinkedHashMap<>();
		MemoryUsage usage = memoryPoolMXBean.getUsage();
		if (memoryPoolMXBean.isUsageThresholdSupported())
			result.put("current Usage", printMemoryUsage(usage));
		MemoryUsage collectionUsage = memoryPoolMXBean.getCollectionUsage();
		if (memoryPoolMXBean.isCollectionUsageThresholdSupported())
			result.put("after GC Usage", printMemoryUsage(collectionUsage));
		MemoryUsage peakUsage = memoryPoolMXBean.getPeakUsage();
		result.put("peak Usage", printMemoryUsage(peakUsage));
		return result;
	}

	// 2
	public Map<String, Object> gabageCollectionInfo() {
		Map<String, Object> result = new LinkedHashMap<>();
		List<GarbageCollectorMXBean> garbageCollectorMXBeans = ManagementFactory.getGarbageCollectorMXBeans();
		for (GarbageCollectorMXBean garbageCollectorMXBean : garbageCollectorMXBeans) {
			if (!garbageCollectorMXBean.isValid())
				return null;
			String[] poolNames = garbageCollectorMXBean.getMemoryPoolNames();
			long gcCount = garbageCollectorMXBean.getCollectionCount();
			long gcTime = garbageCollectorMXBean.getCollectionTime();
			result.put(Arrays.toString(poolNames),
					(String.format("GC Count[%d], Time[%dms]\n", gcCount, gcTime)).toString());
		}
		return result;
	}

}
