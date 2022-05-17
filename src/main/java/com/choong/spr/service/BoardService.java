package com.choong.spr.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.choong.spr.domain.BoardDto;
import com.choong.spr.mapper.BoardMapper;
import com.choong.spr.mapper.ReplyMapper;

@Service
public class BoardService {

	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	

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

	@Transactional
	public boolean removeBoard(int id) {
		replyMapper.deleteAllReply(id);
		
		int cnt = mapper.removeBoard(id);
		
		return cnt == 1;
	}

	public List<BoardDto> searchBoard(String searchKeyword) {
		return mapper.searchBoard(searchKeyword);
	}

	public List<BoardDto> pagingBoard(int page, int rowPerPage) {
		
		int from = (page - 1) * rowPerPage;
		
		return mapper.pagingBoard(from, rowPerPage);
	}

	public int countBoard() {
		return mapper.countBoard();
	}

}
