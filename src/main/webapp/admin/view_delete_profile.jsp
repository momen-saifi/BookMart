

		<c:if test="${not empty userobj }">
			<!-- start profile modal -->
			<!-- Button trigger modal -->

			<!-- Modal -->
			<div class="modal fade" id="profile-modal" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div
							class="modal-header primary-background text-white text-center">
							<h5 class="modal-title" id="exampleModalLabel">BookMart</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="container text-center">


								<h5 class="modal-title mt-3" id="exampleModalLabel">${ userobj.name }</h5>

								<!-- details -->
								<div id="profile-details">
									<table class="table">

										<tbody>
											<tr>
												<th scope="row">ID :</th>
												<td>${ userobj.id }</td>
											</tr>

											<tr>
												<th scope="row">Email :</th>
												<td>${ userobj.email }</td>
											</tr>

											<tr>
												<th scope="row">Phno :</th>
												<td>${ userobj.phno }</td>
											</tr>


										</tbody>
									</table>
								</div>

								<!-- profile edit -->
								<div id="profile-edit" style="display: none;">
									<h2 class="mt-2">Please Edit Carefully</h2>
									<form action="update_profile" method="post">
										<table class="table">
											<tbody>
												<tr>
													<th scope="row">ID :</th>
													<td><input type="text" class="form-control" name="id"
														value="${ userobj.id }" /></td>
												</tr>
												<tr>
													<th scope="row">Email :</th>
													<td><input type="email" class="form-control"
														name="email" value="${ userobj.email }" /></td>
												</tr>
												<tr>
													<th scope="row">Name :</th>
													<td><input type="text" class="form-control"
														name="fname" value="${ userobj.name }" /></td>
												</tr>
												<tr>
													<th scope="row">Phno :</th>
													<td><input type="text" class="form-control"
														name="phno" value="${ userobj.phno }" /></td>
												</tr>
												<tr>
													<th scope="row">Password :</th>
													<td><input type="password" class="form-control"
														name="password" value="${ userobj.password }" /></td>
												</tr>
											</tbody>
										</table>
										<div class="container">
											<button type="submit" class="btn btn-outline-primary">Save</button>
										</div>
									</form>

								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<button id="edit-profile-button" type="button"
								class="btn btn-primary">Edit</button>
						</div>
					</div>
				</div>
			</div>

			<!-- end profile modal -->



		</c:if>




<c:if test="${not empty userobj }">
	<script type="text/javascript">
		$(document).ready(function() {

			let editStatus = false;

			$('#edit-profile-button').click(function() {
				if (editStatus == false) {

					$('#profile-details').hide();

					$('#profile-edit').show();

					editStatus = true;

					$(this).text("Back")
				} else {
					$('#profile-details').show();

					$('#profile-edit').hide();

					editStatus = false;
					$(this).text("Edit")
				}

			})
		})
	</script>


</c:if>