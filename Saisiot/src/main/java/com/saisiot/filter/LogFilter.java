package com.saisiot.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogFilter implements javax.servlet.Filter {
	
	private Logger logger = LoggerFactory.getLogger(LogFilter.class);

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;
		
		String remoteAddr = StringUtils.defaultString(req.getRemoteAddr());
		
		String uri = StringUtils.defaultString(req.getRequestURI());
		String url = StringUtils.defaultString(req.getRequestURL().toString());
		String queryString = StringUtils.defaultString(req.getQueryString());
		
		String referer = StringUtils.defaultString(req.getHeader("referer"));
		String agent = StringUtils.defaultString(req.getHeader("user-Agent"));
		
		/*System.out.println("******"+remoteAddr+"******");
		System.out.println("******"+uri+"******");
		System.out.println("******"+url+"******");
		System.out.println("******"+queryString+"******");
		System.out.println("******"+referer+"******");
		System.out.println("******"+agent+"******");*/
		
		StringBuffer sb = new StringBuffer();
		sb.append("\n")
		.append("remoteAddr : " + remoteAddr + "\n")
		.append("uri : " + uri + "\n")
		.append("url : " + "\n")
		.append("queryString : " + queryString + "\n").append("referer : " + referer + "\n")
		.append("agent : " + agent + "\n");
		
		logger.info(sb.toString());
		
		// 클라이언트와 server사이에서 response, request 주고 받은것을 엮어주는 놈 => filter chain이다.
		chain.doFilter(req, response);
		
		// filter와 interceptor의 차이
		// 필터는 서버와 클라이언트의 사이에 존재
		// 인터셉터는 서버에 존재
		// 인터셉터는 타겟인척하며 내용을 받아서 이어 붙혀준다
		// 필터는 걸러줌
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

}
