package org.example.iutprojectdocker;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {


    /**
     * @return A greeting message that includes the value of the "APP_USER" environment variable, or "World" if it is not set.
     */
    @GetMapping("/")
    public String hello() {
        try {
            String appUser = System.getenv("APP_USER");
            String name = (appUser == null || appUser.isEmpty()) ? "World" : appUser;

            String base = String.format("Hello %s!", name);
            return base;

        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
}