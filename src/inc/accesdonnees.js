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