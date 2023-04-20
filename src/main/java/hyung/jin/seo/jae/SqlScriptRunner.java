package hyung.jin.seo.jae;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ResourceLoader;
import org.springframework.jdbc.datasource.init.ScriptUtils;
import org.springframework.stereotype.Component;
import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@Component
public class SqlScriptRunner {

    @Autowired
    private ResourceLoader resourceLoader;

    @Autowired
    private DataSource dataSource;
    
    @Autowired
    private Environment env;

    @PostConstruct
    public void runSqlScripts() throws SQLException {
    	String ddl = env.getProperty("spring.jpa.hibernate.ddl-auto");
    	// run scripts only for 'create-drop'
    	if("create-drop".equalsIgnoreCase(ddl)) { 
	        Connection connection = dataSource.getConnection();
	        ScriptUtils.executeSqlScript(connection, resourceLoader.getResource("classpath:sql/elearning.sql")); // eLearning 
	        ScriptUtils.executeSqlScript(connection, resourceLoader.getResource("classpath:sql/course.sql")); // Course
	        ScriptUtils.executeSqlScript(connection, resourceLoader.getResource("classpath:sql/course_fee.sql")); // Course Fee
	        ScriptUtils.executeSqlScript(connection, resourceLoader.getResource("classpath:sql/course_etc.sql")); // Course Fee
	        ScriptUtils.executeSqlScript(connection, resourceLoader.getResource("classpath:sql/braybrook_student.sql")); // Student
    	}
    }
}
