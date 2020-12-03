package org.joongmae.server;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class WebSocketBasicServer extends TextWebSocketHandler {

	private static List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	//접속시 실행되는 메소드
	//session: 사용자의 웹소켓 정보(httpSession 아님!)
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		log.info("연결됨 : " + session.getId());
		System.out.println("채팅방 입장자: " + session.getPrincipal().getName());
	}

	
	
	//메시지 수신 시 실행될 메소드
		//-message: 사용자가 전송한 메세지 정보
		// - payload: 실제 보낸 내용
		// - byteCount: 보낸 메세지 크기
		// - last: 메세지 종료 여부
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("{}로부터 {} 받음" + session.getId() + message.getPayload());
		
		for(WebSocketSession sess : sessionList){
			sess.sendMessage(new TextMessage(session.getPrincipal().getName() + "|" + message.getPayload()));
		}
	}


	//사용자 접속 종료시 실행되는 메소드
	// - status: 접속이 종료된 원인과 관련된 정보
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		log.info("{} 연결 끊김." + session.getId());
		System.out.println("채팅방 퇴장자: " + session.getPrincipal().getName());
	}
	
	
	
	
	
	
	
}

