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
				<td><input type="text" name="board_name" value="${map.board_name}"></td>
			</tr>
			<tr>
				<th scope="row">게시판 생성날짜</th>
				<td>${map.board_date}</td>
				<th scope="row">확장필드 여부</th>
				<td colspan="3"><input type="radio" name="board_field_chk" value="Y" onclick="addRow();"/>예<input type="radio" name="board_field_chk" value="N" checked="checked" onclick="removeRowAll();">아니오</td>
			</tr>
			<tr>
			<td id="table">
				<div id= "contents" style="display:table;"></div>
          		</td>
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
		
		
		function removeRowAll() {
			 $('#contents').remove();
			 var html = '<div id= "contents" style="display:table;"></div>';
			 $('#table').append(html);
		}
		
		function addRow(){
			var html = '<div class="contents_row" style="display:table-row"/><div class="contents_col" style="display:table_cell"/><input type="button" value="추가" onclick="add_div()"><br/><div id="room_type"><input type="text" style="float:left;" name="board_field" class="form-control"/><input type="button" name="del_btn" value="삭제" style="float:left; background:black; color:white;" onclick="remove_div()"></div></div></div>';
			$('#contents').append(html);
		}
		
		function add_div(){
			var html = '<div class="contents_row" style="display:table-row"/><div class="contents_col" style="display:table_cell"/><div id="room_type"><input type="text" style="float:left;" name="board_field" class="form-control"/><input type="button" value="삭제" style="float:left; background:black; color:white;" name="del_btn" onclick="remove_div()"></div></div></div>';
			$('#contents').append(html);
		}

		function remove_div(obj){
			var index = $("#contents .contents_row [name=del_btn]").index(obj);
			$("#contents .contents_row").eq(index).remove();
		}
	</script>
</body>
</html>

