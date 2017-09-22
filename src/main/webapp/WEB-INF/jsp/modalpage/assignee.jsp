<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Font Awesome -->
<link rel="stylesheet" href="/resources/bower_components/font-awesome/css/font-awesome.min.css">

<!-- Assignee -->
<div class="modal fade" id="assignee-modal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content" style="width: 450px;height: auto;margin-top: 100px;margin-left: -65px;">
			<div class="modal-header" style="text-align: center;">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h3>Assignee & Role</h3>
				<div class="box-body">
					<table class="table" style="color: black;text-align: center;margin-bottom: 20px;">
						<tr>
							<!-- Assignee & Role LIST -->
							<td align="center" width="20%">ASSIGNEE</td>
							<td align="center" width="20%">ROLE</td>
							<td align="center" width="3%">
								<a href="javascript:createAssigneeTable();" class="text-muted"> 
								<i class="glyphicon glyphicon-plus" style="margin-top: 3px;"></i>
								</a>
							</td>
							<td align="center" width="3%">
							</td>
						</tr>
						<tbody id="assign-form"></tbody>
					</table>
					<button id="#" class="btn btn-success" style="margin-right: 40px;" type="button">Apply</button>
					<button id="#" class="btn btn-default" data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
function createAssigneeTable() {
	$.ajax({
		type:'get',
		url:'/assignees/CreateFormAssignee',
		dataType:'json',
		success:function (data) {
			var str='';
			str+="<tr class='tr-table'>";
			<!-- assignee select -->
			str+="<td>";
			str+="<p class='assignee-area'></p>";
			str+="<div class='assignee-selectBox' style='margin-top: -7px;'>";
			str+="<select id='assignee-select' class='form-control'>";
			str+="<option selected disabled hidden>Member</option>";
				var members = JSON.parse(data[0]);
				console.log("JS members : ", members)
				members.forEach(function(member){
					str+="<option value=" + member.userId + ">" + member.userId +"</option>";
				});
			str+="</select>";
			str+="</div>";
			str+="</td>";
			<!-- role select -->
	 		str+="<td>";
			str+="<p class='role-area'></p>";
			str+="<div class='role-selectBox' style='margin-top: -7px;'>";
			str+="<select id='role-select' class='form-control'>";
			str+="<option selected disabled hidden>Role</option>";
				var roles = JSON.parse(data[1]);
				console.log("JS roles : ", roles)
				roles.forEach(function(role){
					str+="<option value=" + role.roleName + ">" + role.roleName +"</option>";
				});
			str+="</select>";
			str+="</div>"
			str+="</td>"; 
			<!-- Icon -->
			str+="<td>";
			str+="<p class='trashIcon-control'>";
			str+="<a class='text-muted' href='#' onclick='javascript:deleteAssigneeTable($(this))'>";
			str+="<i class='glyphicon glyphicon-trash' style='margin-top: 11px; margin-right: 2px;'></i>";
			str+="</a>";
			str+="</p>";
			str+="</td>";
			str+="<td>";
			str+="<p class='pencilIcon-control'>";
			str+="<a class='i-class' href='#' onclick='javascript:createAssignee($(this))'>";
			str+="<i class='glyphicon glyphicon-ok' style='margin-top: 9px; margin-right: 2px;'></i>";
			str+="</a>";
			str+="</p>";
			str+="</td>"
			str+="</tr>";
			$('#assign-form').append(str);
		},
		error:ajaxError
	});
}

function deleteAssigneeTable(target) {
	target.parents('tr.tr-table').remove();
}

function updateAssigneeTable(target, assigneeNum) {
	$.ajax({
		type:'get',
		url:'/assignees/CreateFormAssignee',
		dataType:'json',
		success:function (data) {
			var str='';
			<!-- assignee select -->
			str+="<input class='assigneeNum' name='assigneeNum' type='hidden' value='" + assigneeNum + "'>";
			str+="<td>";
			str+="<p class='assignee-area'></p>";
			str+="<div class='assignee-selectBox' style='margin-top: -7px;'>"
			str+="<select id='assignee-select' class='form-control'>";
			str+="<option selected disabled hidden>Member</option>";
				var members = JSON.parse(data[0]);
				console.log("JS members : ", members)
				members.forEach(function(member){
					str+="<option value=" + member.userId + ">" + member.userId +"</option>";
				});
			str+="</select>";
			str+="</div>"
			str+="</td>";
			<!-- role select -->
	 		str+="<td>";
			str+="<p class='role-area'></p>";
			str+="<div class='role-selectBox' style='margin-top: -7px;'>";
			str+="<select id='role-select' class='form-control'>";
			str+="<option selected disabled hidden>Role</option>";
				var roles = JSON.parse(data[1]);
				console.log("JS roles : ", roles)
				roles.forEach(function(role){
					str+="<option value=" + role.roleName + ">" + role.roleName +"</option>";
				});
			str+="</select>";
			str+="</div>";
			str+="</td>"; 
			<!-- Icon -->
			str+="<td>";
			str+="<a href='#' onclick='javascript:deleteAssignee($(this))' class='text-muted'>";
			str+="<i class='glyphicon glyphicon-trash' style='margin-top: 11px; margin-right: 2px;'></i>";
			str+="</a>";
			str+="</td>";
			str+="<td>";
			str+="<a class='Iicon' href='#' onclick='javascript:updateAssignee($(this))'>";
			str+="<i class='glyphicon glyphicon glyphicon-ok' style='margin-top: 9px; margin-right: 2px;'></i>";
			str+="</a>";
			str+="</td>";
			target.parents('tr.tr-table').html(str);
		},
		error:ajaxError
	});
}

