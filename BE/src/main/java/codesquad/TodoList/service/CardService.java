package codesquad.TodoList.service;

import codesquad.TodoList.domain.Card;
import codesquad.TodoList.domain.CardList;
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
    public void create(Card card) {
        cardRepository.save(card);
    }

    public CardList read() {
        CardList cardList = new CardList(cardRepository.findByStatusIsNotDeleted());
        return cardList;
    }

    @Transactional
    public void edit(Long id, Card newCard) {
        Card card = getCardById(id);
        card.update(newCard);
    }

    @Transactional
    public void delete(Long id) {
        Card card = getCardById(id);
        card.setStatus(Card.Status.deleted);
    }

    public Card getCardById(Long id) {
        return cardRepository.findById(id).orElseThrow(NullPointerException::new);
    }
}
