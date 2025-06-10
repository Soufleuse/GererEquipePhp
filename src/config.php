<?php

$json = file_get_contents('securite.json');
$resultat_json = json_decode($json);

// BD AWS
$db_host = $resultat_json->db_host;  // Jamais utiliser 127.0.0.1 ou localhost
$db_name = $resultat_json->db_name;

// Compte de service
$db_user = $resultat_json->db_user;
$db_pass = $resultat_json->db_pass;

// Connexion a la BD
try {
  $conn = new mysqli('localhost', $db_user, $db_pass, $db_name);
} catch (PDOException $e) {
  echo "Erreur de connexion : " . $e->getMessage();
}