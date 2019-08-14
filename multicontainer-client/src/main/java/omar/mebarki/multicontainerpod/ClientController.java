package omar.mebarki.multicontainerpod;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class ClientController {
    private RestTemplate restTemplate = new RestTemplate();

    @RequestMapping("/client")
    public String client() {
        return restTemplate.getForEntity("http://127.0.0.1:8081/hello", String.class).getBody();
    }
}
