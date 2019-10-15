package first.sample.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import first.common.util.FileUtils;
import first.sample.dao.SampleDAO;

@Service("sampleService")
public class SampleServiceImpl implements SampleService {

	Logger log = Logger.getLogger(this.getClass());

	// 어노테이션을 이용하면 클래스 사용시 new 사용해서 객체를 만드는 게 아니라, 선언만 해주고도 사용 가능
	@Resource(name = "fileUtils")
	private FileUtils fileUtils;

	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;

	
/*	  @Override public Map<String, Object> selectBoardList(Map<String, Object>
	  map) throws Exception { return sampleDAO.selectBoardList(map); }*/
	 

	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
		return sampleDAO.selectBoardList(map);
	}

	@Override
	public void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		sampleDAO.insertBoard(map);

		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(map, request);
		for (int i = 0, size = list.size(); i < size; i++) {
			sampleDAO.insertFile(list.get(i));
		}

		/*
		 * MultipartHttpServletRequest multipartHttpServletRequest =
		 * (MultipartHttpServletRequest) request; Iterator<String> iterator =
		 * multipartHttpServletRequest.getFileNames(); MultipartFile
		 * multipartFile = null; while (iterator.hasNext()) { multipartFile =
		 * multipartHttpServletRequest.getFile(iterator.next()); if
		 * (multipartFile.isEmpty() == false) {
		 * log.debug("------------- file start -------------");
		 * log.debug("name : " + multipartFile.getName());
		 * log.debug("filename : " + multipartFile.getOriginalFilename());
		 * log.debug("size : " + multipartFile.getSize());
		 * log.debug("-------------- file end --------------\n"); } }
		 */

	}

	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		sampleDAO.updateHitCnt(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> tempMap = sampleDAO.selectBoardDetail(map);
		resultMap.put("map", tempMap);

		List<Map<String, Object>> list = sampleDAO.selectFileList(map);
		resultMap.put("list", list);
		return resultMap;

	}

	@Override
	public void updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		sampleDAO.updateBoard(map);

		// 해당 게시글에 해당하는 첨부파일 전부 삭제 처리 (DEL_GB='Y')
		sampleDAO.deleteFileList(map);
		// request에 담겨있는 파일 정보를 list로 변환함
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(map, request);
		Map<String, Object> tempMap = null;
		for (int i = 0, size = list.size(); i < size; i++) {
			tempMap = list.get(i);
			// 신규 저장한 파일의 경우 파일정보 저장
			if (tempMap.get("IS_NEW").equals("Y")) {
				sampleDAO.insertFile(tempMap);
				// 기존 파일의 경우 삭제처리를 바꿔줌
			} else {
				sampleDAO.updateFile(tempMap);
			}
		}

	}

	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		sampleDAO.deleteBoard(map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> selectBoardManageList(Map<String, Object> map) throws Exception {
		return sampleDAO.selectBoardManageList(map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> writeList(Map<String, Object> map) throws Exception {
		return sampleDAO.writeList(map);
	}

	@Override
	public void insertBoardManagement(Map<String, Object> map, HttpServletRequest request) throws Exception {
		sampleDAO.insertBoardManagement(map);

	}

	@Override
	public List<Map<String, Object>> openBoardList(Map<String, Object> map) throws Exception {
		return sampleDAO.openBoardList(map);
	}

	@Override
	public void studyBoardUpdate(Map<String, Object> map) throws Exception {
		sampleDAO.studyBoardUpdate(map);
	}

	@Override
	public void studyBoardDelete(Map<String, Object> map) throws Exception {
		sampleDAO.studyBoarddelete(map);
	}

}
