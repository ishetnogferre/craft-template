<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */

use craft\helpers\App;

$isDev = App::env('ENVIRONMENT') === 'dev';
$isProd = App::env('ENVIRONMENT') === 'production';
$isStaging = App::env('ENVIRONMENT') === 'staging';

return [
    // Default Week Start Day (0 = Sunday, 1 = Monday...)
    'defaultWeekStartDay' => 1,
    // Whether generated URLs should omit "index.php"
    'omitScriptNameInUrls' => true,
    // re-add html/html because Craft 3.6 removes them
    'extraAllowedFileExtensions' => ['htm', 'html'],
    // The URI segment that tells Craft to load the control panel
    'cpTrigger' => App::env('CP_TRIGGER') ?: 'admin',
    // The secure key Craft will use for hashing and encrypting data
    'securityKey' => App::env('SECURITY_KEY'),
    // Remove GraphQL from the Admin
    'enableGql' => false,

    // Whether Dev Mode should be enabled (see https://craftcms.com/guides/what-dev-mode-does)
    'allowAdminChanges' => $isDev,
    'allowUpdates' => $isDev,
    'backupOnUpdate' => $isDev,
    'devMode' => $isDev,
    'enableTemplateCaching' => !$isDev,
    'disallowRobots' => !$isProd,
    'isSystemLive' => $isProd,

    // Aliases parsed in sites’ settings, volumes’ settings, and Local volumes’ settings
    'aliases' => [
        '@webroot' => getenv('BASE_PATH') . 'web',
        '@basePath' => getenv('BASE_PATH'),
        '@baseUrl' => getenv('PRIMARY_SITE_URL'),
    ],
    'userbackToken' => getenv('USERBACK_TOKEN'),
];
