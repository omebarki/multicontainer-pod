package omar.mebarki.multicontainerpod;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {

    private int number = 0;

    @RequestMapping("/hello")
    public String hello() {
        return "Hello World! " + (++number);
    }
}
