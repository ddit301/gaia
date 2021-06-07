package best.gaia.monitoring;

import static org.junit.Assert.*;

import java.lang.Thread.State;
import java.lang.management.ManagementFactory;
import java.lang.management.ThreadInfo;
import java.lang.management.ThreadMXBean;

import org.junit.Before;
import org.junit.Test;

public class ThreadMonitoringTest {
	@Test
	public void testThreadSummary() {
		ThreadMXBean threadMXBean = ManagementFactory.getThreadMXBean();
		long totalThreadCount = threadMXBean.getTotalStartedThreadCount();
		int liveThreadCount = threadMXBean.getThreadCount();
		int daemonTheadCount = threadMXBean.getDaemonThreadCount();
		int peakLiveThreadCount = threadMXBean.getPeakThreadCount();
		System.out.println("=================Thread Summary=================");
		System.out.println("TOTAL	LIVE	PEAK	DAEMON");
		System.out.printf("%d	%d	%d	%d\n"
						, totalThreadCount, liveThreadCount, peakLiveThreadCount, daemonTheadCount);
	}
	
	@Test
	public void testThreadDump() {
		ThreadMXBean threadMXBean = ManagementFactory.getThreadMXBean();
		ThreadInfo[] dump = threadMXBean.dumpAllThreads(true, true);
		System.out.println("=================Thread Dump=================");
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
			System.out.printf("%s-%s[%s] : \n", threadInfo.getThreadName(), threadState, comment);
			StackTraceElement[] stackElements = threadInfo.getStackTrace();
			for(StackTraceElement stack : stackElements) {
				System.out.printf("\t%s\n", stack);
			}
		}				
	}

}
