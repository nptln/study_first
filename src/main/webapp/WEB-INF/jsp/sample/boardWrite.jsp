<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<style>
button {
width: 70px;
height: 30px;
font-size: 14px;
padding: 0px;
background-color: black;
font: 400 13.3333px Arial;
color:white;
border: rgba(0,0,0,0);
margin:10px 10px 0px 0px;
}
</style>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
</head>
<body>
	<form id="frm" name="frm" enctype="multipart/form-data">
		<table class="board_view">
			<colgroup>
				<col width="15%">
				<col width="*" />
			</colgroup>
			<caption>게시글 작성</caption>
			<tbody>
					<c:forEach var="field_list" items="${field_list}">
					<c:if test="${field_list.FIELD_USE eq 'Y' and field_list.FIELD_DEL eq 'N'}">
						<tr>
							<th scope="row" style="background-color:#d9e1e8; color:#282c37; ">${field_list.BOARD_FIELD}</th>
								<td colspan="3">
									<input type="text" name="FIELD_DATA">
									<input type="hidden" value="${field_list.FIELD_IDX}" name="FIELD_KEY">
								</td>
						</tr>
				</c:if>
					</c:forEach>
				<tr>
					<th scope="row">제목</th>
					<td><input type="text" id="TITLE" name="TITLE" class="wdp_90"></input></td>
				</tr>
				<tr>			
				<input type="hidden" name="BOARD_IDX" value="${map.BOARD_IDX}" >
				<input type="hidden" name="BOARD_NAME" value="${map.BOARD_NAME}" >
				</tr>
				<tr>
					<td colspan="2" class="view_text"><textarea rows="20"
							cols="100" title="내용" id="CONTENTS" name="CONTENTS"></textarea></td>
				</tr>
			</tbody>
		</table>
		<div id="fileDiv">
			<p>
				<input type="file" id="file" name="file_0">
				<button href="#this"  id="delete" name="delete">삭제</button>
			</p>
		</div>
		<br /> <br />
		<button href="#this"  id="addFile">파일 추가</button>
		<button href="#this"  id="write">작성하기</button>
		<button href="#this"  id="list">목록으로</button>
	</form>
	<%@ include file="/WEB-INF/include/include-body.jspf"%>
	<script type="text/javascript">
	var gfv_count = 1;
	var BOARD_IDX = $('input[name=BOARD_IDX]').val();
	var BOARD_NAME = $('input[name=BOARD_NAME]').val();
		$(document).ready(function() {
			$("#list").on("click", function(e) {
				//목록으로 버튼 
				e.preventDefault();
				fn_openBoardList();
			});
			$("#write").on("click", function(e) {
				//작성하기 버튼 
				e.preventDefault();
				fn_insertBoard();
			});
			$("#addFile").on("click", function(e){
				//파일 추가 버튼
				e.preventDefault();
				fn_addFile();
			});
			$("a[name='delete']").on("click", function(e){
				//삭제 버튼
				e.preventDefault();
				fn_deleteFile($(this));
			});

		});

		function fn_openBoardList() {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/studyBoardList.do' />");
			comSubmit.addParam("BOARD_IDX", BOARD_IDX);
			comSubmit.addParam("BOARD_NAME", BOARD_NAME);
			comSubmit.submit();
		}

		function fn_insertBoard() {
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/sample/insertBoard.do' />");
			comSubmit.submit();
		}
			
		function fn_addFile(){
				var str = "<p><input type='file' name='file_"+(gfv_count++)+"'><a href='#this' class='btn' name='delete'>삭제</a></p>";
				$("#fileDiv").append(str);
				$("a[name='delete']").on("click", function(e){
					//삭제 버튼
					e.preventDefault();
					fn_deleteFile($(this));
			});
				}
		function fn_deleteFile(obj){
			obj.parent().remove();
			}
	</script>

</body>
</html>

