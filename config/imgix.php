<?php
/**
 * Imgix plugin for Craft CMS 3.x
 *
 * Use Imgix with Craft
 *
 * @link      https://superbig.co
 * @copyright Copyright (c) 2017 Superbig
 */

/**
 * @author    Superbig
 * @package   Imgix
 * @since     2.0.0
 */

/**
 * Imgix config.php
 *
 * This file exists only as a template for the Imgix settings.
 * It does nothing on its own.
 *
 * Don't edit this file, instead copy it to 'craft/config' as 'imgix.php'
 * and make your changes there to override default settings.
 *
 * Once copied to 'craft/config', this file will be multi-environment aware as
 * well, so you can have different settings groups for each environment, just as
 * you do for 'general.php'
 */

return [
    // Imgix API key
    'apiKey'         => getenv('IMGIX_API_KEY'),

    // Volume handles mapped to Imgix domains
    'imgixDomains'   => ['images' => getenv('IMGIX_DOMAIN')],

    // Imgix signed URLs token
    'imgixSignedToken' => getenv('IMGIX_SIGN_KEY'),

    // Lazy load attribute prefix
    'lazyLoadPrefix' => '',
];