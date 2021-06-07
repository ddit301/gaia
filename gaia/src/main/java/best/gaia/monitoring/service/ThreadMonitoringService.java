package best.gaia.monitoring.service;

import java.lang.Thread.State;
import java.lang.management.ManagementFactory;
import java.lang.management.ThreadInfo;
import java.lang.management.ThreadMXBean;

import org.springframework.stereotype.Service;

@Service
public class ThreadMonitoringService {
	public void threadSummary(StringBuffer buffer) {
		ThreadMXBean threadMXBean = ManagementFactory.getThreadMXBean();
		long totalThreadCount = threadMXBean.getTotalStartedThreadCount();
		int liveThreadCount = threadMXBean.getThreadCount();
		int daemonTheadCount = threadMXBean.getDaemonThreadCount();
		int peakLiveThreadCount = threadMXBean.getPeakThreadCount();
		buffer.append("=================Thread Summary=================\n");
		buffer.append("TOTAL	LIVE	PEAK	DAEMON\n");
		buffer.append(String.format("%d	%d	%d	%d\n"
						, totalThreadCount, liveThreadCount, peakLiveThreadCount, daemonTheadCount));
	}
	public void threadDump(StringBuffer buffer) {
		ThreadMXBean threadMXBean = ManagementFactory.getThreadMXBean();
		ThreadInfo[] dump = threadMXBean.dumpAllThreads(true, true);
		buffer.append("=================Thread Dump=================\n");
		for(ThreadInfo threadInfo : dump) {
			State threadState = threadInfo.getThreadState();
			String comment = null;
			if(threadState.equals(State.TERMINATED)) {
				comment = "정상 종료";
			}else if(threadState.compareTo(State.RUNNABLE) <= 0) {
				comment = "실행중 혹은 실행 대기중";
			}else {
				comment = "블록 혹은 웨이팅 상태";
			}
			buffer.append(String.format("%s-%s[%s] : \n", threadInfo.getThreadName(), threadState, comment));
			StackTraceElement[] stackElements = threadInfo.getStackTrace();
			for(StackTraceElement stack : stackElements) {
				buffer.append(String.format("\t%s\n", stack));
			}
		}				
	}
}
