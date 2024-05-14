package tn.enis.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import tn.enis.dao.CompteDao;
import tn.enis.entity.Compte;


@Stateless
@LocalBean
public class CompteService {
	@EJB
	CompteDao compteDao;

	public void save(Compte client) {
		compteDao.save(client);
	}

	public Compte findById(Long rib) {
		return compteDao.findById(rib);
	}
	public void delete(Compte compte) {
		compteDao.delete(compte);
	}
	
	public void delete(Long rib) {
		delete(findById(rib));
	}

	public void update(Compte client) {
		compteDao.update(client);
	}

	public List<Compte> findAll() {
		return compteDao.findAll();
	}

	public List<Compte> findAllByNomClient(String nom) {
		return compteDao.findAllByClient(nom);
	}
	public List<Compte> findByCin(String cin) {
		return compteDao.findByCin(cin);
	}
}
