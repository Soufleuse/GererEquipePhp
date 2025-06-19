<?php $page = "index"; ?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>Ajouter une équipe de hockey</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div id="wrap">
        <?php include('inc/entete.php'); ?>
        <div id="contenu">
            <?php
                include('inc/accesdonnees.php');
                try {
                    $listeEquipe = ObtenirListeEquipe();
                    echo "<div class=\"boite\">";
                    echo "<div class=\"titre\">Liste des équipes (Nom équipe/ville)</div>";
                    echo "<ul>";
                    
                    foreach($listeEquipe as $uneEquipe) {
                        echo "<li>" . $uneEquipe['nomEquipe'] . " " . $uneEquipe['ville'] . "</li>";
                    }
                        
                    echo "</ul>";
                    echo "</div>";
                }
                catch(Exception $ex) {
                    echo "<div class=\"erreur\">Une erreur s'est produite lors de la lecture des équipes.</div>";
                    error_log($ex);
                }
            ?>
        </div>
    </div>
    <?php include('inc/pied.php') ?>
</body>
</html>