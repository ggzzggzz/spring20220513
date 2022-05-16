package com.choong.spr.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choong.spr.domain.BoardDto;
import com.choong.spr.mapper.BoardMapper;

@Service
public class BoardService {

	@Autowired
	private BoardMapper mapper;
	
	public List<BoardDto> getList() {
		return mapper.getList();
	}

	public boolean writeBoard(BoardDto board) {
		board.setInserted(LocalDateTime.now());
		int cnt = mapper.writeBoard(board);
		
		return cnt == 1;
	}

	public BoardDto getBoard(int id) {
		return mapper.getBoard(id);
	}

	public boolean updateBoard(BoardDto board) {
		int cnt = mapper.updateBoard(board);
		
		return cnt == 1;
	}

}
