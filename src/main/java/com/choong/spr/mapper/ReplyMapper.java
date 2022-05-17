package com.choong.spr.mapper;

import java.util.List;

import com.choong.spr.domain.ReplyDto;

public interface ReplyMapper {

	List<ReplyDto> getReply(int boardId);

	void deleteAllReply(int boardId);

	int insertReply(ReplyDto reply);

	int modifyReply(ReplyDto reply);

	int removeReply(ReplyDto reply);

}
