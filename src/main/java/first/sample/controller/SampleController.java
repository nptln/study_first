package first.sample.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import first.common.common.CommandMap;
import first.sample.service.SampleService;

@Controller
public class SampleController {
	Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value= "/sample/BoardFieldUpdate.do")
	public ModelAndView BoardFieldUpdate(CommandMap commandMap, HttpServletRequest req) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/sample/boardManagement.do");
		
		String[] FIELD_KEY = req.getParameterValues("FIELD_KEY");
		String[] FIELD_DATA = req.getParameterValues("FIELD_DATA");
		String[] FIELD_USE = req.getParameterValues("FIELD_USE");
		String[] FIELD_DEL = req.getParameterValues("FIELD_DEL");
		
		System.out.println("FIELD_KEY" + Arrays.toString(FIELD_KEY));
		System.out.println("FIELD_DATA" + Arrays.toString(FIELD_DATA));
		System.out.println("FIELD_USE" + Arrays.toString(FIELD_USE));
		System.out.println("FIELD_DEL" + Arrays.toString(FIELD_DEL));

		
		if(FIELD_KEY != null) {
		for(int i = 0; i< FIELD_KEY.length; i++){
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("BOARD_IDX", commandMap.getMap().get("BOARD_IDX"));
			map.put("FIELD_DATA", FIELD_DATA[i]);
			
			if(FIELD_KEY[i].equals("")){
				sampleService.boardFieldInsert(map);
			}else {
				map.put("FIELD_USE", FIELD_USE[i]);
				map.put("FIELD_DEL", FIELD_DEL[i]);
				map.put("FIELD_KEY", FIELD_KEY[i]);
				sampleService.boardFieldUpdate(map);
			}
		}
		}
		sampleService.studyBoardUpdate(commandMap.getMap());
		return mv;
	}
	
	@RequestMapping(value = "/sample/studyBoardManageDetail.do")
	public ModelAndView studyBoardManageDetail(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/sample/boardManageDetail");
		Map<String, Object> map = sampleService.studyBoardManageDetail(commandMap.getMap());
		List<Map<String, Object>> list= sampleService.boardContentSelect(commandMap.getMap());
		List<Map<String, Object>> field_list= sampleService.boardContentField(commandMap.getMap());
		mv.addObject("map", map);
		mv.addObject("list", list);
		mv.addObject("field_list", field_list);
		return mv;
	}
	
	@RequestMapping(value = "/sample/studyBoardDelete.do")
	public ModelAndView studyBoardDelete(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sample/boardManagement.do");
		sampleService.studyBoardDelete(commandMap.getMap());
		return mv;
	}
	
	@RequestMapping(value = "/sample/studyBoardUpdate.do")
	public ModelAndView studyBoardUpdate(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sample/boardManagement.do");
		sampleService.studyBoardUpdate(commandMap.getMap());
		return mv;
	}
	
	@RequestMapping(value = "/sample/fieldDelete.do")
	public ModelAndView fieldDelete(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardManageDetail");
		sampleService.fieldDelete(commandMap.getMap());
		Map<String, Object> map = sampleService.studyBoardManageDetail(commandMap.getMap());
		List<Map<String, Object>> list= sampleService.boardContentSelect(commandMap.getMap());
		mv.addObject("map", map);
		mv.addObject("list", list);
		return mv;
	}
	
	
	@RequestMapping(value = "/sample/studyBoardList.do")
	public ModelAndView studyBoardList(CommandMap commandMap) throws Exception {
		// jsonView : action-servlet.xml에 bean id='jsonView'사용. 데이터를 json형식으로 변환해주는 역할 수행
		ModelAndView mv = new ModelAndView("/sample/study_boardList");
		List<Map<String, Object>> list = sampleService.openBoardList(commandMap.getMap());
		mv.addObject("list", list);
		mv.addObject("map", commandMap.getMap());
		return mv;
	}
	
	@RequestMapping(value="/sample/boardCreate.do")
	public ModelAndView boardCreate(CommandMap commandMap,  HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sample/boardManagement.do");
		sampleService.insertBoardManagement(commandMap.getMap(), request);
		return mv;
	}
	
	@RequestMapping(value= "/sample/boardManagement.do")
	public ModelAndView boardManagementList(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardManagement");
		List<Map<String, Object>> map = sampleService.selectBoardManageList(commandMap.getMap());
		mv.addObject("boardList", map);
		return mv;
	}

	@RequestMapping(value = "/sample/openSampleList.do")
	public ModelAndView openSampleList(Map<String, Object> commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("");
		log.debug("인터셉터 테스트");
		return mv;
	}

	@Resource(name = "sampleService")
	private SampleService sampleService;

	
	/*  @RequestMapping(value = "/sample/openBoardList.do") public ModelAndView
	  openBoardList(CommandMap commandMap) throws Exception { ModelAndView mv =
	  new ModelAndView("/sample/boardList"); Map<String, Object> map =
	  sampleService.selectBoardList(commandMap.getMap());
	  mv.addObject("paginationInfo", (PaginationInfo)map.get("paginationInfo"));
	  mv.addObject("list", map.get("result")); return mv; }
	 */

