// Variables globales
let toutesLesEquipes = [];
let equipesAffichees = [];
let currentPage = 1;
const itemsPerPage = 10;

// Vos fonctions d'accès aux données existantes
async function getEquipe(id) {
    if (id === undefined || id < 1) {
        return "";
    }
    
    const url = "http://localhost:5245/api/equipe/" + id;
    let json = "";
    try {
        const response = await fetch(url);
        if (!response.ok) {
            throw new Error(`Statut de la réponse : ${response.status}`);
        }
        json = await response.json();
        console.log(json);
    }
    catch (error) {
        console.error(error.message);
    }
    return json;
}

async function getListeEquipe() {
    const url = "http://localhost:5245/api/equipe/";
    let json = "";
    try {
        const response = await fetch(url);
        if (!response.ok) {
            throw new Error(`Statut de la réponse : ${response.status}`);
        }
        json = await response.json();
        console.log(json);
    }
    catch (error) {
        console.error(error.message);
        throw error;
    }
    return json;
}

async function majEquipe(entree) {
    console.log('Entrée majEquipe : ', entree);
    
    const url = "http://localhost:5245/api/equipe/" + entree.id;
    const headers = new Headers();
    headers.append('Content-Type', 'application/json');
    headers.append('accept', '*/*');
    
    try {
        const response = await fetch(url, {
            method: "PUT",
            headers: headers,
            body: JSON.stringify(entree)
        });
        
        if (!response.ok) {
            throw new Error(`Erreur HTTP: ${response.status}`);
        }
        
        alert("Équipe mise à jour avec succès!");
        console.log('Mise à jour réussie - Code:', response.status);
        await chargerEquipes(); // Recharger la liste
        
    } catch (error) {
        console.error('Erreur lors de la mise à jour:', error);
        alert("Erreur lors de la mise à jour de l'équipe.");
    }
}

async function ajoutEquipe(entree) {
    const url = "http://localhost:5245/api/equipe/";
    const headers = new Headers();
    headers.append('Content-Type', 'application/json');
    headers.append('accept', '*/*');
    
    try {
        const response = await fetch(url, {
            method: "POST",
            headers: headers,
            body: JSON.stringify(entree)
        });
        
        if (!response.ok) {
            throw new Error(`Erreur HTTP: ${response.status}`);
        }
        
        alert("Équipe ajoutée avec succès!");
        console.log('Ajout réussi - Code:', response.status);
        await chargerEquipes(); // Recharger la liste
        
    } catch (error) {
        console.error('Erreur lors de l\'ajout:', error);
        alert("Erreur lors de l\'ajout de l'équipe.");
    }
}

// Nouvelles fonctions pour l'interface
async function chargerEquipes() {
    showLoading(true);
    hideError();
    
    try {
        toutesLesEquipes = await getListeEquipe();
        equipesAffichees = [...toutesLesEquipes];
        mettreAJourStatistiques();
        afficherEquipes();
        currentPage = 1;
        mettreAJourPagination();
    } catch (error) {
        showError('Erreur lors du chargement des équipes: ' + error.message);
    } finally {
        showLoading(false);
    }
}

function mettreAJourStatistiques() {
    const stats = {
        total: toutesLesEquipes.length,
        est: toutesLesEquipes.filter(e => e.division && e.division.toLowerCase() === 'est').length,
        ouest: toutesLesEquipes.filter(e => e.division && e.division.toLowerCase() === 'ouest').length,
        central: toutesLesEquipes.filter(e => e.division && e.division.toLowerCase() === 'central').length
    };

    document.getElementById('totalEquipes').textContent = stats.total;
    document.getElementById('divisionEst').textContent = stats.est;
    document.getElementById('divisionOuest').textContent = stats.ouest;
    document.getElementById('divisionCentral').textContent = stats.central;
}

