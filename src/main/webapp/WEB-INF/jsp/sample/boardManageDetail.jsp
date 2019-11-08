<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<input type="hidden" name="BOARD_IDX" value="${map.BOARD_IDX}">
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
					<td>${map.BOARD_IDX}</td> </tr>
					<tr>
					<th scope="row">게시판 생성날짜</th>
					<td>${map.BOARD_DATE}</td>
				</tr>
				<tr>
				<th scope="row">게시판 이름</th>
					<td><input type="text" id="BOARD_NAME" name="BOARD_NAME"
						value="${map.BOARD_NAME}"></td>			
				</tr>	
				<tr>
				<th scope="row">확장필드 사용여부</th>
					<td><input type="checkbox" ${map.FIELD_CHK eq 'Y' ? 'checked':'' } onclick="pf_fieldCk(this)">사용함
						<input type="hidden" name="FIELD_CHK" value="Y"></td>
				</tr>				
					<tr name="CHK_FIELD">
						<th scope="row">확장필드</th>
						<td id="table">
							<button type="button" id="field_insert" onclick="pf_field_insert();">추가</button><br/>
						<c:forEach var="field" items="${list}">
						<c:if test="${field.FIELD_DEL eq 'N'}">
						<div>
						<input type="hidden" value="${field.FIELD_IDX}" name="FIELD_KEY">
						<input type="text" value="${field.BOARD_FIELD}" name="FIELD_DATA">
						<input type="checkbox" ${field.FIELD_USE eq 'N' ? 'checked' : '' } onclick="pf_useCk(this)">사용안함
						<input type="checkbox" onclick="pf_delCk(this)">필드삭제
						<input type="hidden" name="FIELD_DEL" value="N">
						<input type="hidden" name="FIELD_USE" value="${field.FIELD_USE}">
						</div>
						</c:if>
						</c:forEach>
							</td>
						</tr>
			</tbody>
		</table>
	</form>
	<button id="BOARD_IDX" style="cursor: pointer;">목록으로</button>
	<button href="#this" id="update">수정하기</button>
	<button href="#this" id="delete">삭제하기</button>
	<%@ include file="/WEB-INF/include/include-body.jspf"%>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var BOARD_NAME = $('input[name=BOARD_NAME]').val();
							$("#BOARD_IDX")
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
			var html = '<div class="field_div'+length+'"><input type="hidden" name="FIELD_KEY"><input type="text" class="field_text" name="FIELD_DATA"> <button type="button" onclick="pf_field_delete(this);">삭제</button></div>';
				
			$("#table").append(html);
		}
		
		function pf_field_delete(obj){
			var target = $(obj).closest('div');
			
			//var target = $(obj).data("target");
			
			$("#table").find(target).remove();
		}
		
		function pf_useCk(obj){
			var target = $(obj).closest('div').find('input[name="FIELD_USE"]');
			if($(obj).is(":checked")){
				$(target).val('N');
			}else{
				$(target).val('Y');
			}
		}
		
		function pf_fieldCk(obj){
			var target;
			if($(obj).is(":checked")){
				$("input[name='FIELD_CHK']").val('Y');
				$("tr[name='CHK_FIELD']").show();
			}else{
				$("input[name='FIELD_CHK']").val('N');
				$("tr[name='CHK_FIELD']").hide();
				
			}
		}
		
	</script>
</body>
</html>

