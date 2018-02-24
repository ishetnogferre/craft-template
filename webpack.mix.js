// Set the mix variable
/* global path */
const mix = require('laravel-mix');
require('laravel-mix-purgecss');

/**
 * Packages used for build
 */
const webpack = require('webpack');
const moment = require('moment');
const gitRevSync = require('git-rev-sync');
const htmlCritical = require('html-critical-webpack-plugin');
const copy = require('copy');

// package vars
const pkg = require('./package.json');

// Our banner
const banner = (function () {
    return [
        '/**',
        ' * @project        Marbles Website',
        ' * @author         Marbles',
        ' * @build          ' + moment().format('llll') + ' GMT+1',
        ' * @release        ' + gitRevSync.long() + ' [' + gitRevSync.branch() + ']',
        ' * @copyright      Copyright (c) ' + moment().format('YYYY') + ', Marbles',
        ' *',
        ' */',
        '',
    ].join('\n');
})();

/**
 * Webpack plugins
 */
let webpackPlugins = [
    new webpack.BannerPlugin({
        banner: banner,
        raw: true,
    }),
];

/**
 * Webpack plugins that only need to be run in production
 */
if (mix.inProduction()) {
    const criticalUrls = [
        { url: '', template: 'index' },
    ];

    criticalUrls.forEach(function (element) {
        const criticalSrc = process.env.BASE_URL + element.url;
        const criticalDest = './templates/' + element.template + '_critical.min.css';

        webpackPlugins = webpackPlugins.concat([
            new htmlCritical({
                src: criticalSrc,
                dest: criticalDest,
                penthouse: {
                    blockJSRequests: false,
                    forceInclude: [],
                },
                inline: false,
                ignore: [],
                css: [
                    './web/dist/css/site.css',
                ],
                minify: true,
                width: 1200,
                height: 1200,
            }),
        ]);
    });
}

/**
 * Start the Mix function
 */
mix
    .options({
        processCssUrls: false, // Process/optimize relative stylesheet url()'s. Set to false, if you don't want them touched.
        postCss: [
            require('postcss-object-fit-images'),
            require('tailwindcss')('./tailwind.js'),
        ],
    })
    .webpackConfig({
        plugins: webpackPlugins,
        module: {
            rules: [
                {
                    test: /\.js$/,
                    exclude: /node_modules/,
                    loader: 'eslint-loader',
                    options: {
                        cache: true,
                    },
                },
            ],
        },
    })
    .babelConfig({
        'presets': ['env'],
        'compact': true,
    })
    .setPublicPath('./web/dist')
    .js('./src/js/site.js', './web/dist/js/')
    .extract(Object.keys(pkg.dependencies))
    .sass('./src/scss/site.scss', './web/dist/css')
    .purgeCss({
        globs: [
            path.join(__dirname, '/templates/**/*.{html,twig}'),
            path.join(__dirname, '/src/scss/*.scss'),
        ],
        extensions: ['html', 'js', 'php', 'vue', 'twig', 'scss', 'css'],
    })
    .version()
    .then(function () {
        // Copy inline js files
        const inlineFiles = [
            './node_modules/fg-loadcss/src/loadCSS.js',
            './node_modules/fg-loadcss/src/cssrelpreload.js',
            './node_modules/tiny-cookie/dist/tiny-cookie.min.js',
        ];

        copy.each(
            inlineFiles,
            './templates/_inlinejs', { flatten: true },
            (err) => {
                // eslint-disable-next-line no-console
                if (err) console.log(err);
            }
        );
    });