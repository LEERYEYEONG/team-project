package com.oracle.choongangGroup.ry.controller;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.choongangGroup.changhun.JPA.Member;
import com.oracle.choongangGroup.dongho.auth.GetMember;
import com.oracle.choongangGroup.hj.model.MemberVo;
import com.oracle.choongangGroup.hs.approval.Paging;
import com.oracle.choongangGroup.ry.model.BookCartVo;
import com.oracle.choongangGroup.ry.model.BookCateVo;
import com.oracle.choongangGroup.ry.model.BookVo;
import com.oracle.choongangGroup.ry.model.OrderDetailVo;
import com.oracle.choongangGroup.ry.model.OrdersVo;
import com.oracle.choongangGroup.ry.service.AdminBookService;
import com.oracle.choongangGroup.ry.service.ShopService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ShopController {

	private final ShopService ss;
	private final GetMember gm;
	
	@GetMapping(value = "student/shopList")
	public void shopList(String currentPage,Member member,Model model) throws Exception {
		BookVo book= new BookVo();
		int processTotal = ss.processTotal();
		Paging page = new Paging(processTotal, currentPage);
		book.setStart(page.getStart());
		book.setEnd(page.getEnd());
		model.addAttribute("page", page);
		String userId = gm.getMember().getUserid();
		List<BookVo> bookList = ss.bookList(book);
		System.out.println("shopList userId=> "+ userId);
		model.addAttribute("bookList", bookList);
		model.addAttribute("userId", userId);
		model.addAttribute("member", member);
	}
	
	@RequestMapping(value = "/student/shopDetailList", method = RequestMethod.GET)
	public void shopDetailList(int bookId, Model model) throws Exception {
		System.out.println("BookDetail Controller start...............................");
		String userId = gm.getMember().getUserid();
		System.out.println("shopDetailList userId=> "+ userId);
		BookVo books = ss.bookDetailList(bookId);
		model.addAttribute("books", books);
		model.addAttribute("userId", userId);
	}
	
	// 
	@GetMapping(value = "/student/getSearchList")
	public String getSearchList(BookVo book,String type , String keyword, Model model){
//		book.setType(type);
//		book.setKeyword(keyword);
		
		List<BookVo> bookList = ss.getSearchList(book);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("bookList", bookList);
		
		return "student/shopList";
	}
	
	// 장바구니 담기
	@ResponseBody
	@RequestMapping(value = "/student/shopDetailList/addCart", method = RequestMethod.POST )
	public void addCart(BookCartVo cart,int bookId, Model model)	{
		System.out.println("addCart Start..."+cart);
		String userId = gm.getMember().getUserid();
		model.addAttribute("bookId", bookId);
		model.addAttribute("userId", userId);
		model.addAttribute("cart", cart);
		ss.addCart(cart);
		
	}
	
	// 카트 목록
	@RequestMapping(value = "/student/cartList", method = RequestMethod.GET)
	public void getCartList(Model model) throws Exception {
		System.out.println("getCartList Start...");
	 
	 String userId = gm.getMember().getUserid();
	 System.out.println("getCartList userId"+ userId);
	 
	 List<BookCartVo> cartList = ss.cartList(userId);
	 
	 model.addAttribute("cartList", cartList);
	 
	}
	
	// 카트 목록 삭제
	@ResponseBody
	@RequestMapping(value = "/student/deleteCart", method = RequestMethod.POST )
	public void deleteCart(int cartNum, Model model, BookCartVo cart)	{
		System.out.println("deleteCart Start...cartNum => "+cartNum);
		String userId = gm.getMember().getUserid();
		model.addAttribute("cartNum", cartNum);
		ss.deleteCart(cartNum);
		
	}
	
	// 주문 및 주문 번호 생성
	@RequestMapping(value = "/student/cartList", method = RequestMethod.POST)
	public String order(OrdersVo order, OrderDetailVo orderDetail) throws Exception {
	String userId = gm.getMember().getUserid();
	 
	 Calendar cal = Calendar.getInstance();
	 int year = cal.get(Calendar.YEAR);
	 String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
	 String ymd = ym +  new DecimalFormat("00").format(cal.get(Calendar.DATE));
	 String subNum = "";
	 
	 for(int i = 1; i <= 6; i ++) {
	  subNum += (int)(Math.random() * 10);
	 }
	 
	 String orderId = ymd + "_" + subNum;
	 
	 order.setOrderId(orderId);
	 order.setUserId(userId);
	  
	 ss.orderInfo(order);
	 
	 orderDetail.setOrderId(orderId);   
	 ss.orderInfo_Details(orderDetail);
	 
	 ss.cartAllDelete(userId);

	 
	 return "/student/orderList";  
	}
	
	// 학생 주문 목록
	@RequestMapping(value = "/student/orderList", method =RequestMethod.GET )
	public void getOrderList(OrdersVo order, Model model) {
		String userId = gm.getMember().getUserid();
		order.setUserId(userId);
		List<OrdersVo> orderList = ss.orderList(order);
		model.addAttribute("orderList", orderList);
	}
	
	// 학생 주문 상세 목록
	@RequestMapping(value = "/student/orderView", method =RequestMethod.GET )
	public void getOrderList(OrdersVo order,String orderId, Model model) {
		String userId = gm.getMember().getUserid();
		order.setUserId(userId);
		order.setOrderId(orderId);
		List<OrdersVo> orderView = ss.orderView(order);
		model.addAttribute("orderView", orderView);
	}
	
	// 학생 주문 상태 변경
	@RequestMapping(value = "/student/orderView", method = RequestMethod.POST)
	public String studentupdateState(String state1_btn, OrdersVo order) {

		System.out.println("------------controller start-----------------------------------");
		
		order.setState(state1_btn);
		ss.updateState(order);
		List<OrdersVo> orderView = ss.orderView(order);
		
//		return "redirect:/student/orderView?orderId="+order.getOrderId();
		return "redirect:/student/orderList";
	}
	
	// 카트 목록 삭제
		@ResponseBody
		@RequestMapping(value = "/student/billChange", method = RequestMethod.POST )
		public void billChange(String billState,String orderId, OrdersVo order)	{
			order.setBillState(billState);
			order.setOrderId(orderId);
			String userId = gm.getMember().getUserid();
			order.setUserId(userId);
			System.out.println("billChange billState -> "+ billState);
			System.out.println("billChange orderId -> "+ orderId);
			System.out.println("billChange userId -> "+ userId);
			ss.billUpdateState(order);
			List<OrdersVo> orderView = ss.orderView(order);
			
		}
	// 관리자 주문 목록 확인
	@RequestMapping(value = "/manager/adminOrderList", method =RequestMethod.GET )
	public void getadminOrderList(Model model) {
		String userId = gm.getMember().getUserid();
		Member member = gm.getMember();
		List<OrdersVo> orderList = ss.adminOrderList();
		model.addAttribute("orderList", orderList);
		model.addAttribute("member", member);
	}
	
	// 관리자 주문 상세 확인
	@RequestMapping(value = "/manager/adminOrderView", method =RequestMethod.GET )
	public void getadminOrderList( OrdersVo order,String orderId, Model model) {
		order.setOrderId(orderId);
		Member member = gm.getMember();
		List<OrdersVo> orderView = ss.adminOrderView(order);
		model.addAttribute("orderView", orderView);
		model.addAttribute("member", member);
	}
	// 학생 결제 목록 확인
	@RequestMapping(value = "/student/SearchOrderList", method =RequestMethod.GET )
	public String studentSearchOrderList( OrdersVo order,String orderId,String billState,String type ,
			String keyword,  Model model) {
		List<OrdersVo> orderList = ss.SearchOrderList(order);
		order.setOrderId(orderId);
		Member member = gm.getMember();
		model.addAttribute("billState", billState);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("orderId", orderId);
		model.addAttribute("orderList", orderList);
		model.addAttribute("member", member);
		return "/student/orderList";
	}
	@RequestMapping(value = "/manager/SearchOrderList", method =RequestMethod.GET )
	public String SearchOrderList( OrdersVo order,String orderId,String billState,String type ,
								String keyword,  Model model) {
		List<OrdersVo> orderList = ss.SearchOrderList(order);
		order.setOrderId(orderId);
		Member member = gm.getMember();
		model.addAttribute("billState", billState);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("orderId", orderId);
		model.addAttribute("orderList", orderList);
		model.addAttribute("member", member);
		return "/manager/adminOrderList";
	}
	
	// 관리자 주문 상태 변경 및 재고 변경
	@RequestMapping(value = "/manager/adminOrderView", method = RequestMethod.POST)
	public String updateState(String state1_btn, OrdersVo order) {

		System.out.println("------------controller start-----------------------------------");
		
		order.setState(state1_btn);
		ss.updateState(order);
		List<OrdersVo> orderView = ss.adminOrderView(order);
		
		BookVo book = new BookVo();
		if(state1_btn.equals("준비 완료")) {
		for(OrdersVo i : orderView) {
			book.setBookId(i.getBookId());
			book.setBookStock(i.getCartStock());
			ss.changeStock(book);
		}
		}
		return "redirect:/manager/adminOrderView?orderId="+order.getOrderId();
	}
	

	
	
}
