package com.choong.spr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choong.spr.domain.ReplyDto;
import com.choong.spr.service.ReplyService;

@Controller
@RequestMapping("reply")
public class ReplyController {
	
	@Autowired
	private ReplyService service;
	
	@PostMapping("insert")
	public String insert(ReplyDto reply, RedirectAttributes rttr) {
		boolean success = service.insertReply(reply);
		
		rttr.addAttribute("insertReplySuccess", success);
		
		return "redirect:/board/" + reply.getBoardId();
	}
	
	@PostMapping("modify")
	public String modify(ReplyDto reply, RedirectAttributes rttr) {
		boolean success = service.modifyReply(reply);
		
		rttr.addAttribute("modifyReplySuccess", success);
		
		return "redirect:/board/" + reply.getBoardId();
	}
	
	@PostMapping("remove")
	public String remove(ReplyDto reply, RedirectAttributes rttr) {
		boolean success = service.removeReply(reply);
		
		rttr.addAttribute("removeReplySuccess", success);
		
		return "redirect:/board/" + reply.getBoardId();
	}
}