/*	@RequestMapping(value="/sample/openBoardList.do")
	public ModelAndView openBoardList(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardList");
		return mv;
	}*/

	@RequestMapping(value = "/sample/selectBoardList.do")
	public ModelAndView selectBoardList(CommandMap commandMap) throws Exception {
		// jsonView : action-servlet.xml에 bean id='jsonView'사용. 데이터를 json형식으로 변환해주는 역할 수행
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> list = sampleService.selectBoardList(commandMap.getMap());
		mv.addObject("list", list);
		if (list.size() > 0) {
			mv.addObject("TOTAL", list.get(0).get("TOTAL_COUNT"));
		} else {
			mv.addObject("TOTAL", 0);
		}
		return mv;
	}

	@RequestMapping(value = "/sample/testMapArgumentResolver.do")
	public ModelAndView testMapArgumentResolver(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("");
		if (commandMap.isEmpty() == false) {
			Iterator<Entry<String, Object>> iterator = commandMap.getMap().entrySet().iterator();
			Entry<String, Object> entry = null;
			while (iterator.hasNext()) {
				entry = iterator.next();
				log.debug("key : " + entry.getKey() + ", value : " + entry.getValue());
			}
		}
		return mv;
	}

	@RequestMapping(value = "/sample/openBoardWrite.do")
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardWrite");
		List<Map<String, Object>> list= sampleService.boardContentSelect(commandMap.getMap());
		mv.addObject("map", commandMap.getMap());
		mv.addObject("field_list", list);
		return mv;
	}

	@RequestMapping(value = "/sample/insertBoard.do")
	public ModelAndView insertBoard(CommandMap commandMap, HttpServletRequest request) throws Exception {
			
		sampleService.insertBoard(commandMap.getMap(), request);
		
		String[] FIELD_KEY = request.getParameterValues("FIELD_KEY");
		String[] FIELD_DATA = request.getParameterValues("FIELD_DATA");
		
		if(FIELD_KEY != null) {
			for(int i = 0; i< FIELD_KEY.length; i++){
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("FIELD_DATA", FIELD_DATA[i]);
			map.put("FIELD_KEY", FIELD_KEY[i]);
			map.put("BOARD_IDX",  commandMap.getMap().get("BOARD_IDX"));
			map.put("IDX", commandMap.getMap().get("IDX"));
			sampleService.insertField(map);
		}
	}
		ModelAndView mv = new ModelAndView("/sample/study_boardList");
		List<Map<String, Object>> list = sampleService.openBoardList(commandMap.getMap());
		mv.addObject("map", commandMap.getMap());
		mv.addObject("list", list);
		return mv;
		}

	@RequestMapping(value = "/sample/openBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardDetail");
		Map<String, Object> map = sampleService.selectBoardDetail(commandMap.getMap());
		mv.addObject("map", map.get("map"));
		//파일리스트 출력
		mv.addObject("list", map.get("list"));
		//확장필드 출력
		mv.addObject("data_list", map.get("data_list"));
		return mv;
	}

	@RequestMapping(value = "/sample/openBoardUpdate.do")
	public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sample/boardUpdate");

		Map<String, Object> map = sampleService.selectBoardDetail(commandMap.getMap());
		mv.addObject("map", map.get("map"));
		//파일리스트 출력
		mv.addObject("list", map.get("list"));
		//확장필드 출력
		mv.addObject("data_list", map.get("data_list"));
		return mv;
	}

	@RequestMapping(value = "/sample/updateBoard.do")
	public ModelAndView updateBoard(CommandMap commandMap, HttpServletRequest request) throws Exception {
		
		String[] FIELD_KEY = request.getParameterValues("FIELD_KEY");
		String[] FIELD_DATA = request.getParameterValues("FIELD_DATA");
		
		System.out.println(commandMap.getMap());
		System.out.println("FIELD_KEY:"+Arrays.toString(FIELD_KEY)+"// FIELD_DATA: "+Arrays.toString(FIELD_DATA));
		
	
		if(FIELD_KEY != null) {
			for(int i = 0; i< FIELD_KEY.length; i++){
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("FIELD_DATA", FIELD_DATA[i]);
			map.put("FIELD_KEY", FIELD_KEY[i]);
			map.put("IDX", commandMap.get("IDX"));
			map.put("BOARD_IDX", commandMap.get("BOARD_IDX"));
			sampleService.updateField(map);
		}
	}
		ModelAndView mv = new ModelAndView("redirect:/sample/openBoardDetail.do");	
		sampleService.updateBoard(commandMap.getMap(), request);
		mv.addObject("IDX", commandMap.get("IDX"));
		mv.addObject("map", commandMap.getMap());
		return mv;
	}

	@RequestMapping(value = "/sample/deleteBoard.do")
	public ModelAndView deleteBoard(CommandMap commandMap) throws Exception {
		sampleService.deleteBoard(commandMap.getMap());
		ModelAndView mv = new ModelAndView("/sample/study_boardList");
		List<Map<String, Object>> list = sampleService.openBoardList(commandMap.getMap());
		mv.addObject("list", list);
		mv.addObject("map", commandMap.getMap());
		return mv;
	}

}
