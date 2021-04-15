package codesquad.TodoList.controller;

import codesquad.TodoList.Dto.CardDto;
import codesquad.TodoList.Dto.CardList;
import codesquad.TodoList.service.CardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class CardController {

    private CardService cardService;

    @Autowired
    public CardController(CardService cardService) {
        this.cardService = cardService;
    }

    // CREATE
    @PostMapping("/cards")
    public ResponseEntity newCard(@RequestBody CardDto cardDto) {
        cardService.create(cardDto);
        return new ResponseEntity<>("SUCCESS", HttpStatus.CREATED);
    }

    // READ
    @GetMapping("/cards")
    public CardList showCards() {
        return cardService.read();
    }

    // UPDATE
    @PutMapping("/cards/{id}")
    public ResponseEntity editCards(@PathVariable Long id, @RequestBody CardDto newCardDto) {
        cardService.edit(id, newCardDto);
        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    // DELETE
    @DeleteMapping("/cards/{id}")
    public ResponseEntity deleteCards(@PathVariable Long id) {
        cardService.delete(id);
        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }
}
