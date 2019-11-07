package first.sample.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import first.common.dao.AbstractDAO;

@Repository("sampleDAO")
public class SampleDAO extends AbstractDAO {

/*	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardList(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectPagingList("sample.selectBoardList", map);
	}
	*/
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectPagingList("sample.selectBoardList", map);
	}

	public void insertBoard(Map<String, Object> map) throws Exception {
		insert("sample.insertBoard", map);
	}
	
	public void insertField(HashMap<String, Object> map) {
		insert("sample.insertField", map);
	}

	public void updateHitCnt(Map<String, Object> map) throws Exception {
		update("sample.updateHitCnt", map);
	}

	
	  @SuppressWarnings("unchecked")
	  public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception { 
		  return (Map<String, Object>) selectOne("sample.selectBoardDetail", map); 
		  }
	 


	public void updateBoard(Map<String, Object> map) throws Exception {
		update("sample.updateBoard", map);
	}
	public void updateField(HashMap<String, Object> map) throws Exception {
		update("sample.updateField", map);
	}

	public void deleteBoard(Map<String, Object> map) throws Exception {
		update("sample.deleteBoard", map);
	}

	public void insertFile(Map<String, Object> map) throws Exception {
		insert("sample.insertFile", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("sample.selectFileList", map);
	}

	public void deleteFileList(Map<String, Object> map) throws Exception {
		update("sample.deleteFileList", map);
	}

	public void updateFile(Map<String, Object> map) throws Exception {
		update("sample.updateFile", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardManageList(Map<String, Object> map) {
		return (List<Map<String, Object>>) selectList("sample.selectBoardManageList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> writeList(Map<String, Object> map) {
	    return (List<Map<String, Object>>) selectList("sample.writeList", map);
	}

	public void insertBoardManagement(Map<String, Object> map) {
		insert("sample.insertBoardManagement", map);
		
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> openBoardList(Map<String, Object> map) {
		return (List<Map<String, Object>>) selectList("sample.openBoardList", map);
	}

	public void studyBoardUpdate(Map<String, Object> map) {
		update("sample.studyBoardUpdate", map);
	}

	public void studyBoarddelete(Map<String, Object> map) {
		delete("sample.studyBoarddelete", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> studyBoardManageDetail(Map<String, Object> map) {
		 return (Map<String, Object>) selectOne("sample.studyBoardManageDetail", map);
	}

	public void boardFieldUpdate(Map<String, Object> map) {
		update("sample.boardFieldUpdate", map);

	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> boardFieldSelect(Map<String, Object> map) {
		 return (List<Map<String, Object>>) selectList("sample.boardFieldSelect", map);
	}

	public void boardFieldInsert(Map<String, Object> map) {
		insert("sample.boardFieldInsert", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> boardContentSelect(Map<String, Object> map) {
		return (List<Map<String, Object>>) selectList("sample.boardContentSelect", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> boardContentField(Map<String, Object> map) {
		return (List<Map<String, Object>>) selectList("sample.boardContentField", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFieldList(Map<String, Object> map) {
		return (List<Map<String, Object>>) selectList("sample.selectFieldList", map);
	}

	public void fieldDelete(Map<String, Object> map) {
		delete("sample.fieldDelete", map);
		update("sample.fieldChkUpdate", map);	
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFieldNameList(Map<String, Object> map) {
		return (List<Map<String, Object>>) selectList("sample.selectFieldNameList", map);
	}



}
