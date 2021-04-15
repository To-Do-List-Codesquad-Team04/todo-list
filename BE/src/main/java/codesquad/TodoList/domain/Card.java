package codesquad.TodoList.domain;

import codesquad.TodoList.Dto.CardDto;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;

public class Card {

    public enum Status {
        deleted,
        todo,
        doing,
        done;

        @JsonCreator
        public static Status from(String s) {
            return Status.valueOf(s.toLowerCase());
        }
    }

    @Id
    private Long id;

    private String title;

    private String contents;

    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "Asia/Seoul")
    private LocalDateTime datetime;

    private Status status;

    public Card() {

    }

    public Card(CardDto cardDto) {
        this.title = cardDto.getTitle();
        this.contents = cardDto.getContents();
        this.status = cardDto.getStatus();
        this.datetime = LocalDateTime.now();
    }

    public void update(CardDto updateCardDto) {
        this.title = updateCardDto.getTitle();
        this.contents = updateCardDto.getContents();
        this.status = updateCardDto.getStatus();
    }

    public void delete() {
        this.status = Status.deleted;
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContents() {
        return contents;
    }

    public LocalDateTime getDateTime() {
        return datetime;
    }

    public Status getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return "Card{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", contents='" + contents + '\'' +
                ", dateTime=" + datetime +
                ", status=" + status +
                '}';
    }
}
