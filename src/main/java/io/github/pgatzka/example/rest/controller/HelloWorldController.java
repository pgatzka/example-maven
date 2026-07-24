package io.github.pgatzka.example.rest.controller;

import io.github.pgatzka.example.rest.response.HelloWorldResponse;
import java.time.OffsetDateTime;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {

    @GetMapping("/hello-world")
    public ResponseEntity<HelloWorldResponse> helloWorld() {
        return ResponseEntity.ok(new HelloWorldResponse(OffsetDateTime.now()));
    }

}
