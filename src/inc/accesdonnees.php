<?php
    // Gère les méthodes REST API : POST, PUT, GET etc
    // Data: array("param" => "value") ==> index.php?param=value

    $g_url = "http://localhost:5245/api/equipe";

    function ObtenirListeEquipe() {
        global $g_url;
        $curl = curl_init();

        curl_setopt($curl, CURLOPT_URL, $g_url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

        $result = curl_exec($curl);

        curl_close($curl);

        $result_decode = json_decode($result, true);

        return $result_decode;
    }

    function ObtenirNouvelIdEquipe() {
        global $g_url;
        $curl = curl_init();

        curl_setopt($curl, CURLOPT_URL, $g_url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

        $result = curl_exec($curl);

        curl_close($curl);

        $result_decode = json_decode($result, true);

        return $result_decode;
    }
?>