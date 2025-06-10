<?php
include('config.php');
$page = "index";
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Gérer les équipes de hockey">
    <meta name="dc.description" content="Gérer les équipes de hockey">
    <meta name="keywords" content="hockey,ligue,équipes">
    <meta name="dc.keywords" content="hockey,ligue,équipes">
	<title>Gérer les équipes de hockey</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <?php include('inc/entete.php'); ?>
    <div id="wrapAuPoulet">
        <div id="contenu">
            <p>
                Ce site affiche une liste d'équipes de hockey. On peut ajouter, modifier ou consulter une équipe en particulier. Dans l'entête, on a les actions disponibles à l'utilisateur.
            </p>
        </div>
    </div>
    <?php include('inc/pied.php') ?>
</body>
</html>