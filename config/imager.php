<?php

return [
    'transformer' => 'craft',
    'imagerSystemPath' => '@webroot/assets/imager/',
    'imagerUrl' => '/assets/imager/',
    'cacheEnabled' => true,
    'cacheRemoteFiles' => true,
    'cacheDuration' => 1209600,
    'cacheDurationRemoteFiles' => 1209600,
    'cacheDurationExternalStorage' => 1209600,
    'cacheDurationNonOptimized' => 300,
    'jpegQuality' => 80,
    'pngCompressionLevel' => 2,
    'webpQuality' => 80,
    'webpImagickOptions' => [],
    'useCwebp' => false,
    'cwebpPath' => '/usr/bin/cwebp',
    'cwebpOptions' => '',
    'interlace' => true,
    'allowUpscale' => true,
    'resizeFilter' => 'lanczos',
    'smartResizeEnabled' => false,
    'removeMetadata' => true,
    'bgColor' => '',
    'position' => '50% 50%',
    'letterbox' => ['color' => '#000', 'opacity' => 0],
    'useFilenamePattern' => true,
    'filenamePattern' => '{basename}_{transformString|hash}.{extension}',
    'shortHashLength' => 10,
    'hashFilename' => 'postfix', // deprecated
    'hashPath' => false,
    'addVolumeToPath' => true,
    'hashRemoteUrl' => false,
    'useRemoteUrlQueryString' => false,
    'instanceReuseEnabled' => false,
    'noop' => false,
    'suppressExceptions' => false,
    'convertToRGB' => true,
    'skipExecutableExistCheck' => false,
    'curlOptions' => [],
    'runJobsImmediatelyOnAjaxRequests' => true,
    'fillTransforms' => false,
    'fillAttribute' => 'width',
    'fillInterval' => '200',
    'clearKey' => '',

    'useForNativeTransforms' => false,
    'useForCpThumbs' => false,

    'imgixProfile' => 'default',
    'imgixConfig' => [
        'default' => [
            'domains' => [],
            'useHttps' => true,
            'signKey' => '',
            'sourceIsWebProxy' => false,
            'useCloudSourcePath' => true,
            'shardStrategy' => 'cycle',
            'getExternalImageDimensions' => true,
            'defaultParams' => [],
        ]
    ],

    'optimizeType' => 'job',
    'optimizers' => ['jpegoptim', 'gifsicle', 'optipng'],
    'optimizerConfig' => [
        'jpegoptim' => [
            'extensions' => ['jpg'],
            'path' => '/usr/bin/jpegoptim',
            'optionString' => '-s',
        ],
        'jpegtran' => [
            'extensions' => ['jpg'],
            'path' => '/usr/bin/jpegtran',
            'optionString' => '-optimize -copy none',
        ],
        'mozjpeg' => [
            'extensions' => ['jpg'],
            'path' => '/usr/bin/mozjpeg',
            'optionString' => '-optimize -copy none',
        ],
        'optipng' => [
            'extensions' => ['png'],
            'path' => '/usr/bin/optipng',
            'optionString' => '-o2',
        ],
        'pngquant' => [
            'extensions' => ['png'],
            'path' => '/usr/bin/pngquant',
            'optionString' => '--strip --skip-if-larger',
        ],
        'gifsicle' => [
            'extensions' => ['gif'],
            'path' => '/usr/bin/gifsicle',
            'optionString' => '--optimize=3 --colors 256',
        ],
        'tinypng' => [
            'extensions' => ['png','jpg'],
            'apiKey' => '',
        ],
        'kraken' => [
            'extensions' => ['png', 'jpg', 'gif'],
            'apiKey' => '',
            'apiSecret' => '',
            'additionalParams' => [
                'lossy' => true,
            ]
        ],
        'imageoptim' => [
            'extensions' => ['png', 'jpg', 'gif'],
            'apiUsername' => '',
            'quality' => 'medium'
        ],
    ],

    'storages' => [],
    'storageConfig' => [
        'aws' => [
            'accessKey' => '',
            'secretAccessKey' => '',
            'region' => '',
            'bucket' => '',
            'folder' => '',
            'requestHeaders' => array(),
            'storageType' => 'standard',
            'cloudfrontInvalidateEnabled' => false,
            'cloudfrontDistributionId' => '',
        ],
        'gcs' => [
            'keyFile' => '',
            'bucket' => '',
            'folder' => '',
        ],
    ],
];