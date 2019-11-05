<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<style>
button {
width: 70px;
height: 20px;
font-size: 14px;
padding: 0px;
background-color: black;
font: 400 13.3333px Arial;
color:white;
border: rgba(0,0,0,0);
}
</style>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
</head>
<body>
	<table class="board_view">
		<colgroup>
			<col width="15%" />
			<col width="35%" />
			<col width="15%" />
			<col width="35%" />
		</colgroup>
		<caption>게시글 상세</caption>
		<tbody>
			<tr>
				<th scope="row">글 번호</th>
				<td>${map.TITLE }</td>
				<th scope="row">조회수</th>
				<td>${map.HIT_CNT }</td>
			</tr>
			<tr>
				<th scope="row">작성자</th>
				<td>${map.CREA_ID }</td>
				<th scope="row">작성시간</th>
				<td>${map.CREA_DTM }</td>
			</tr>
		
					<c:forEach var="field_list" items="${field_list}">
					<c:if test="${field_list.BOARD_FIELD ne null}">
						<tr>
							<th scope="row" style="background-color:#d9e1e8; color:#282c37; ">${field_list.BOARD_FIELD}</th>
								<td colspan="3">${field_list.FIELD_DATA}</td>
						</tr>
						</c:if>
					</c:forEach>
			<tr>
				<th scope="row">제목</th>
				<td colspan="3">${map.TITLE }</td>
			</tr>
			<tr>
				<td colspan="4">${map.CONTENTS }</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3">
				<c:choose>
						<c:when test="${fn:length(list) > 0}">
							<c:forEach var="row" items="${list }">
								<input type="hidden" id="IDX" value="${row.IDX }">
								<a href="#this" name="file">${row.ORIGINAL_FILE_NAME }</a> (${row.FILE_SIZE }kb)
							</c:forEach>
						</c:when>
				<c:otherwise>
					첨부된 파일이 없습니다.
				</c:otherwise>
				</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="board_name" value="${map.BOARD_NAME}" >
	<button id="board_idx" style="cursor:pointer;" value="${map.BOARD_IDX}">목록으로</button>
	<button href="#this" id="update">수정하기</button>
	<%@ include file="/WEB-INF/include/include-body.jspf"%>
	<script type="text/javascript">
		$(document).ready(function() {
			var board_name = $('input[name=board_name]').val();
			$("#board_idx").on("click", function(e) {
			    var test = $(this).val();
			    var comSubmit = new ComSubmit();
			    comSubmit.setUrl("<c:url value='/sample/studyBoardList.do' />");
		        comSubmit.addParam("board_idx", test);
		        comSubmit.addParam("board_name", board_name);
		       comSubmit.submit();
			});
			$("#update").on("click", function(e) {
				e.preventDefault();
				fn_openBoardUpdate();
			});
			$("a[name='file']").on("click", function(e) {
				//파일 이름
				e.preventDefault();
				fn_downloadFile($(this));
			});
		});

		function fn_openBoardUpdate() {
			var idx = "${map.IDX}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardUpdate.do' />");
			comSubmit.addParam("IDX", idx);
			comSubmit.submit();
		}
		function fn_downloadFile(obj){
			var idx = obj.parent().find("#IDX").val(); 
			var comSubmit = new ComSubmit(); 
			comSubmit.setUrl("<c:url value='/common/downloadFile.do' />"); 
			comSubmit.addParam("IDX", idx); 
			comSubmit.submit(); 
		}
	</script>
</body>
</html>

