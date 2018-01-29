// Set the mix variable
const mix = require('laravel-mix');

// Load all plugins into $
const $ = require('webpack-load-plugins')({
    pattern: ['*'],
});

// package vars
const pkg = require('./package.json');

// Our banner
const banner = (function () {
    return [
        '/**',
        ' * @project        ' + pkg.name,
        ' * @author         ' + pkg.author,
        ' * @build          ' + $.moment().format('llll') + ' GMT+1',
        ' * @release        ' + $.gitRevSync.long() + ' [' + $.gitRevSync.branch() + ']',
        ' * @copyright      Copyright (c) ' + $.moment().format('YYYY') + ', ' + pkg.copyright,
        ' *',
        ' */',
        '',
    ].join('\n');
})();

/**
 * Vendor packages to extract into a separate vendor file
 */
const vendorPackages = Object.keys(pkg.dependencies);

/**
 * PostCSS Plugins
 */
const postCSSPlugins = [
    require('postcss-object-fit-images'),
    require('tailwindcss')('./tailwind.js'),
];

/**
 * Webpack plugins
 */
let webpackPlugins = [
    new $.webpack.BannerPlugin({
        banner: banner,
        raw: true,
    }),
];

/**
 * Webpack plugins that only need to be run in production
 */
if (mix.inProduction()) {
    webpackPlugins = webpackPlugins.concat([
        new $.purgecss({
            paths: $.globAll.sync(pkg.globs.purgecss),
            extractors: [
                {
                    extractor: class {
                        static extract(content) {
                            return content.match(/[A-z0-9-:/]+/g);
                        }
                    },
                    extensions: ['html', 'js', 'php', 'vue', 'twig', 'scss', 'css'],
                },
            ],
        }),
    ]);

    pkg.globs.critical.forEach(function (element) {
        const criticalSrc = pkg.url + element.url;
        const criticalDest = pkg.paths.templates + element.template + '_critical.min.css';

        webpackPlugins = webpackPlugins.concat([
            new $.htmlCritical({
                src: criticalSrc,
                dest: criticalDest,
                penthouse: {
                    blockJSRequests: false,
                    forceInclude: pkg.globs.criticalWhitelist,
                },
                inline: false,
                ignore: [],
                css: [
                    pkg.paths.dist.scss + pkg.vars.cssName,
                ],
                minify: true,
                width: 1200,
                height: 1200,
            }),
        ]);
    });
}

// Process data in an array synchronously, moving onto the n+1 item only after the nth item callback
function doSynchronousLoop(data, processData, done) {
    if (data.length > 0) {
        const loop = (data, i, processData, done) => {
            processData(data[i], i, () => {
                if (++i < data.length) {
                    loop(data, i, processData, done);
                } else {
                    done();
                }
            });
        };
        loop(data, 0, processData, done);
    } else {
        done();
    }
}

// Process the downloads one at a time
function processDownload(element, i, callback) {
    const downloadSrc = element.url;
    const downloadDest = element.dest;

    $.fancyLog('-> Downloading URL: ' + $.chalk.cyan(downloadSrc) + ' -> ' + $.chalk.magenta(downloadDest));
    $.download(downloadSrc, downloadDest);
    callback();
}

/**
 * Start the Mix function
 */
mix
    .options({
        processCssUrls: false, // Process/optimize relative stylesheet url()'s. Set to false, if you don't want them touched.
        postCss: postCSSPlugins,
    })
    .webpackConfig({
        plugins: webpackPlugins,
    })
    .setPublicPath(
        pkg.paths.dist.base
    )
    .js(
        pkg.paths.src.js + pkg.vars.jsName, // ./src/js/site.js
        pkg.paths.dist.js // ./web/js/{site|vendor|manifest}.js
    )
    .extract(
        vendorPackages
    )
    .sass(
        pkg.paths.src.scss + pkg.vars.scssName, // ./src/scss/site.scss
        pkg.paths.dist.scss // ./web/css/site.css
    )
    .version()
    .then(function () {
        if (mix.inProduction()) {
            doSynchronousLoop(pkg.globs.download, processDownload, () => {
                $.fancyLog('Downloads complete');
            });
        }

        // Copy inline js files
        $.copy.each(pkg.globs.inlineJs, pkg.paths.templates + '_inlinejs', {
            flatten: true,
        }, (e) => {
            if (e) $.fancyLog($.chalk.magenta(e));
        });
    });