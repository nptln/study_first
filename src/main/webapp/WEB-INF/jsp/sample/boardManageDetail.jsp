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
	<input type="hidden" name="BOARD_IDX" value="${map.board_idx}">
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
					<td>${map.board_idx}</td> </tr>
					<tr>
					<th scope="row">게시판 생성날짜</th>
					<td>${map.board_date}</td>
				</tr>
				<tr>
				<th scope="row">게시판 이름</th>
					<td><input type="text" id="board_name" name="BOARD_NAME"
						value="${map.board_name}"></td>			
				</tr>	
					<tr>
						<th scope="row">확장필드</th>
						<td id="table">
							<button type="button" id="field_insert" onclick="pf_field_insert();">추가</button><br/>
						<c:forEach var="field" items="${list}">
						<c:if test="${field.field_del eq 'N'}">
						<div>
						<input type="hidden" value="${field.field_idx}" name="field_key">
						<input type="text" value="${field.board_field}" name="field_data">
						<input type="checkbox" ${field.field_use eq 'N' ? 'checked' : '' } onclick="pf_useCk(this)">사용안함
						<input type="checkbox" onclick="pf_delCk(this)">필드삭제
						<input type="hidden" name="field_del" value="N">
						<input type="hidden" name="field_use" value="${field.field_use}">
						</div>
						</c:if>
						</c:forEach>
							</td>
					</tr>
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
								if (chk) {
									e.preventDefault();
									fn_openBoardUpdate();
								}
							});

							$("#delete").on("click", function(e) {
								var chk = confirm("정말 삭제하시겠습니까?");
								if (chk) {
									e.preventDefault();
									fn_openBoardDelete();
								}
							});

						});

		function fn_openBoardUpdate() {
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/sample/BoardFieldUpdate.do' />");
			comSubmit.submit();
		}

		function fn_openBoardDelete() {
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/sample/studyBoardDelete.do' />");
			comSubmit.submit();
		}		
		function pf_field_insert(){
			var length = $("#table").find(".field_text").length;
			var html = '<div class="field_div'+length+'"><input type="hidden" name="field_key"><input type="text" class="field_text" name="field_data"> <button type="button" onclick="pf_field_delete(this);">삭제</button></div>';
				
			$("#table").append(html);
		}
		
		function pf_field_delete(obj){
			var target = $(obj).closest('div');
			
			//var target = $(obj).data("target");
			
			$("#table").find(target).remove();
		}
		
		function pf_useCk(obj){
			var target = $(obj).closest('div').find('input[name="field_use"]');
			if($(obj).is(":checked")){
				$(target).val('N');
			}else{
				$(target).val('Y');
			}
		}
		
		function pf_delCk(obj){
			var target = $(obj).closest('div').find('input[name="field_del"]');
			if($(obj).is(":checked")){
				$(target).val('Y');
			}else{
				$(target).val('N');
			}
		}
		
	</script>
</body>
</html>

