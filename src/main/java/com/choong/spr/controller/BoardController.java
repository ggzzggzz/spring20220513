package com.choong.spr.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choong.spr.domain.BoardDto;
import com.choong.spr.service.BoardService;

@Controller
@RequestMapping("board")
public class BoardController {

	@Autowired
	private BoardService service;
	
	@RequestMapping("list")
	public void list(Model model) {
		List<BoardDto> list = service.getList();
		model.addAttribute("boardList", list);
	}
	
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
		
		model.addAttribute("board", board);
		
		return "board/get";
	}
	
	@PostMapping("modify")
	public String modify(BoardDto board, RedirectAttributes rttr) {
		boolean success = service.updateBoard(board);
		
		rttr.addAttribute("modifySuccess", success);
		
		return "redirect:/board/" + board.getId();
	}
}
