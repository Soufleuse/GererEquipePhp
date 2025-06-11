<?php
include('config.php');
$page = "index";
?>
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
                try {
                    $sqlEquipe = "SELECT * FROM Equipe";
                    $rsEquipe = $conn->query( $sqlEquipe );
                    echo "<div class=\"boite\">";
                    echo "<div class=\"titre\">Liste des équipes (Nom équipe/ville)</div>";
                    
                    echo "<ul>";
                    
                    while( $rowEquipe = $rsEquipe->fetch_assoc() ) {
                        echo "<li>" . $rowEquipe['NomEquipe'] . " " . $rowEquipe['Ville'] . "</li>";
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