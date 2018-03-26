// Set the mix variable
/* global path */
const mix = require('laravel-mix');

/* Mix Plugins */
require('laravel-mix-purgecss');
require('laravel-mix-tailwind');
require('laravel-mix-banner');
require('laravel-mix-eslint');
require('laravel-mix-critical');

/**
 * Start the Mix function
 */
mix
    .setPublicPath('./web/dist')
    .babelConfig({ 'presets': ['env'] })
    .banner({
        banner: (function () {
            const moment = require('moment');
            const gitRevSync = require('git-rev-sync');

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
        })(),
        raw: true,
        entryOnly: true,
    })
    .js('./src/js/site.js', './web/dist/js/').eslint({ cache: true })
    .sass('./src/scss/site.scss', './web/dist/css').tailwind()
    .critical({
        urls: [
            { src: process.env.BASE_URL + '/', dest: './templates/index_critical.min.css' },
        ],
        options: {
            minify: true,
            width: 1200,
            height: 1200,
        },
    })
    .purgeCss({
        enabled: mix.inProduction(),
        globs: [
            path.join(__dirname, '/templates/**/*.{html,twig}'),
            path.join(__dirname, '/src/scss/*.scss'),
        ],
        extensions: ['html', 'js', 'php', 'vue', 'twig', 'scss', 'css'],
    })
    .version()
    .then(function () {
        const copy = require('copy');
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