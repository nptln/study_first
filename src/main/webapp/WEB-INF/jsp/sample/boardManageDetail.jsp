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
		<caption>게시판 상세</caption>
		<tbody>
			<tr>
				<th scope="row">게시판 번호</th>
				<td>${map.board_idx}</td>
				<th scope="row">게시판 이름</th>
				<td>${map.board_name}</td>
			</tr>
			<tr>
				<th scope="row">게시판 생성날짜</th>
				<td>${map.board_date}</td>
				<th scope="row">확장필드 여부</th>
				<td colspan="3"><input type="checkbox" value="Y">예<input type="checkbox" value="N">아니오</td>
			</tr>
			<tr>
				<td colspan="4">테스트영역</td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="board_name" value="${map.BOARD_NAME}" >
	<button id="board_idx" style="cursor:pointer;">목록으로</button>
	<button href="#this" id="update">수정하기</button>
	<%@ include file="/WEB-INF/include/include-body.jspf"%>
	<script type="text/javascript">
		$(document).ready(function() {
			var board_name = $('input[name=board_name]').val();
			$("#board_idx").on("click", function(e) {
			
			          var comSubmit = new ComSubmit();
			          comSubmit.setUrl("<c:url value='/sample/boardManagement.do' />");
			          comSubmit.submit();
			       
			});
			$("#update").on("click", function(e) {
				/* e.preventDefault();
				fn_openBoardUpdate(); */
			});
			
		});

		function fn_openBoardUpdate() {
			var idx = "${map.IDX}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardUpdate.do' />");
			comSubmit.addParam("IDX", idx);
			comSubmit.submit();
		}
		
	</script>
</body>
</html>

