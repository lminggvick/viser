package viser.card;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet("/card/cardlist")
public class ReadCardListServlet extends HttpServlet{
	public static Logger logger =LoggerFactory.getLogger(ReadCardListServlet.class);
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		HttpSession session=request.getSession();  //형근: 프로젝트 명을 저장하기 위한 세션 (추후에 board로 옮길것)
		session.setAttribute("projectname",request.getParameter("projectname"));  //형근: 세션에 프로젝트명을 저장  
		logger.debug("세션에 저장된 프로젝트 이름: "+session.getAttribute("projectname"));
		List list = new ArrayList(); 		// 게시물 목록을 가져오기 위하여 LIST 객체생성
		CardDAO cardDao = new CardDAO();
		
	  	int page = 1;	// 기본 페이지
		int limit = 10; // 최대 페이지
		
		// 사용자의 요청(req)을 통해 "page" 파라미터가 있는 확인
		if(request.getParameter("page") != null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		 
		int listcount;
		
		try {
	
		// 게시물의 총 개수를 가져옵니다.
		list = cardDao.getCardList(page,limit); 	// 게시물을 LIST 객체에 담습니다. 
		listcount = list.size() + 1;
		
		// 최대 페이지를 구합니다.
   		int maxpage = (int)((double)listcount / limit + 0.95); // 0.95 올림처리
   		
   		// 시작 페이지를 구합니다. ex ) start page count(1, 11, 21...)
   		int startpage = (((int)((double)page / 10 + 0.9)) - 1) * 10 + 1;
   		
   		// 마지막 페이지를 구합니다. ex ) last page count(10, 20, 30...)
   		int endpage = maxpage;
   		if(endpage > startpage + 10 - 1) endpage = startpage + 10 - 1;
   		
   		request.setAttribute("page", page);		  		// 현재 페이지
   		request.setAttribute("maxpage", maxpage); 		// 최대 페이지
   		request.setAttribute("startpage", startpage); 	// 시작 페이지
   		request.setAttribute("endpage", endpage);     	// 마지막 페이지
		request.setAttribute("count", listcount); 		// 게시물 총 개수
		request.setAttribute("list", list);
		
		RequestDispatcher rd = request.getRequestDispatcher("/card_list.jsp");
		rd.forward(request, response);
	
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
