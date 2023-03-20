package hyung.jin.seo.jae;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

import hyung.jin.seo.jae.model.Student;
import hyung.jin.seo.jae.repository.StudentRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;

@SpringBootApplication
public class JaeApplication extends SpringBootServletInitializer implements CommandLineRunner{

    
	@Autowired
	StudentRepository studentRepository;
	
	public static void main(String[] args) {
		SpringApplication.run(JaeApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {  
		return builder.sources(JaeApplication.class);
	} 
    
    @Override
    public void run(String... args) throws Exception{
        /*
    	System.out.println("TEST");
        Student std = new Student();
        std.setFirstName("Sammy");
        std.setLastName("Sosa");
        std.setContactNo1("0433");
        std.setContactNo2("195");
        std.setEmail("abc@abc.net");
        std.setGrade("P5");
        std.setMemo("Nothing");
        std.setState("QLD");
        std.setAddress("Balwn");
        std.setBranch("box");
        studentRepository.save(std);
        */
        
    }
	
}