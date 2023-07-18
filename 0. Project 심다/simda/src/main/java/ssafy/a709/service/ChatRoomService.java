package ssafy.a709.service;

import ssafy.a709.dto.ChatRoomDTO;

import java.util.List;

public interface ChatRoomService {
    //해당 유저의 채팅방 목록 가져오기
    public List<ChatRoomDTO> allChatRoomList(int userId);

    //해당 유저가 채팅방 목록 생성하기
    public int createChatRoom(int user1Id, int user2Id);
}
