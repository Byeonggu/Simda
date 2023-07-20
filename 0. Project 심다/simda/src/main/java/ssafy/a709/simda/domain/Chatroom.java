package ssafy.a709.simda.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ssafy.a709.simda.dto.ChatRoomDTO;

import javax.persistence.*;
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table

public class Chatroom {
    public static Chatroom chageToChatroom(ChatRoomDTO chatRoomDTO){
        return Chatroom.builder()
                .chatroomId(chatRoomDTO.getChatRoomId())
                .user1(User.changeToUser(chatRoomDTO.getUser1()))
                .user2(User.changeToUser(chatRoomDTO.getUser2()))
                .chat(Chat.chageToChat(chatRoomDTO.getLChat()))
                .build();
    };
    public static Chatroom chageToChatroomForTrans(ChatRoomDTO chatRoomDTO){
        return Chatroom.builder()
                .chatroomId(chatRoomDTO.getChatRoomId())
                .user1(User.changeToUser(chatRoomDTO.getUser1()))
                .user2(User.changeToUser(chatRoomDTO.getUser2()))
                .build();
    };



    // Chatroom Id
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "chatroom_id")
    private int chatroomId;

    // Many(User1 Id) to One(User Id)
    @ManyToOne
    @JoinColumn(name = "user1_id", referencedColumnName = "user_id")
    private User user1;

    // Many(User2 Id) to One(User Id)
    @ManyToOne
    @JoinColumn(name = "user2_id", referencedColumnName = "user_id")
    private User user2;

    // One(Last Chat Id) to One(Chat Id)
    @OneToOne
    @JoinColumn(name = "l_chat_id", nullable = true, referencedColumnName = "chat_id")
    private Chat chat;

    public void update(Chat chat){
        this.chat = chat;
    }
}
