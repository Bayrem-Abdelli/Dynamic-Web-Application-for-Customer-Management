package tn.enis.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Singleton;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import tn.enis.entity.Client;

@Singleton
@LocalBean
public class ClientDao {

	@PersistenceContext
	private EntityManager entityManager;

	public void save(Client client) {
		entityManager.persist(client);
	}

	public Client findById(String cin) {
		return entityManager.find(Client.class, cin);
	}

	public void delete(Client client) {
		entityManager.remove(client);
	}

	public void update(Client client) {
		entityManager.merge(client);
	}

	public List<Client> findAll() {

		return entityManager.createQuery("select c from Client c", Client.class).getResultList();
	}

	public List<Client> findAllByNomClient(String fullName) {

		return entityManager
				.createQuery("select c from Client c where CONCAT(c.prenom, ' ', c.nom) like :fullName", Client.class)
				.setParameter("fullName", "%" + fullName + "%").getResultList();
	}

}
