<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */


$isDev = getenv('ENVIRONMENT') === 'dev';
$isProd = getenv('ENVIRONMENT') === 'production';
$isStaging = getenv('ENVIRONMENT') === 'staging';

return [
    'defaultWeekStartDay' => 1, // Default Week Start Day (0 = Sunday, 1 = Monday...)
    'enableCsrfProtection' => true,
    'omitScriptNameInUrls' => true, // Whether generated URLs should omit "index.php"
    'extraAllowedFileExtensions' => ['htm', 'html'], // re-add html/html because Craft 3.6 removes them
    'cpTrigger' => getenv('CP_TRIGGER') ?: 'admin',
    'securityKey' => getenv('SECURITY_KEY'),
    'enableGql' => false,
    'preventUserEnumeration' => true,

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
        '@baseUrl' => getenv('BASE_URL'),
    ],
    'userbackToken' => getenv('USERBACK_TOKEN'),
];
