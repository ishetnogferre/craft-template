<?php

return [
    '*' => [
        'transformer' => 'imgix',

        'imagerSystemPath' => '@webroot/assets/imager/',
        'imagerUrl' => '/assets/imager/',

        'allowUpscale' => false,
        'removeMetadata' => true,
        'convertToRGB' => true,

        'useForNativeTransforms' => true,
        'useForCpThumbs' => true,

        'imgixProfile' => 'default',
        'imgixApiKey' => getenv('IMGIX_API_KEY'),
        'imgixEnableAutoPurging' => true,
        'imgixEnablePurgeElementAction' => true,
        'imgixConfig' => [
            'default' => [
                'domains' => [getenv('IMGIX_DOMAIN')],
                'useHttps' => true,
                'signKey' => getenv('IMGIX_SIGN_KEY'),
                'sourceIsWebProxy' => false,
                'useCloudSourcePath' => true,
                'shardStrategy' => 'cycle',
                'getExternalImageDimensions' => true,
                'defaultParams' => [
                    'auto' => 'compress,format'
                ],
                'apiKey' => getenv('IMGIX_API_KEY'),
                'excludeFromPurge' => false,
            ]
        ],
    ],

    'dev' => [
        'transformer' => 'craft',
    ],
];
