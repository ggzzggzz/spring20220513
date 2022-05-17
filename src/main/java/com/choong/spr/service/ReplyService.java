package com.choong.spr.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choong.spr.domain.ReplyDto;
import com.choong.spr.mapper.ReplyMapper;

@Service
public class ReplyService {

	@Autowired
	private ReplyMapper mapper;
	
	public List<ReplyDto> getReply(int boardId) {
		return mapper.getReply(boardId);
	}

	public boolean insertReply(ReplyDto reply) {
		reply.setInserted(LocalDateTime.now());
		
		int cnt = mapper.insertReply(reply);
		
		return cnt == 1;
	}

	public boolean modifyReply(ReplyDto reply) {
		int cnt = mapper.modifyReply(reply);
		
		return cnt == 1;
	}

	public boolean removeReply(ReplyDto reply) {
		int cnt = mapper.removeReply(reply);
		
		return cnt == 1;
	}

}
