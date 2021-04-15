package codesquad.TodoList.controller;

import codesquad.TodoList.Dto.CardDto;
import codesquad.TodoList.Dto.CardList;
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
    public void newCard(@RequestBody CardDto cardDto) {
        cardService.create(cardDto);
    }

    // READ
    @GetMapping("/cards")
    public CardList showCards() {
        return cardService.read();
    }

    // UPDATE
    @PutMapping("/cards/{id}")
    public void editCards(@PathVariable Long id, @RequestBody CardDto newCardDto) {
        cardService.edit(id, newCardDto);
    }

    // DELETE
    @DeleteMapping("/cards/{id}")
    public void deleteCards(@PathVariable Long id) {
        cardService.delete(id);
    }
}
