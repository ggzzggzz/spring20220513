package com.choong.spr.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choong.spr.domain.BoardDto;
import com.choong.spr.domain.PageInfoDto;
import com.choong.spr.domain.ReplyDto;
import com.choong.spr.service.BoardService;
import com.choong.spr.service.ReplyService;

@Controller
@RequestMapping("board")
public class BoardController {

	@Autowired
	private BoardService service;
	
	@Autowired
	private ReplyService replyService;
	
	
	
	@GetMapping("write")
	public void write() {
		
	}
	
	@PostMapping("write")
	public String writeProcess(BoardDto board, RedirectAttributes rttr) {
		boolean success = service.writeBoard(board);
		
		rttr.addAttribute("writeSuccess", success);
		
		return "redirect:/board/" + board.getId();
	}
	
	@GetMapping("{id}")
	public String get(@PathVariable("id") int id, Model model) {
		BoardDto board = service.getBoard(id);
		List<ReplyDto> list = replyService.getReply(id);
		
		model.addAttribute("board", board);
		model.addAttribute("replyList", list);
		
		return "board/get";
	}
	
	@PostMapping("modify")
	public String modify(BoardDto board, RedirectAttributes rttr) {
		boolean success = service.updateBoard(board);
		
		rttr.addAttribute("modifySuccess", success);
		
		return "redirect:/board/" + board.getId();
	}
	
	@PostMapping("remove")
	public String remove(int id, RedirectAttributes rttr) {
		boolean success = service.removeBoard(id);
		
		rttr.addAttribute("removeSuccess", success);
		
		return "redirect:/board/list";
	}
	
//	@GetMapping("search")
//	public String search(String searchKeyword, Model model) {
//		List<BoardDto> board = service.searchBoard(searchKeyword);
//		
//		model.addAttribute("boardList", board);
//		model.addAttribute("searchKeyword", searchKeyword);
//		
//		return "board/list";
//	}
	
	@GetMapping({"paging", "list", "search"})
	public String paging(@RequestParam(name="page", defaultValue = "1") int page, 
			@RequestParam(name="pageNum", defaultValue="5") int rowPerPage, 
			@RequestParam(name="searchKeyword", defaultValue="") String searchKeyword, Model model) {
		List<BoardDto> board = service.pagingBoard(page, rowPerPage, searchKeyword);
		
		int totalCount = service.countBoard(searchKeyword);
		
		int end = totalCount / rowPerPage;
		
		if(totalCount % rowPerPage > 0) {
			end++;
		}
		
		PageInfoDto pageInfo = new PageInfoDto();
		pageInfo.setCurrent(page);
		pageInfo.setEnd(end);
		
		model.addAttribute("boardList", board);
		model.addAttribute("pageNum", rowPerPage);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("count", totalCount);
		
		return "board/list";
	}
}
