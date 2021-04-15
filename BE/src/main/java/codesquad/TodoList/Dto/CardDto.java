package codesquad.TodoList.Dto;

import codesquad.TodoList.domain.Card;

public class CardDto {
    private String title;

    private String contents;

    private Card.Status status;

    public CardDto() {

    }

    public CardDto(String title, String contents, Card.Status status) {
        this.title = title;
        this.contents = contents;
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public String getContents() {
        return contents;
    }

    public Card.Status getStatus() {
        return this.status;
    }

}
