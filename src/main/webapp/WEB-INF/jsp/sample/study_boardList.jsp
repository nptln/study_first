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
color:white;
border: rgba(0,0,0,0);
}
</style>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
</head>
<body>
	<h2 id="BOARD_NAME" value="${map.BOARD_NAME}"> ${map.BOARD_NAME}</h2>
	 <input type="button" value="게시판 관리" style="float: right; background-color: black; color: white; margin-bottom: 20px; border-color: rgba(0,0,0,0);" onclick="fn_manageBoard();">
	<table class="board_list">
		<colgroup>
			<col width="10%" />
			<col width="*" />
			<col width="15%" />
			<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">글번호</th>
				<th scope="col">제목</th>
				<th scope="col">조회수</th>
				<th scope="col">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(list) > 0}">
					<c:forEach var="row" items="${list}">
						<tr>
							<td>${row.IDX }</td>
							<td class="title" style="font-weight: bold;"><a href="#this" name="TITLE">${row.TITLE }</a>
								<input type="hidden" id="IDX" value="${row.IDX }">
								</td>
							<td>${row.HIT_CNT }</td>
							<td>${row.CREA_DTM }</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4">새 글을 작성해주세요.</td>
					</tr>
				</c:otherwise>
			</c:choose>
									</tbody>
							</table>
								<br />
									<a><button id="BOARD_IDX" style="cursor:pointer;" value="${map.BOARD_IDX}"/>글쓰기</a>
	<%@ include file="/WEB-INF/include/include-body.jspf"%>
	<script type="text/javascript">
	$(document).ready(function(){
		    var BOARD_NAME = $('h2').text();
		$("button").click(function() {
		    var test = $(this).val();
		    var comSubmit = new ComSubmit();
		    comSubmit.setUrl("<c:url value='/sample/openBoardWrite.do' />");
	        comSubmit.addParam("BOARD_IDX", test);
	        comSubmit.addParam("BOARD_NAME", BOARD_NAME);
	        comSubmit.submit();
		});
		$("a[name='TITLE']").on("click", function(e){ 
			//제목
			e.preventDefault(); 
			fn_openBoardDetail($(this), BOARD_NAME); 
			}); 
		}); 
	
	function fn_openBoardDetail(obj, BOARD_NAME){ 
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do' />"); 
		comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
		comSubmit.addParam("BOARD_NAME", BOARD_NAME);
		comSubmit.submit(); } 
	   function fn_manageBoard() {
	          var comSubmit = new ComSubmit();
	          comSubmit.setUrl("<c:url value='/sample/boardManagement.do' />");
	          comSubmit.submit();
	       }
	</script>
</body>
</html>

