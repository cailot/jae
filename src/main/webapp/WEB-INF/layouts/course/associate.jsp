<link rel="stylesheet"
	href="https://unpkg.com/bootstrap-table@1.21.4/dist/bootstrap-table.min.css">
<script
	src="https://unpkg.com/bootstrap-table@1.21.4/dist/bootstrap-table.min.js"></script>

<script>
	$(document).ready(
			function() {
				$('#courseDropdown').on(
						'change',
						function() {
							var selectedOptionText = $(this).find(
									'option:selected').text();
							// add new row into table
							var table = document.getElementById(
									"gradeAssociateCourseTable")
									.getElementsByTagName('tbody')[0];
							var row = table.insertRow(0);
							var cell0 = row.insertCell(0);
							cell0.innerHTML = $(this).find('option:selected').val();
							$(cell0).addClass('hidden-column');
							var val = selectedOptionText.split("...");
							var cell1 = row.insertCell(1);
							cell1.innerHTML = val[0];
							var cell2 = row.insertCell(2);
							cell2.innerHTML = val[1];
							var cell3 = row.insertCell(3);
							cell3.innerHTML = '<a href="javascript:void(0)" title="Delete Course"><i class="fa fa-trash"></i></a>';
							
						});
				
				
				$('#gradeAssociateCourseTable').on('click', 'a', function() {
			    	var row = $(this).closest('tr');
			      var name = row.find('td:eq(1)').text();
			      if (confirm('Are you sure you want to remove ' + name + '?')) {
			        row.remove();
			      }
			    });

			});

	function listCourses() {

		var body = $('#list-grade-associate-body');
		var grade = $("#courseGrade").val();
		const dropdown = document.getElementById("courseDropdown");
		body.empty();
		// remove all options before fetching new list
		while (dropdown.options.length > 0) {
			dropdown.remove(0);
		}
		const title = document.createElement("option");
		title.textContent = "Click to add a subject";
		dropdown.appendChild(title);

		$.ajax({
			url : "course/list",
			type : 'GET',
			data : grade,
			success : function(data) {
				$.each(data, function(i, item) {
					if (item.grade == grade) {
						var row = $('<tr></tr>');
						row.append($('<td class="hidden-column"></td>').text(item.id));
						row.append($('<td></td>')
								.text(item.grade.toUpperCase()));
						row.append($('<td></td>').text(item.name));
						row.append($('<td><a href="javascript:void(0)" title="Delete Course"><i class="fa fa-trash"></i></a></td>'));
						
						body.append(row);
					} else {
						//console.log(item.id);
						const option = document.createElement("option");
						option.value = item.id;
						option.textContent = item.grade.toUpperCase() + "..."
								+ item.name;
						dropdown.appendChild(option);
					}
				});
			}
		});
	}
	
	function associateCourse(){
		var sId = $("#formId").val();
		//console.log(id);
		var cId = [];
		$("#gradeAssociateCourseTable tbody tr").each(function() {
		  cId.push($(this).find("td").eq(0).text());
		});
		
		$.ajax({
		    url: "/associateCourse",
		    method: "POST",
		    data: {
		        "studentId": sId,
		        "courseId": cId
		    },
		    dataType: "json",
		    success: function(response) {
		        console.log("AJAX request successful:");
		        console.log(response);
		    },
		    error: function(xhr, status, error) {
		        console.log("AJAX request failed:");
		        console.log(xhr.responseText);
		    }
		});
		

	}
	
</script>

<!-- List Body -->
<div class="row">
	<div class="modal-body">
		<div class="modal-body">
			<form>
				<div class="form-group">
					<div class="form-row">
						<div class="col-md-3">
							<label for="formGrade" class="label-form">Grade</label> <select
								class="form-control form-control-sm" id="courseGrade"
								name="courseGrade">
								<option value="p2">P2</option>
								<option value="p3">P3</option>
								<option value="p4">P4</option>
								<option value="p5">P5</option>
								<option value="p6">P6</option>
								<option value="s7">S7</option>
								<option value="s8">S8</option>
								<option value="s9">S9</option>
								<option value="s10">S10</option>
								<option value="s10e">S10E</option>
								<option value="tt6">TT6</option>
								<option value="tt8">TT8</option>
								<option value="tt8e">TT8E</option>
								<option value="srw4">SRW4</option>
								<option value="srw5">SRW5</option>
								<option value="srw6">SRW6</option>
								<option value="srw8">SRW8</option>
								<option value="jmss">JMSS</option>
								<option value="vce">VCE</option>
							</select>
						</div>
						<div class="col-md-2">
							<button type="button" class="btn btn-block btn-primary btn-sm"
								onclick="listCourses()">Search</button>
						</div>
						<div class="col-md-5">
							<label for="" class="label-form">Select to add subject</label> <select
								class="form-control form-control-sm" id="courseDropdown"
								name="courseDropdown">
								<option value="p2">Click to add a subject</option>
							</select>
						</div>
						<div class="col-md-2">
							<button type="button" class="btn btn-block btn-primary btn-sm"
								onclick="associateCourse()">save</button>
						</div>
					</div>
				</div>


				<div class="form-group">
					<div class="form-row">
						<div class="col-md-12">
							<div class="table-wrap">
								<table id="gradeAssociateCourseTable" data-toggle="table">
									<thead class="table-primary">
										<tr>
											<th class="hidden-column"></th>
											<th>Grade</th>
											<th>eLearning Subject</th>
											<th>Delete</th>
											
										</tr>
									</thead>
									<tbody id="list-grade-associate-body">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>



	</div>
</div>







