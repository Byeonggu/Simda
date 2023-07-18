package ssafy.a709.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ssafy.a709.domain.Comment;
import ssafy.a709.domain.Feed;
import ssafy.a709.domain.User;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class CommentDto {

    // Comment Id
    private int cmtId;

    // Many(User Id) to One(User Id)
    private UserDto userDto;

    // Many(Feed Id) to One(Feed Id)
    private FeedDto feedDto;

    // Many(Parent Comment Id) to One(User Commet)
    private CommentDto commentDto;

    // Content
    private String content;

    // Comment(Entity)를 CommentDto로 변환
    public static CommentDto changeToCommentDto(Comment comment){
        return CommentDto.builder()
                .cmtId(comment.getCmtId())
                .userDto(UserDto.changeToUserDto(comment.getUser()))
                .feedDto(FeedDto.changeToFeedDto(comment.getFeed()))
                .commentDto(CommentDto. changeToCommentDto(comment.getComment()))
                .content(comment.getContent())
                .build();
    }
}
