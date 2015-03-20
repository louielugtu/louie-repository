package com.louie.pdc.pie;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Test class for SFTP Adapters
 *
 * @author louie.lugtu
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:/config/sftp/pie-integration-context.xml"})
public class RunApplication {

	private static final Logger LOGGER = LoggerFactory.getLogger(RunApplication.class);
	
	/**
	 * Test method to validate sftp transfers.
	 *
	 */
	@Test
	public void run() {
		try {
			Thread.sleep(10000);
		} catch (InterruptedException e) {
			LOGGER.error("Error occured while sleeping.", e);
		}
	}
}
