package codesquad.TodoList.domain;

import java.util.ArrayList;
import java.util.List;

public class CardList {
    private List<Card> todo = new ArrayList<>();
    private List<Card> doing = new ArrayList<>();
    private List<Card> done = new ArrayList<>();

    public CardList(List<Card> cards) {
        for(Card card : cards) {
            switch (card.getStatus()) {
                case todo:
                    todo.add(card);
                    break;
                case doing:
                    doing.add(card);
                    break;
                case done:
                    done.add(card);
                    break;
            }
        }
    }

    public List<Card> getTodo() {
        return todo;
    }

    public List<Card> getDoing() {
        return doing;
    }

    public List<Card> getDone() {
        return done;
    }

    @Override
    public String toString() {
        return "CardList{" +
                "todo=" + todo +
                ", doing=" + doing +
                ", done=" + done +
                '}';
    }
}
