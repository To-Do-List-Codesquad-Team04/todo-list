package codesquad.TodoList.service;

import codesquad.TodoList.domain.Card;
import codesquad.TodoList.Dto.CardDto;
import codesquad.TodoList.Dto.CardList;
import codesquad.TodoList.repository.CardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CardService {

    private CardRepository cardRepository;

    @Autowired
    public CardService(CardRepository cardRepository) {
        this.cardRepository = cardRepository;
    }

    @Transactional
    public void create(CardDto cardDto) {
        Card card = new Card(cardDto);
        cardRepository.save(card);
    }

    public CardList read() {
        CardList cardList = new CardList(cardRepository.findByStatusIsNotDeleted());
        return cardList;
    }

    @Transactional
    public void edit(Long id, CardDto newCard) {
        Card card = getCardById(id);
        card.update(newCard);
        cardRepository.save(card);
    }

    @Transactional
    public void delete(Long id) {
        Card card = getCardById(id);
        card.delete();
        cardRepository.save(card);
    }

    public Card getCardById(Long id) {
        return cardRepository.findById(id).orElseThrow(NullPointerException::new);
    }
}
