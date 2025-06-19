<?php $page = "modifierEquipe"; ?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>Modifier une équipe de hockey</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <?php include('inc/entete.php'); ?>
    <div id="wrap">
        <form name="modificationequipe" onsubmit="return soumettreFormulaire(event)">
            <p>
                <label for="cboListeEquipe">Équipe à modifier</label>
                <select id="cboListeEquipe" name="cboListeEquipe" onchange="afficher()">
                    <option value="">--- Sélectionnez une équipe ---</option>
                    <?php
                        include('inc/accesdonnees.php');
                        try {
                            $listeEquipe = ObtenirListeEquipe();
                            
                            foreach($listeEquipe as $uneEquipe) {
                                echo "<option value=\"" . $uneEquipe['id'] . "\">" .
                                        htmlspecialchars($uneEquipe['nomEquipe']) . " " .
                                        htmlspecialchars($uneEquipe['ville']) . "</option>\r\n";
                            }
                        }
                        catch(Exception $ex) {
                            echo "<div class=\"erreur\">Une erreur s'est produite lors de la lecture des équipes.</div>";
                            error_log($ex);
                        }
                    ?>
                </select>
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
        async function afficher() {
            let mesEquipes = document.getElementById("cboListeEquipe");
            let maSelection = mesEquipes.value;
            let jsonnewsted = await getEquipe(mesEquipes.value);
            console.log(JSON.stringify(jsonnewsted));

            let nomEquipe = document.getElementById("txtNomEquipe");
            nomEquipe.value = jsonnewsted.nomEquipe;
            let ville = document.getElementById("txtVille");
            ville.value = jsonnewsted.ville;
            let anneedebut = document.getElementById("txtAnneeDebut");
            anneedebut.value = jsonnewsted.anneeDebut ?? "";
            let anneefin = document.getElementById("txtAnneeFin");
            anneefin.value = jsonnewsted.anneeFin ?? "";
            let estdevenuequipe = document.getElementById("txtEsDevenu");
            estdevenuequipe.value = jsonnewsted.estDevenueEquipe ?? "";
        }
        
        // Fonction pour convertir une chaîne vide en null
        function convertirVideEnNull(valeur) {
            return valeur === "" ? null : valeur;
        }
        
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
            
            // Récupération des données du formulaire
            const idEquipe = document.getElementById("cboListeEquipe").value;
            const nomEquipe = document.getElementById("txtNomEquipe").value;
            const ville = document.getElementById("txtVille").value;
            const anneedebut = document.getElementById("txtAnneeDebut").value;
            const anneefin = document.getElementById("txtAnneeFin").value;
            const estdevenuequipe = document.getElementById("txtEsDevenu").value;
            
            // Validation basique
            if (!idEquipe || !nomEquipe || !ville || !anneedebut) {
                alert("Veuillez remplir tous les champs obligatoires.");
                return false;
            }
            
            // Création de l'objet à envoyer
            const equipeData = {
                id: parseInt(idEquipe),
                nomEquipe: nomEquipe,
                ville: ville,
                anneeDebut: parseInt(anneedebut),
                anneeFin: convertirEnNombreOuNull(anneefin),
                estDevenueEquipe: convertirEnNombreOuNull(estdevenuequipe)
            };

            console.log("Données à envoyer:", JSON.stringify(equipeData));
            
            // Appel de votre fonction majEquipe
            await majEquipe(equipeData);
            
            return false; // Empêche la soumission du formulaire
        }
        </script>
    <?php include('inc/pied.php') ?>
</body>
</html>