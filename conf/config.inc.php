<?php
/**
 * Configuration de PhpMyAdmin
 */

// Configuration générale
$cfg['blowfish_secret'] = 'votre-cle-secrete-de-32-caracteres-minimum-ici-12345';

// Serveur MySQL/MariaDB
$i = 0;
$i++;
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['host'] = 'mon-exemple-php';
$cfg['Servers'][$i]['port'] = '3306';
//$cfg['Servers'][$i]['socket'] = '/run/mysqld/mysqld.sock';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;

// Répertoires temporaires
$cfg['TempDir'] = '/tmp/';
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';

// Sécurité
$cfg['CheckConfigurationPermissions'] = false;
$cfg['DefaultLang'] = 'fr';
$cfg['DefaultConnectionCollation'] = 'utf8mb4_unicode_ci';

// Interface
$cfg['NavigationTreeEnableGrouping'] = false;
$cfg['ShowPhpInfo'] = true;
$cfg['ShowChgPassword'] = true;
?>