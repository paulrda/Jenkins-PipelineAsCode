package com.zaizi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class JenkinsPipelineAsCodeApplication {

	public static void main(String[] args) {
		SpringApplication.run(JenkinsPipelineAsCodeApplication.class, args);
		
		System.out.println("**** Testing Hellow World");
	}
}
