async function getEquipe(id) {
    if (id === undefined) {
        return "";
    }
    
    if (id < 1) {
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

async function majEquipe(entree)
{
    console.log('Entrée majEquipe : ', entree);
    
    const url = "http://localhost:5245/api/equipe/" + entree.id;
    console.log("url : ", url);
    console.log("data stringifié : " + JSON.stringify(entree));

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
        
        // Optionnel : réinitialiser le formulaire ou rediriger
        // document.forms["modificationequipe"].reset();
        
    } catch (error) {
        console.error('Erreur lors de la mise à jour:', error);
        alert("Erreur lors de la mise à jour de l'équipe.");
    }
}