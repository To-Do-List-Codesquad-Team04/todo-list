package codesquad.TodoList.controller;

import codesquad.TodoList.domain.Card;
import codesquad.TodoList.domain.CardList;
import codesquad.TodoList.service.CardService;
import org.springframework.beans.factory.annotation.Autowired;
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
    public void newCard(@RequestBody Card card) {
        cardService.create(card);
    }

    // READ
    @GetMapping()
    public CardList showCards() {
        return cardService.read();
    }

    // UPDATE
    @PutMapping("/cards/{id}")
    public void editCards(@PathVariable Long id, @RequestBody Card newCard) {
        cardService.edit(id, newCard);
    }

    // DELETE
    @DeleteMapping("/cards/{id}")
    public void deleteCards(@PathVariable Long id) {
        cardService.delete(id);
    }
}
