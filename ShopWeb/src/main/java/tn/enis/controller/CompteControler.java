package tn.enis.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import tn.enis.entity.Client;
import tn.enis.entity.Compte;
import tn.enis.service.ClientService;
import tn.enis.service.CompteService;

@WebServlet("/CompteControler")
public class CompteControler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private CompteService compteService;
	@EJB
	private ClientService clientService;

	public CompteControler() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		if ("Add".equals(request.getParameter("action"))) {
			float solde = Float.parseFloat(request.getParameter("solde"));
			String cin = request.getParameter("cin");
			Client client = clientService.findById(cin);
			if (client != null) {
				Compte compte = new Compte(solde, client);
				compteService.save(compte);
			} else {
				response.getWriter().append("<h1>" + "Client non inscrit" + "</h1>");
			}
		} else if ("Delete".equals(request.getParameter("action"))) {
			long rib = Long.parseLong(request.getParameter("rib"));
			compteService.delete(rib);

		} else if ("search".equals(action)) {
			String search = request.getParameter("search");
			request.setAttribute("comptes", compteService.findAllByNomClient(search));
			request.getRequestDispatcher("Compte.jsp").forward(request, response);
			return;
		} else if ("getclientautocomplete".equals(request.getParameter("action"))) {
			List<Client> clients = clientService.findAll();

			JSONArray clientsArray = new JSONArray();
			for (Client client : clients) {
				String complete = client.getPrenom() + " " + client.getNom() + " " + client.getCin();
				JSONObject clientObject = new JSONObject();
				clientObject.put("value", complete);
				clientObject.put("item", client.getCin());
				clientsArray.put(clientObject);

			}
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.print(clientsArray.toString());
			out.flush();
		} else if ("Update".equals(action)) {
			long rib = Long.parseLong(request.getParameter("rib"));
			float solde = Float.parseFloat(request.getParameter("solde"));

			Compte compte = compteService.findById(rib);

			if (compte != null) {
				compte.setSolde(solde);
				compteService.update(compte);
			}
			request.setAttribute("comptes", compteService.findAll());
			request.getRequestDispatcher("Compte.jsp").forward(request, response);

		}

		List<Client> clients = clientService.findAll();
		List<Compte> comptes = compteService.findAll();

		request.setAttribute("clients", clients);
		request.setAttribute("comptes", comptes);
		request.getRequestDispatcher("Compte.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
