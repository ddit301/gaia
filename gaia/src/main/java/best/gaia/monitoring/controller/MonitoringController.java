package best.gaia.monitoring.controller;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import best.gaia.monitoring.service.ClassResourceMonitoringService;
import best.gaia.monitoring.service.EnvironmentResourceMonitoringService;
import best.gaia.monitoring.service.MemoryMonitoringService;
import best.gaia.monitoring.service.ThreadMonitoringService;

@Controller
@RequestMapping("/monitoring")
public class MonitoringController {
	@Inject
	private MemoryMonitoringService miService;
	@Inject
	private ClassResourceMonitoringService crService;
	@Inject
	private EnvironmentResourceMonitoringService erService;
	@Inject
	private ThreadMonitoringService tmService;
	
	@RequestMapping
	public String view(Model model) throws IOException {
		StringBuffer buffer = new StringBuffer();
		model.addAttribute("info", buffer);
		erService.osInfo(buffer);
		erService.runtimeInfo(buffer);
		erService.diskSpaceCheck(buffer);
		miService.memorySummary(buffer);
		miService.gabageCollectionInfo(buffer);
		miService.memoryPoolInfo(buffer);
		crService.compilerCheck(buffer);
		crService.classLoaderCheck(buffer);
		tmService.threadSummary(buffer);
		return "monitor/view";
	}
	@RequestMapping(value="/threadDump", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public StringBuffer threadDump(Model model) throws IOException {
		StringBuffer buffer = new StringBuffer();
		model.addAttribute("info", buffer);
		tmService.threadDump(buffer);
		return buffer;
	}
}
