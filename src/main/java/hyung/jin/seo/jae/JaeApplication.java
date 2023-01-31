package hyung.jin.seo.jae;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.boot.CommandLineRunner;

@SpringBootApplication(exclude = { SecurityAutoConfiguration.class})
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
        System.out.println("TEST");
    }
	
}