function afficherEquipes() {
    const tbody = document.getElementById('equipesTableBody');
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const equipesPage = equipesAffichees.slice(startIndex, endIndex);

    tbody.innerHTML = '';

    if (equipesPage.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="6" class="text-center py-4">
                    <i class="fas fa-search fa-2x text-muted mb-3"></i>
                    <p class="text-muted">Aucune équipe trouvée</p>
                </td>
            </tr>
        `;
        return;
    }

    equipesPage.forEach(equipe => {
        const divisionClass = getDivisionClass(equipe.division);
        const row = `
            <tr>
                <td>${equipe.id || 'N/A'}</td>
                <td><strong>${equipe.nomEquipe || 'Sans nom'}</strong></td>
                <td>${equipe.ville || 'N/A'}</td>
                <td><span class="division-badge ${divisionClass}">${equipe.division || 'N/A'}</span></td>
                <td>${equipe.anneeDebut || 'N/A'}</td>
                <td class="action-buttons">
                    <button class="btn btn-sm btn-hockey-success" title="Modifier" onclick="modifierEquipe(${equipe.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-sm btn-outline-primary" title="Voir détails" onclick="voirEquipe(${equipe.id})">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn btn-sm btn-hockey-danger" title="Supprimer" onclick="supprimerEquipe(${equipe.id})">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            </tr>
        `;
        tbody.innerHTML += row;
    });
}

function getDivisionClass(division) {
    if (!division) return '';
    switch (division.toLowerCase()) {
        case 'est': return 'division-est';
        case 'ouest': return 'division-ouest';
        case 'central': return 'division-central';
        default: return '';
    }
}

function mettreAJourPagination() {
    const totalPages = Math.ceil(equipesAffichees.length / itemsPerPage);
    const startItem = (currentPage - 1) * itemsPerPage + 1;
    const endItem = Math.min(currentPage * itemsPerPage, equipesAffichees.length);

    // Mise à jour des informations de pagination
    document.getElementById('paginationInfo').textContent = 
        `Affichage de ${startItem} à ${endItem} de ${equipesAffichees.length} équipes`;

    // Génération des boutons de pagination
    const paginationNav = document.getElementById('paginationNav');
    paginationNav.innerHTML = '';

    if (totalPages <= 1) return;

    // Bouton Précédent
    const prevDisabled = currentPage === 1 ? 'disabled' : '';
    paginationNav.innerHTML += `
        <li class="page-item ${prevDisabled}">
            <a class="page-link" href="#" onclick="changerPage(${currentPage - 1})">Précédent</a>
        </li>
    `;

    // Boutons numérotés
    for (let i = 1; i <= totalPages; i++) {
        const active = i === currentPage ? 'active' : '';
        paginationNav.innerHTML += `
            <li class="page-item ${active}">
                <a class="page-link" href="#" onclick="changerPage(${i})">${i}</a>
            </li>
        `;
    }

    // Bouton Suivant
    const nextDisabled = currentPage === totalPages ? 'disabled' : '';
    paginationNav.innerHTML += `
        <li class="page-item ${nextDisabled}">
            <a class="page-link" href="#" onclick="changerPage(${currentPage + 1})">Suivant</a>
        </li>
    `;
}

function changerPage(page) {
    const totalPages = Math.ceil(equipesAffichees.length / itemsPerPage);
    if (page < 1 || page > totalPages) return;
    
    currentPage = page;
    afficherEquipes();
    mettreAJourPagination();
}

function filtrerEquipes() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const divisionFilter = document.getElementById('divisionFilter').value.toLowerCase();

    equipesAffichees = toutesLesEquipes.filter(equipe => {
        const matchesSearch = !searchTerm || 
            (equipe.nomEquipe && equipe.nomEquipe.toLowerCase().includes(searchTerm)) ||
            (equipe.ville && equipe.ville.toLowerCase().includes(searchTerm));
        
        const matchesDivision = !divisionFilter || 
            (equipe.division && equipe.division.toLowerCase() === divisionFilter);

        return matchesSearch && matchesDivision;
    });

    currentPage = 1;
    afficherEquipes();
    mettreAJourPagination();
}

// Fonctions pour les actions des boutons
function modifierEquipe(id) {
    alert(`Fonction de modification pour l'équipe ${id} - À implémenter`);
}

function voirEquipe(id) {
    alert(`Fonction de visualisation pour l'équipe ${id} - À implémenter`);
}

function supprimerEquipe(id) {
    if (confirm('Êtes-vous sûr de vouloir supprimer cette équipe ?')) {
        alert(`Fonction de suppression pour l'équipe ${id} - À implémenter`);
    }
}

// Fonction pour ajouter une équipe depuis le modal
async function ajouterEquipe() {
    const form = document.getElementById('addTeamForm');
    const formData = new FormData(form);
    
    const nouvelleEquipe = {
        nom: formData.get('nomEquipe'),
        ville: formData.get('ville'),
        division: formData.get('division'),
        anneeFondation: parseInt(formData.get('anneeDebut')) || null,
        description: formData.get('description')
    };

    // Validation basique
    if (!nouvelleEquipe.nomEquipe || !nouvelleEquipe.ville || !nouvelleEquipe.division) {
        alert('Veuillez remplir tous les champs obligatoires');
        return;
    }

    try {
        await ajoutEquipe(nouvelleEquipe);
        // Fermer le modal
        const modal = bootstrap.Modal.getInstance(document.getElementById('addTeamModal'));
        modal.hide();
        // Réinitialiser le formulaire
        form.reset();
    } catch (error) {
        console.error('Erreur lors de l\'ajout:', error);
    }
}

// Fonctions utilitaires
function showLoading(show) {
    document.getElementById('loading').style.display = show ? 'block' : 'none';
}

function showError(message) {
    document.getElementById('errorText').textContent = message;
    document.getElementById('errorMessage').style.display = 'block';
}

function hideError() {
    document.getElementById('errorMessage').style.display = 'none';
}

// Event listeners
document.addEventListener('DOMContentLoaded', function() {
    // Charger les équipes au démarrage
    chargerEquipes();

    // Event listeners pour les filtres
    document.getElementById('searchInput').addEventListener('input', filtrerEquipes);
    document.getElementById('divisionFilter').addEventListener('change', filtrerEquipes);
});