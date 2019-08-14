package omar.mebarki.multicontainerpod;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class ClientController {
    private RestTemplate restTemplate = new RestTemplate();

    @Value("${server.hello.url}")
    private String serverURL;

    @RequestMapping("/client")
    public String client() {
        return restTemplate.getForEntity(serverURL, String.class).getBody();
    }
}
