package best.gaia.monitoring.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import best.gaia.monitoring.service.ClassResourceMonitoringService;
import best.gaia.monitoring.service.EnvironmentResourceMonitoringService;
import best.gaia.monitoring.service.MemoryMonitoringService;
import best.gaia.monitoring.service.ThreadMonitoringService;

@RestController
@RequestMapping("admin/monitoring")
public class MonitoringController {
	@Inject
	private MemoryMonitoringService miService;
	@Inject
	private ClassResourceMonitoringService crService;
	@Inject
	private EnvironmentResourceMonitoringService erService;
	@Inject
	private ThreadMonitoringService tmService;

	@GetMapping(value = "info")
	public Map<String, Object> view() throws IOException {
		Map<String, Object> result = new LinkedHashMap<>();

		Map<String, Object> Environment_Resource = new LinkedHashMap<>();
		Environment_Resource.put("OS_Information", erService.osInfo());
		Environment_Resource.put("JVM_Information", erService.runtimeInfo());
		Environment_Resource.put("Disk_Information", erService.diskSpaceCheck());
		result.put("Environment_Resource", Environment_Resource);

		Map<String, Object> Memory = new LinkedHashMap<>();
		Memory.put("Memory_Usage_Summary", miService.memorySummary());
		Memory.put("Garbage_Collection_Information", miService.gabageCollectionInfo());
		Memory.put("Memory_Pool_Usage_Information", miService.memoryPoolInfo());
		result.put("Memory", Memory);

		Map<String, Object> Class_Resource = new LinkedHashMap<>();
		Class_Resource.put("Compiler_Information", crService.compilerCheck());
		Class_Resource.put("Class_Loading_Information", crService.classLoaderCheck());
		result.put("Class_Resource", Class_Resource);

		Map<String, Object> Thread = new LinkedHashMap<>();
		Thread.put("Thread_Summary", tmService.threadSummary());
		result.put("Thread", Thread);

		return result;
	}

	@GetMapping(value = "threadDump", produces = "application/text; charset=utf-8")
	public StringBuffer threadDump(Model model) throws IOException {
		StringBuffer buffer = new StringBuffer();
		model.addAttribute("info", buffer);
		tmService.threadDump(buffer);
		return buffer;
	}
}
