package ssafy.a709.simda.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ssafy.a709.simda.domain.Follow;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class FollowDto {

    // FollowId
    private int followId;
    // Many(From UserId) to One(UserId)
    private UserDto fromUser;
    // Many(To UserId) to One(UserId)
    private UserDto toUser;

    public static FollowDto changeToFollowDto(Follow follow) {

        return FollowDto.builder()
                .followId(follow.getFollowId())
                .fromUser(UserDto.changeToUserDto(follow.getFromUserId()))
                .toUser(UserDto.changeToUserDto(follow.getToUserId()))
                .build();
    }

}
