package tn.enis.controller;

import java.io.IOException;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import tn.enis.entity.Client;
import tn.enis.entity.Compte;
import tn.enis.service.ClientService;
import tn.enis.service.CompteService;

@WebServlet("/ClientController")
public class ClientController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
	private ClientService clientService;

	@EJB
	private CompteService compteService;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("Add".equals(action)) {
			String cin = request.getParameter("cin");
			String nom = request.getParameter("nom");
			String prenom = request.getParameter("prenom");

			if (cin.isEmpty() || nom.isEmpty() || prenom.isEmpty()) {
				String errorMessage = "Please fill in all fields!";
				request.setAttribute("errorMessage", errorMessage);
			} else if (cin.length() != 8) {
				String errorMessage = "CIN must be 8 digits!";
				request.setAttribute("errorMessage", errorMessage);
			} else if (!nom.matches("[a-zA-Z]+") || !prenom.matches("[a-zA-Z]+")) {
				String errorMessage = "Name and surname must contain only letters!";
				request.setAttribute("errorMessage", errorMessage);
			} else {
				Client existingClient = clientService.findById(cin);
				if (existingClient != null) {
					String errorMessage = "A client with the CIN " + cin + " already exists!";
					request.setAttribute("errorMessage", errorMessage);
				} else {
					Client client = new Client(cin, nom, prenom);
					clientService.save(client);
				}
			}
		} else if ("Delete".equals(request.getParameter("action"))) {
			String cin = request.getParameter("cin");
			List<Compte> comptes = compteService.findByCin(cin);
			for (Compte compte : comptes) {
				compteService.delete(compte.getRib());
			}
			clientService.delete(cin);
		} else if ("search".equals(action)) {
			String search = request.getParameter("search");
			request.setAttribute("clients", clientService.findAllByNomClient(search));
			request.getRequestDispatcher("clients.jsp").forward(request, response);
			return;
		} else if ("Update".equals(action)) {
			String cin = request.getParameter("cin");
			String nom = request.getParameter("nom");
			String prenom = request.getParameter("prenom");

			Client client = clientService.findById(cin);

			if (client != null) {
				client.setNom(nom);
				client.setPrenom(prenom);
				clientService.update(client);
			}
			request.setAttribute("clients", clientService.findAll());
			request.getRequestDispatcher("clients.jsp").forward(request, response);

		}

		List<Client> clients = clientService.findAll();
		request.setAttribute("clients", clients);
		request.getRequestDispatcher("clients.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
