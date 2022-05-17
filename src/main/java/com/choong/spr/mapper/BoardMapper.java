package com.choong.spr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.choong.spr.domain.BoardDto;

public interface BoardMapper {

	int writeBoard(BoardDto board);

	BoardDto getBoard(int id);

	int updateBoard(BoardDto board);

	int removeBoard(int id);

	List<BoardDto> searchBoard(String searchKeyword);

	int countBoard();

	List<BoardDto> pagingBoard(@Param("from") int from, @Param("row") int rowPerPage);

}
