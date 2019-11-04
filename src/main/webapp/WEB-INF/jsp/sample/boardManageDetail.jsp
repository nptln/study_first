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
	color: white;
	border: rgba(0, 0, 0, 0);
}
</style>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
</head>
<body>
	<form id="frm" name="frm">
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
					<td><input type="text" id="board_name" name="BOARD_NAME"
						value="${map.board_name}"></td>
				</tr>
				<tr>
					<th scope="row">게시판 생성날짜</th>
					<td>${map.board_date}</td>
					<th scope="row">확장필드 여부</th>
					<td colspan="3"><input type="radio" name="BOARD_FIELD_CHK"
						value="Y" onclick="addRow();"
						${map.board_field_chk eq 'Y' ? 'checked' : ''} />예<input
						type="radio" name="BOARD_FIELD_CHK" value="N"
						onclick="removeRowAll();"
						${empty map.board_field_chk || map.board_field_chk eq 'N' ? 'checked' : ''}>아니오</td>
				</tr>
				<c:if test="${map.board_field_chk eq 'N'}">
					<tr>
					<th scope="row">확장필드</th>
						<td id="table">
							<div id="contents" style="display: table;"></div>
						</td>
					</tr>
				</c:if>
				<c:if test="${map.board_field_chk eq 'Y'}">
					<tr>
					<th scope="row">확장필드</th>
						<div id="contents" style="display: table;">
							<td>
								<c:forEach var="field" items="${list}" varStatus="status">
									<input type="hidden" value="${field.field_idx}" name="field_idx${status.count}">
									<input type="text" value="${field.board_field}" name="input${status.count}"><br/>
								</c:forEach></td>
						</div>
					</tr>
				</c:if>
			</tbody>
		</table>
	</form>
	<button id="board_idx" style="cursor: pointer;">목록으로</button>
	<button href="#this" id="update">수정하기</button>
	<button href="#this" id="delete">삭제하기</button>
	<%@ include file="/WEB-INF/include/include-body.jspf"%>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var board_name = $('input[name=board_name]').val();
							$("#board_idx")
									.on(
											"click",
											function(e) {

												var comSubmit = new ComSubmit();
												comSubmit
														.setUrl("<c:url value='/sample/boardManagement.do' />");
												comSubmit.submit();

											});
							$("#update").on("click", function(e) {
								var chk = confirm("정말 수정하시겠습니까?");
								if(chk){
									e.preventDefault();
									fn_openBoardUpdate();}
							});
							
							$("#delete").on("click", function(e) {
								var chk = confirm("정말 삭제하시겠습니까?");
								if(chk){
									e.preventDefault();
									fn_openBoardDelete();}
							});
						});

		function fn_openBoardUpdate() {
			var board_idx = "${map.board_idx}";
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/sample/BoardFieldUpdate.do' />");
			comSubmit.addParam("BOARD_IDX", board_idx);
			comSubmit.submit();
		}
		
		function fn_openBoardDelete() {
			var board_idx = "${map.board_idx}";
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/sample/studyBoardDelete.do' />");
			comSubmit.addParam("BOARD_IDX", board_idx);
			comSubmit.submit();
		}

		function removeRowAll() {
			$('#contents').remove();
			var html = '<div id= "contents" style="display:table;"></div>';
			$('#table').append(html);
		}

		function removeRow() {
			$('#attach').remove();
			var html = '<div id="attach"></div>';
			$('#room_type').append(html);
		}

		function addRow() {
			var html = '<div class="contents_row" style="display:table-row"/><div class="contents_col" style="display:table_cell"/><select id="count"><option value="1">1</option><option value="2">2</option><option value="3">3</option></select><input type="button" value="추가" style="background-color:black; color:white;" onclick="createInput()"><input type="button" name="del_btn" value="삭제" style="background:black; color:white;" onclick="removeRow()"><br/><div id="room_type"><div id="attach"></div></div></div></div>';
			$('#contents').append(html);
		}

		function createInput() {
			var count = $("#count option:selected").val();
			var resultSpan = document.getElementById("attach");
			// 수정해야 할 경우 index 값으로 접근해보기..
			if (!isNaN(count)) {
				for (var i = 1; i <= count; i++) {
					var inputTag = document.createElement("INPUT");
					var brTag = document.createElement("BR");
					inputTag.type = "text";
					inputTag.name = "input" + i;
					resultSpan.appendChild(inputTag);
					resultSpan.appendChild(brTag);
				}
			}
		}
	</script>
</body>
</html>

