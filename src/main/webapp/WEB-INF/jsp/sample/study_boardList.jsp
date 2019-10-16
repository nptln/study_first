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
	<h2 id="board_name" value="${map.board_name}"> ${map.board_name}</h2>
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
							<td class="title" style="font-weight: bold;"><a href="#this" name="title">${row.TITLE }</a>
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
									<a><button id="board_idx" style="cursor:pointer;" value="${map.board_idx}"/>글쓰기</a>
	<%@ include file="/WEB-INF/include/include-body.jspf"%>
	<script type="text/javascript">
	$(document).ready(function(){
		    var board_name = $('h2').text();
		$("button").click(function() {
		    var test = $(this).val();
		    var comSubmit = new ComSubmit();
		    comSubmit.setUrl("<c:url value='/sample/openBoardWrite.do' />");
	        comSubmit.addParam("board_idx", test);
	        comSubmit.addParam("board_name", board_name);
	        comSubmit.submit();
		});
		$("a[name='title']").on("click", function(e){ 
			//제목
			e.preventDefault(); 
			fn_openBoardDetail($(this), board_name); 
			}); 
		}); 
	
	function fn_openBoardDetail(obj, board_name){ 
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do' />"); 
		comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
		comSubmit.addParam("board_name", board_name);
		comSubmit.submit(); } 
	   function fn_manageBoard() {
	          var comSubmit = new ComSubmit();
	          comSubmit.setUrl("<c:url value='/sample/boardManagement.do' />");
	          comSubmit.submit();
	       }
	</script>
</body>
</html>

