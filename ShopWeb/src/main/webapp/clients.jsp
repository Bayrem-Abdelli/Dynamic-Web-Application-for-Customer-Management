<!DOCTYPE html>
<%@page import="tn.enis.entity.Client"%>
<%@page import="java.util.List"%>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<meta charset="ISO-8859-1">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<title>Client Management</title>
<script src="functions/updateClient.js"></script>
<script src="functions/deleteClient.js"> </script>
</head>
<body>
	<h1 class="text-center">Client Management</h1>
	<div class="container">
		<form autocomplete="off" action="ClientController" method="post"
			class="row justify-content-end mt-3">
			<div class="col-md-4">
				<div class="input-group">
					<input type="text" id="result" name="search" class="form-control"
						placeholder="Search" aria-label="Search"
						aria-describedby="button-addon2" onKeyUp="showResults(this.value)">
					<button class="btn btn-primary" type="submit" name="action"
						value="search" id="button-addon2">Search</button>
				</div>
			</div>
		</form>
	</div>

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

	<form action="ClientController" method="post">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<table class="table">
					<tr>
						<td>CIN</td>
						<td><input type="text" name="cin" class="form-control" /></td>
					</tr>
					<tr>
						<td>Nom</td>
						<td><input type="text" name="nom" class="form-control" /></td>
					</tr>
					<tr>
						<td>Prenom</td>
						<td><input type="text" name="prenom" class="form-control" /></td>
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
	<h2 class="text-center">Liste des Clients</h2>
	<a href="ClientController"></a>
	<%
    List<Client> clients = (List<Client>) request.getAttribute("clients");
    %>

	<table class="table table-striped table-bordered">
		<tr>
			<th>CIN</th>
			<th>Nom</th>
			<th>Prenom</th>
			<th>Action</th>
		</tr>
		<%
        if (clients != null && !clients.isEmpty()) {
            for (Client client : clients) {
        %>
		<tr id="tr<%=client.getCin()%>">
			<td><%=client.getCin()%></td>
			<td><%=client.getNom()%></td>
			<td><%=client.getPrenom()%></td>
			<td><a href="#"
				onclick="showUpdateForm1('<%=client.getCin()%>')">Modifier</a> | <a
				href="#" onclick="deleteClient('<%=client.getCin()%>')">Supprimer</a>
			</td>
		</tr>
		<%
            }
        } else {
        %>
		<tr>
			<td colspan="4">Aucun client trouvé.</td>
		</tr>
		<%
        }
        %>
	</table>
	<br />
	<form id="updateForm" action="ClientController?action=Update"
		method="post" style="display: none;">
		<h2 class="text-center">Modifier un client</h2>
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<table class="table">
					<tr>
						<td>CIN</td>
						<td><input type="text" id="cinToUpdate" name="cin" readonly
							class="form-control" /></td>
					</tr>
					<tr>
						<td>Nom</td>
						<td><input type="text" name="nom" class="form-control" /></td>
					</tr>
					<tr>
						<td>Prenom</td>
						<td><input type="text" name="prenom" class="form-control" /></td>
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
			<a href="Compte.jsp" class="btn btn-primary">Go to creat account</a>
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



</body>

</html>