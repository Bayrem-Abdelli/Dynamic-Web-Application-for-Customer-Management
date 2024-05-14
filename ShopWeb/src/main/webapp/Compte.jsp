<!DOCTYPE html>
<%@page import="tn.enis.entity.Compte"%>
<%@page import="tn.enis.service.CompteService"%>
<%@page import="tn.enis.entity.Client"%>
<%@page import="java.util.List"%>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link
	href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- jQuery UI -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<meta charset="ISO-8859-1">
<title>Compte Management</title>
<script src="functions/updateCompte.js"></script>
<script src="functions/deleteCompte.js">

</script>

</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<% if (request.getAttribute("errorMessage") != null) { %>
				<div class="alert alert-primary" role="alert">
					<%= request.getAttribute("errorMessage") %>
				</div>
				<% } %>
			</div>
		</div>
	</div>

	<h1 class="text-center">Compte Management</h1>
	<form action="CompteControler" method="post">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<table class="table">
					<tr>
						<td>solde</td>
						<td><input type="text" name="solde" class="form-control" /></td>
					</tr>
					<tr>
						<td>CIN du Client</td>
						<td><input type="hidden" id="ajouter-nom-hidden" name="cin">

							<input type="text" class="form-control" id="ajouter-nom"
							name="nom"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" name="action" value="Add"
							class="btn btn-primary" /></td>
					</tr>
				</table>
			</div>
		</div>
	</form>
	<hr />
	<h2 class="text-center">Liste des Comptes</h2>
	<a href="CompteControler"></a>
	<%
	List<Compte> comptes = (List<Compte>) request.getAttribute("comptes");
	%>
	<table class="table table-striped table-bordered">
		<tr>
			<th>Rib</th>
			<th>Solde</th>
			<th>CIN</th>
			<th>Action</th>
		</tr>
		<%
		if (comptes != null && !comptes.isEmpty()) {
			for (Compte compte : comptes) {
		%>
		<tr id="tr<%=compte.getRib()%>">
			<td><%=compte.getRib()%></td>
			<td><%=compte.getSolde()%></td>
			<td><%=compte.getClient().getCin()%></td>
			<td><a href="#"
				onclick="showUpdateForm2('<%=compte.getRib()%>')">Modifier</a> <a
				href="#" onclick="deleteCompte('<%=compte.getRib()%>')">Supprimer</a>
			</td>
		</tr>
		<%
		}
		} else {
		%>
		<tr>
			<td colspan="4">Aucun compte trouvé.</td>
		</tr>
		<%
		}
		%>
	</table>
	<br />
	<form id="updateForm" action="CompteControler?action=Update"
		method="post" style="display: none;">
		<h2 class="text-center">Modifier un client</h2>
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<table class="table">
					<tr>
						<td>RIB</td>
						<td><input type="text" id="ribToUpdate" name="rib" readonly
							class="form-control" /></td>
					</tr>
					<tr>
						<td>Solde</td>
						<td><input type="text" name="solde" class="form-control" /></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" name="action" value="Update"
							class="btn btn-primary" />
							<button type="button" onclick="hideUpdateForm()"
								class="btn btn-secondary">Annuler</button></td>
					</tr>
				</table>
			</div>
		</div>
	</form>
	<div class="row justify-content-center mt-3">
		<div class="col-md-6 text-center">
			<a href="clients.jsp" class="btn btn-primary">Go to Clients Page</a>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
		integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
		integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
		crossorigin="anonymous"></script>

	<script>
		$.ajax({
			url : "CompteControler",
			method : "GET",
			data : {
				action : "getclientautocomplete"
			},
			dataType : "json",
			success : function(data) {
				$("#ajouter-nom").autocomplete({
					source : data,
					select : function(event, ui) {
						$("#ajouter-nom-hidden").val(ui.item.item);

					}

				});
			},
			error : function(xhr, status, error) {
				console.error(xhr.responseText);
			}
		});
	</script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="https://kit.fontawesome.com/b54f58a7b3.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>