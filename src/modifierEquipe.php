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
        <div id="contenu">
            <p>
                <label for="cboListeEquipe">Équipe à modifier</label>
                <select id="cboListeEquipe" autofocus required>
                    <option value="">--- Sélectionnez une équipe ---</option>
                    <?php
                        include('inc/accesdonnees.php');
                        try {
                            $listeEquipe = ObtenirListeEquipe();
                            
                            foreach($listeEquipe as $uneEquipe) {
                                echo "<option value=\"" . $uneEquipe['id'] . "\">" .
                                     htmlspecialchars($uneEquipe['nomEquipe']) . " " .
                                     htmlspecialchars($uneEquipe['ville']) . "</option>";
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
                <input type="submit" id="btnEnregistrer" name="btnEnregistrer" value="Enregistrer" />
            </p>
        </div>
    </div>
    <?php include('inc/pied.php') ?>
</body>
</html>