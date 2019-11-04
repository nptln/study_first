<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BoardManagement</title>
</head>
<style>
#button {
width: 70px;
height: 20px;
font-size: 14px;
padding: 0px;
background-color: black;
font: 400 13.3333px Arial;
color:white;
border: rgba(0,0,0,0);
}
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
table {
width: 100%;
    border-top: 2px solid #252525;
    border-bottom: 1px solid #ccc;
    display: table;
    border-collapse: separate;
    border-spacing: 2px;
    border-color: grey;
}

#mask_board_create {
position: absolute;
z-index: 9000;
background-color: #000;
display: none;
left: 0;
top: 0;
}

.board_create_modal {
display: none;
position: fixed;
z-index: 10000;
left: 50%;
top: 50%;
margin-left: -250px;
margin-top: -125px;
width: 500px;
height: 250px;
border-radius: 12px;
background-color: white;
}

.board_create_modal .top{
background-color: black; 
width:100%; height:30%; 
border-radius:12px 12px 0px 0px;
}

.board_create_modal .top .close {
float: right;
cursor: pointer;
color: white;
font-size: 25px;
font-weight: bold;
padding-top: 5px;
padding-right: 20px;
}

.board_create_modal .top .subject{
float:left;
margin-left:10px;
margin-top:20px;
font-size:20px;
font-weight:bold;
color:white;
padding-left: 20px;
}

.board_create_modal .bottom{
width:100%; 
height:15%; 
vertical-align: middle;

}

.board_create_modal .bottom .info{
padding:10px 15px 10px 15px;
text-align: right;
color: red;
}

.board_create_modal .bottom .contents{
width:100%;
text-align: center;
}

.board_create_modal .bottom .contents th{
text-align: right;
}

.board_create_modal .bottom .contents .board_name{
width:236px;
height:28px;
}

.board_create_modal .bottom .contents .board_select{
width:240px;
height:35px;
font-size:15px;
}

.board_create_modal .bottom .board_insert_button {
width:375px;
height:40px;
font-size:15px;
background-color:gray;
color:white;
}

.board_create_modal .bottom .center{
margin-left:60px;
}

#board_name{
background-color: rgba(0,0,0,0);
color: black;
font-size: 15px;
font-weight: bold;
border-color: rgba(0,0,0,0);
}

</style>
<body>
<div>
<h1>게시판 관리 페이지</h1>
 <input type="button" id="openMask_board_create" value="게시판 생성" style="background-color: black; color: white; margin-bottom: 20px;">
</div>
<table>
<thead>
<tr style="background-color: black; color:white;">
<td>게시판 이름</td>
<td>게시판 생성날짜</td>
<td>확장필드 사용여부</td>
<td>이동</td>
</tr>
</thead>
<tbody>
<c:forEach items="${boardList}" var="boardList">
<tr>
 <input type="hidden" name="board_idx" value="${boardList.board_idx}">
<td><button id="name" style="cursor:pointer; background-color: rgba(0,0,0,0); color:black; width: 100px;" value="${boardList.board_idx}"/>${boardList.board_name}</td>
<td>${boardList.board_date}</td> 
<td><c:if test="${boardList.board_field_chk eq 'Y'}">사용</c:if>
	<c:if test="${boardList.board_field_chk eq 'N'}">미사용</c:if></td>
<td><button id="move" style="cursor:pointer;" value="${boardList.board_idx}"/><input id="button" type="button" value="이동" ></td>
<!-- <td><input type="button" value="수정" style="background-color: black; color: white;" onclick="fn_update();"></td>
<td><input type="button" value="삭제" style="background-color: black; color: white;" onclick="fn_delete();"></td> -->
</tr>
</c:forEach>
</tbody>
</table>


<div id="mask_board_create"></div>
<div class="board_create_modal">
<div class="top" style="">
<div class="close" >
x
</div>
<div class="subject">
게시판 생성
</div>
</div>

<div class="bottom">
<form action="/sample/boardCreate.do" name="board_create_insert_form" method="POST">
<table class="contents">
<tr>
<th>게시판 이름</th>
<td><input type="text" name="board_name" class="board_name" placeholder="게시판 이름"/></td>
</tr>
</table>
</form>
<div class="center">
<button class="board_insert_button pointer" style="background-color: black; color:white;" onclick="insert_submit();">생성</button>
</div>

</div>

</div>

   <%@ include file="/WEB-INF/include/include-body.jspf"%>
<script type="text/javascript">

$(document).ready(function() {
	
	$("button").click(function() {
	    var test = $(this).val();
	    
	    var btn = $(this);
	    var tr = btn.parent().parent();
	    var td = tr.children();
	    
	    var board_name = td.eq(1).text();
	    
	    var comSubmit = new ComSubmit();

	    if($(this).attr('id') == 'move'){
	    	 comSubmit.setUrl("<c:url value='/sample/studyBoardList.do'/>");
	         comSubmit.addParam("board_idx", test);
	         comSubmit.addParam("board_name", board_name);
	         comSubmit.submit();
	    }
	    
	    if($(this).attr('id') == 'name'){
	    	  comSubmit.setUrl("<c:url value='/sample/studyBoardManageDetail.do'/>");
	         comSubmit.addParam("board_idx", test);
	         comSubmit.addParam("board_name", board_name);
	         comSubmit.submit();
	    }
	});

	 $("#openMask_board_create").on("click", function(e) { 
	e.preventDefault();
	wrapCreateBoardByMask();
	});

	$('.board_create_modal .close').click(function(e) {
	e.preventDefault();
	$('#mask_board_create, .board_create_modal').hide();
	});

	$('#mask_board_create').click(function() {
	$(this).hide();
	$('.board_create_modal').hide();
	});

	});
	
	
function wrapCreateBoardByMask() {
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();

	$('#mask_board_create').css({
	'width' : maskWidth,
	'height' : maskHeight
	});
	
	$('#mask_board_create').fadeTo("slow", 0.8);

	$('.board_create_modal').show();
	}
	
function insert_submit(){
	var form = document.board_create_insert_form;
	if(form.board_name.value==""||form.board_name.value==null){
	alert("게시판 이름을 입력해주세요");
	form.board_name.focus();
	return false;
	}
	form.submit();
	}

function ManageDetail(){
		 var btn = $(this);
	    var tr = btn.parent().parent();
	    var td = tr.children();
	   
	    
	    var board_idx = td.eq(0).text();
	    var board_name = td.eq(1).text();
	  
	    var name = $("#a_name").text();
	    alert(name);
		alert("info:"+board_idx+" , "+board_name);
}
	
</script>
</body>
</html>