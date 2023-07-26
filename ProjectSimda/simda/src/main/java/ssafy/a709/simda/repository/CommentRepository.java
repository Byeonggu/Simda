package ssafy.a709.simda.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ssafy.a709.simda.domain.Comment;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

    @Query("select c from Comment c where c.feed.feedId = :feedId and c.pComment.cmtId = null")
    List<Comment> findByFeed_FeedIdAndByComment_PCntIdIsNull(@Param("feedId") int feedId);

    @Query("select c from Comment c where c.pComment.cmtId = :pCmtId")
    List<Comment> findByComment_PCommentId(@Param("pCmtId") int pCmtId);
}