function createAssignee(target) {
	var thisClass = this;
	console.log("target ? : ", target);
	$.ajax({
		type:'get',
		data:{
			assigneeMember : target.parents('tr.tr-table').find('div.assignee-selectBox').find('select > option:selected').val(),
			roleName : target.parents('tr.tr-table').find('div.role-selectBox').find('select > option:selected').val(),
			cardNum : thisClass.$('#cardNum').val()
		},
		url:'/assignees/createAssignee',
		dataType:'json',
		
		success:function(data) {
			var str='';
			target.parents('tr.tr-table').attr("id","assignee" + data[0]);
			str+="<input class='assigneeNum' type='hidden' name='assigneeNum' value="+data[0]+">";
			str+="<td>";
			str+="<p class='assignee-area' style='margin-top: 8px;'>" + data[1] + "</p>";
			str+="</td>";
	 		str+="<td>";
	 		str+="<p class='role-area' style='margin-top: 8px;'>" + data[2] + "</p>";
			str+="</td>"; 
			<!-- Icon -->
			str+="<td>";
			str+="<a class='text-muted' href='#' onclick='javascript:deleteAssignee($(this))'>";
			str+="<i class='glyphicon glyphicon-trash' style='margin-top: 11px; margin-right: 2px;'></i>";
			str+="</a>";
			str+="</td>";
			str+="<td>";
			str+="<a class='i-class' class='i-class'href='#' onclick='javascript:updateAssigneeTable($(this)," + data[0] + ")'>";
			str+="<i class='glyphicon glyphicon-pencil' style='margin-top: 9px; margin-right: 2px;'></i>";
			str+="</a>";
			str+="</td>";
			target.parents('tr.tr-table').html(str);
		},
		error:ajaxError
	});
}

function deleteAssignee(target) {
	$.ajax({
		type:'get',
		data:{
			assigneeNum:target.parents('tr').find('input.assigneeNum').val()
		},
		url:"/assignees/deleteAssignee",
		
		success:function () {
			target.parents('tr.tr-table').remove();
		},
		error:ajaxError
	});
}

function updateAssignee(target) {
	$.ajax({
		type:'get',
		data:{
			assigneeNum:target.parents('tr.tr-table').find('input.assigneeNum').val(),
			assigneeMember : target.parents('tr.tr-table').find('div.assignee-selectBox').find('select > option:selected').val(),
			roleName : target.parents('tr.tr-table').find('div.role-selectBox').find('select > option:selected').val()
		},
		url:"/assignees/updateAssignee",
		dataType:'json',
		
		success:function (data) {
			console.log("TEST : ", data);
			var str='';
			target.parents('tr.tr-table').attr("id","assignee" + data.assigneeNum);
			str+="<input class='assigneeNum' type='hidden' name='assigneeNum' value="+data.assigneeNum+">";
			str+="<td>";
			str+="<p class='assignee-area' style='margin-top: 8px;'>" + data.userId + "</p>";
			str+="</td>";
	 		str+="<td>";
	 		str+="<p class='role-area' style='margin-top: 8px;'>" + data.roleName + "</p>";
			str+="</td>"; 
			<!-- Icon -->
			str+="<td>";
			str+="<a class='text-muted' href='#' onclick='javascript:deleteAssignee($(this))'>";
			str+="<i class='glyphicon glyphicon-trash' style='margin-top: 11px; margin-right: 2px;'></i>";
			str+="</a>";
			str+="</td>";
			str+="<td>";
			str+="<a class='i-class' class='i-class'href='#' onclick='javascript:updateAssigneeTable($(this)," + data.assigneeNum + ")'>";
			str+="<i class='glyphicon glyphicon-pencil' style='margin-top: 9px; margin-right: 2px;'></i>";
			str+="</a>";
			str+="</td>";
			target.parents('tr.tr-table').html(str);
		},
		error:ajaxError
	});
}
</script>