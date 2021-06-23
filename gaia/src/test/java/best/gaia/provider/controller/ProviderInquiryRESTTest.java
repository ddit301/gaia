package best.gaia.provider.controller;

import static org.junit.Assert.*;

import javax.inject.Inject;

import org.junit.Test;

import best.gaia.provider.service.ProviderService;
import best.gaia.vo.InquiryCommentVO;

public class ProviderInquiryRESTTest {

	@Inject
	ProviderService service;
	@Test
	public void test() {
		InquiryCommentVO commvo =  service.retrieveInquiryAnswer(4);
		System.out.println(commvo);
	}

}
