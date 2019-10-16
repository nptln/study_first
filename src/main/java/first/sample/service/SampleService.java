package first.sample.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface SampleService {

/*	Map<String, Object> selectBoardList(Map<String, Object> map) throws Exception;*/

	void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;

	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;

	void updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;

	void deleteBoard(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectBoardManageList(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> writeList(Map<String, Object> map) throws Exception;

	void insertBoardManagement(Map<String, Object> map, HttpServletRequest request) throws Exception;

	List<Map<String, Object>> openBoardList(Map<String, Object> map) throws Exception;

	void studyBoardUpdate(Map<String, Object> map) throws Exception;

	void studyBoardDelete(Map<String, Object> map) throws Exception;

	Map<String, Object> studyBoardManageDetail(Map<String, Object> map) throws Exception;



}
