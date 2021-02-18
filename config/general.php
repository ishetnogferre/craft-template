<?php
/**
 * Craft 3 Multi-Environment
 * Efficient and flexible multi-environment config for Craft 3 CMS
 *
 * $_ENV constants are loaded by craft3-multi-environment from .env.php via
 * ./web/index.php for web requests, and ./craft for console requests
 *
 * @author    nystudio107
 * @copyright Copyright (c) 2017 nystudio107
 * @link      https://nystudio107.com/
 * @package   craft3-multi-environment
 * @since     1.0.5
 * @license   MIT
 */

/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here.
 * You can see a list of the default settings in src/config/GeneralConfig.php
 */

return [

    // All environments
    '*' => [
        'useProjectConfigFile' => true,

        // Craft defined config settings
        'defaultSearchTermOptions' => [
            'subLeft' => true,
            'subRight' => true,
        ],
        'generateTransformsBeforePageLoad' => true,
        'omitScriptNameInUrls' => true,
        'securityKey' => getenv('SECURITY_KEY'),
        'userbackToken' => getenv('USERBACK_TOKEN'),
        'siteUrl' => getenv('SITE_URL'),
        'siteName' => getenv('SITE_NAME'),

        // Aliases parsed in sites’ settings, volumes’ settings, and Local volumes’ settings
        'aliases' => [
            '@webroot' => getenv('BASE_PATH') . 'web',
            '@basePath' => getenv('BASE_PATH'),
            '@baseUrl' => getenv('BASE_URL'),
        ],
        'enableGql' => false,

    ],

    // Live (production) environment
    'production' => [
        // Disable project config changes on production
        'allowAdminChanges' => false,
        'allowUpdates' => false,
        'backupOnUpdate' => false,
        'devMode' => false,
        'enableTemplateCaching' => true,
        'isSystemLive' => true,
    ],

    // Staging (pre-production) environment
    'staging' => [
        // Disable project config changes on staging
        'allowAdminChanges' => false,
        // Craft defined config settings
        'allowUpdates' => false,
        'backupOnUpdate' => false,
        'devMode' => false,
        'enableTemplateCaching' => true,
        'isSystemLive' => false,
    ],

    // Local (development) environment
    'dev' => [
        // Craft defined config settings
        'allowUpdates' => true,
        'backupOnUpdate' => true,
        'devMode' => true,
        'enableTemplateCaching' => false,
        'isSystemLive' => true,
    ],
];
