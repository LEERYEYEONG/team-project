package com.oracle.choongangGroup.ry.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oracle.choongangGroup.changhun.JPA.Member;
import com.oracle.choongangGroup.dongho.auth.GetMember;
import com.oracle.choongangGroup.hs.approval.Paging;
import com.oracle.choongangGroup.ry.UpLoad.UpLoadFileUtils;
import com.oracle.choongangGroup.ry.model.BookCateVo;
import com.oracle.choongangGroup.ry.model.BookVo;
import com.oracle.choongangGroup.ry.service.AdminBookService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AdminBookController {
	
private final AdminBookService abs;
private final GetMember gm;	

	@GetMapping(value = "student/adminMain")
	public void adminMain() throws Exception{
		
	}
	
	@GetMapping(value = "/manager/bookInsert")
	public void bookInsertGet(Member member,Model model){
		System.out.println("bookInsertGet Start..." );
		List<BookCateVo> category = abs.category();
		member = gm.getMember();
		System.out.println("bookInsertGet Start..." + category);
		JSONArray jsonArray = new JSONArray();
		for (BookCateVo bookCateVo : category) {
			JSONObject jobj = new JSONObject();
			jobj.put("tier", bookCateVo.getTier());
			jobj.put("cateName", bookCateVo.getCateName());
			jobj.put("cateCode", bookCateVo.getCateCode());
			jobj.put("cateParent", bookCateVo.getCateParent());
			jsonArray.add(jobj);
		}
		System.out.println(jsonArray);
		model.addAttribute("category", jsonArray);
		model.addAttribute("member", member);
	}
	
	@PostMapping(value = "/manager/bookInsert")
	public String bookInsertPost(Member member,BookVo book, MultipartFile file, HttpServletRequest request,Model model) throws Exception{
//		String userid = gm.getMember().getUserid();
		member = gm.getMember();
		String imgUploadPath = request.getSession().getServletContext().getRealPath("/ryImgUpload/");
		String ymdPath = UpLoadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
		 fileName =  UpLoadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		 
		 book.setBookImg(File.separator + "ryImgUpload" + ymdPath + File.separator + fileName);
		 book.setBookThumbImg(File.separator + "ryImgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		 
		} else {
			
		fileName = File.separator + "ryImgUpload" + File.separator + "images" + File.separator + "none.png";
		System.out.println("fileName == > " + fileName);
		book.setBookImg(fileName);
		book.setBookThumbImg(fileName);
		}

		model.addAttribute("member", member);
		abs.bookInsert(book);
		return "redirect:/manager/bookList";
	}
	
	@GetMapping(value = "/manager/bookList")
	public void BookListGet(String currentPage,Member member, Model model) {
		BookVo book= new BookVo();
		int processTotal = abs.processTotal();
		member = gm.getMember();
		Paging page = new Paging(processTotal, currentPage);
		book.setStart(page.getStart());
		book.setEnd(page.getEnd());
		model.addAttribute("page", page);
		List<BookVo> list = abs.bookList(book);
		member = gm.getMember();
		model.addAttribute("list", list);
		model.addAttribute("member", member);
	}
	
	@RequestMapping(value = "/manager/getSearch")
	public String bookgetSearch(Member member,BookVo book, String cateParent, String keyword, Model model) {
		log.info("bookgetSearch start...");
		String userid = gm.getMember().getUserid();
		member = gm.getMember();
		log.info(userid);
		log.info(cateParent);
		log.info(keyword);
		List<BookVo> bookList = abs.bookSearchList(book);
		log.info("bookList.size()->{}", bookList.size());
		System.out.println();
		model.addAttribute("cateParent", cateParent);
		model.addAttribute("keyword", keyword);
		model.addAttribute("list", bookList);
		model.addAttribute("member", member);
		return "/manager/bookList";
	}
	
	
	@GetMapping(value = "/manager/detailBookList")
	public void detailBookList(Member member,int bookId, Model model, BookCateVo category) {
		member = gm.getMember();
		BookVo books = abs.bookDetailList(bookId);
		model.addAttribute("books", books);
		model.addAttribute("category", category);
		model.addAttribute("member", member);
	}
	
	@GetMapping(value = "manager/updateBook")
	public void updateBookGet(Member member,int bookId, Model model) {
		member = gm.getMember();
		BookVo books = abs.updateBook(bookId);
		model.addAttribute("books", books);
		
		List<BookCateVo> category = abs.category();
		System.out.println("bookInsertGet Start..." + category);
		JSONArray jsonArray = new JSONArray();
		for (BookCateVo bookCateVo : category) {
			JSONObject jobj = new JSONObject();
//			jobj.put("tier", bookCateVo.getTier());
			jobj.put("cateName", bookCateVo.getCateName());
			jobj.put("cateCode", bookCateVo.getCateCode());
			jobj.put("cateParent", bookCateVo.getCateParent());
			jsonArray.add(jobj);
		}
		System.out.println(jsonArray);
		model.addAttribute("category", jsonArray);
		model.addAttribute("member", member);
	}
	
	@PostMapping(value = "manager/updateBook")
	public String updateBookPost(BookVo book, MultipartFile file, HttpServletRequest request) throws Exception {
		Member member = gm.getMember();

		if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
		// 기존 파일을 삭제
		new File(request.getSession().getServletContext().getRealPath("/ryImgUpload/") + request.getParameter("gdsImg")).delete();
		new File(request.getSession().getServletContext().getRealPath("/ryImgUpload/") + request.getParameter("gdsThumbImg")).delete();			
			
		// 새로 파일 등록	
		 String imgUploadPath = request.getSession().getServletContext().getRealPath("/ryImgUpload/");
		 String ymdPath = UpLoadFileUtils.calcPath(imgUploadPath);
		 String fileName =  UpLoadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		 
		 book.setBookImg(File.separator + "ryImgUpload" + ymdPath + File.separator + fileName);
		 book.setBookThumbImg(File.separator + "ryImgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		} else {
			// 기존 이미지 사용
			book.setBookImg(request.getParameter("bookImg"));
			book.setBookThumbImg(request.getParameter("bookThumbImg"));
		}

		
		abs.bookUpdate(book);
		return "redirect:/manager/bookList";
	}
	
	
	@GetMapping(value = "/manager/deleteBook")
	public String deleteBookPost(int bookId) {
//		int bId = Integer.parseInt(bookId);
		abs.bookDelete(bookId);
		return "redirect:/manager/bookList";
	}
}
