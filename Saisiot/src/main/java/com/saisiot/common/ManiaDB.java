package com.saisiot.common;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class ManiaDB {

	// tag값의 정보를 가져오는 메소드
	private String getTagValue(int num, String tag, Element eElement) {
		
		if(eElement.getElementsByTagName(tag).item(num) == null) {
			return null;
		}else {
			NodeList nlList = eElement.getElementsByTagName(tag).item(num).getChildNodes();
			Node nValue = (Node) nlList.item(0);
			if (nValue == null) {
				return null;
			}
			return nValue.getNodeValue();
		}
	}
	
	public Map<Integer, Map<String,String>> maniaDb(String name) {
		int page = 1; // 페이지 초기값
		String keyword = name;
		String sr = "song";
		
		
		String query = null;
		Map<Integer, Map<String,String>> res = new HashMap<Integer, Map<String,String>>(); 
		
		// 검색어 인코딩
		try {
			query = URLEncoder.encode(keyword, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		try {
			while (true) {
				// parsing할 url 지정(API 키 포함해서)
				String url = "http://www.maniadb.com/api/search/" + query + "/?sr=" + sr
						+ "&display=50&key=prawn815@nate.com&v=0.5"+page;

				DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
				Document doc = dBuilder.parse(url);

				// root tag
				doc.getDocumentElement().normalize();

				// 파싱할 tag
				NodeList nList = doc.getElementsByTagName("item");
				// System.out.println("파싱할 리스트 수 : "+ nList.getLength());

				for (int i = 0; i < nList.getLength(); i++) {
					Node nNode = nList.item(i);
					if (nNode.getNodeType() == Node.ELEMENT_NODE) {
						Element eElement = (Element) nNode;
						Map<String, String> list = new HashMap<String, String>();
						list.put("name",getTagValue(0, "name", eElement));
						list.put("title",getTagValue(0, "title", eElement));
						list.put("time",getTagValue(0, "runningtime", eElement));
						list.put("album",getTagValue(1, "title", eElement));
						res.put(i,list);
					}
				}

				page += 1;
				if (page > 50) {
					break;
				}
			} // while end

		} catch (Exception e) {
			e.printStackTrace();
		} // try~catch end
		return res;
	} // method end
}
