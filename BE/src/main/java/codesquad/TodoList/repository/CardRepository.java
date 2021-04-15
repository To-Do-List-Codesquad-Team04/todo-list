package codesquad.TodoList.repository;

import codesquad.TodoList.domain.Card;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CardRepository extends CrudRepository<Card, Long> {
    @Query("select * from card c where not c.status = 'DELETED'")
    List<Card> findByStatusIsNotDeleted();
}
