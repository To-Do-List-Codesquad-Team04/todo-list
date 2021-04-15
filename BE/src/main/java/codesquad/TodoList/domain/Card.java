package codesquad.TodoList.domain;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;
import java.util.Locale;

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
    private LocalDateTime dateTime = LocalDateTime.now();

    private Status status;

    public void update(Card card) {
        this.title = card.title;
        this.contents = card.contents;
        this.status = card.status;
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDateTime createDate) {
        this.dateTime = createDate;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Status getStatus() {
        return this.status;
    }

    @Override
    public String toString() {
        return "Card{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", contents='" + contents + '\'' +
                ", dateTime=" + dateTime +
                ", status=" + status +
                '}';
    }
}
