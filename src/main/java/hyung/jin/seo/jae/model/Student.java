package hyung.jin.seo.jae.model;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Student implements Serializable{
    
    private long id;
    private String firstName;
    private String lastName;
    
    public Student(Long id, String first, String last){
        this.id = id;
        this.firstName = first;
        this.lastName = last;
    }
    
}
