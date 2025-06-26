<?php $page = "index"; ?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>Ajouter une équipe de hockey</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <?php include('inc/entete.php'); ?>
    <div id="wrap">
        <form name="ajoutequipe" onsubmit="return soumettreFormulaire(event)">
            <p>
                <label for="txtIdEquipe">Id de la nouvelle équipe</label>
                <input type="text" id="txtIdEquipe" name="txtIdEquipe" readonly value="0"></input>
                <label>* L'id sera attribué à la création de l'équipe.</label>
            </p>
            <p>
                <label for="txtNomEquipe">Nom de l'équipe</label>
                <input type="text" id="txtNomEquipe" name="txtNomEquipe" maxlength="50" placeholder="Nom de l'équipe" required></input>
            </p>
            <p>
                <label for="txtVille">Ville hôte</label>
                <input type="text" id="txtVille" name="txtVille" maxlength="50" placeholder="Ville hôte" required></input>
            </p>
            <p>
                <label for="txtAnneeDebut">Année de début d'existence de la formation</label>
                <input type="number" id="txtAnneeDebut" name="txtAnneeDebut" maxlength="4" placeholder="1999" required></input>
            </p>
            <p>
                <label for="txtAnneeFin">Année de fin d'existence de la formation</label>
                <input type="number" id="txtAnneeFin" name="txtAnneeFin" maxlength="4" placeholder="1999"></input>
            </p>
            <p>
                <label for="txtEsDevenu">Est devenue la formation</label>
                <input type="number" id="txtEsDevenu" name="txtEsDevenu" maxlength="4" placeholder="1"></input>
            </p>
            <p>
                <input type="submit"
                       id="btnEnregistrer"
                       name="btnEnregistrer"
                       value="Enregistrer" />
            </p>
        </form>
    </div>
    <script type="text/javascript" src="inc/accesdonnees.js"></script>
    <script type="text/javascript">
        // Fonction pour convertir une chaîne en nombre ou null
        function convertirEnNombreOuNull(valeur) {
            if (valeur === "" || valeur === null || valeur === undefined) {
                return null;
            }
            const nombre = parseInt(valeur);
            return isNaN(nombre) ? null : nombre;
        }

        async function soumettreFormulaire(event) {
            event.preventDefault(); // Empêche la soumission normale du formulaire

            const idNouvelleEquipe = await getDernierNumeroEquipe();
            
            // Récupération des données du formulaire
            //const idEquipe = document.getElementById("txtIdEquipe").value;
            const nomEquipe = document.getElementById("txtNomEquipe").value;
            const ville = document.getElementById("txtVille").value;
            const anneedebut = document.getElementById("txtAnneeDebut").value;
            const anneefin = document.getElementById("txtAnneeFin").value;
            const estdevenuequipe = document.getElementById("txtEsDevenu").value;
            
            // Validation basique
            if (idNouvelleEquipe == undefined || idNouvelleEquipe < 1) {
                alert("Le id de la nouvelle équipe n'a pas pu être initialisé.");
                return false;
            }

            if (!nomEquipe || !ville || !anneedebut) {
                alert("Veuillez remplir tous les champs obligatoires.");
                return false;
            }
            
            // Création de l'objet à envoyer
            const equipeData = {
                id: parseInt(idNouvelleEquipe),
                nomEquipe: nomEquipe,
                ville: ville,
                anneeDebut: parseInt(anneedebut),
                anneeFin: convertirEnNombreOuNull(anneefin),
                estDevenueEquipe: convertirEnNombreOuNull(estdevenuequipe)
            };

            // Appel de votre fonction ajoutEquipe
            ajoutEquipe(equipeData);
            
            return false; // Empêche la soumission du formulaire
        }
        </script>
    <?php include('inc/pied.php') ?>
</body>
</html>