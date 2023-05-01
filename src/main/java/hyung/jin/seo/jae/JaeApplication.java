package hyung.jin.seo.jae;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

import org.springframework.boot.CommandLineRunner;

@SpringBootApplication
public class JaeApplication extends SpringBootServletInitializer implements CommandLineRunner{

    	
	public static void main(String[] args) {
		SpringApplication.run(JaeApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {  
		return builder.sources(JaeApplication.class);
	} 
    
    @Override
    public void run(String... args) throws Exception{
//        String date = "11/06/2023";
//        int weeks = JaeUtils.academicWeeks(date);
//        System.out.println(weeks);
    }
	
}