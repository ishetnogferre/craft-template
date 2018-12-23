let mix = require('laravel-mix');

/* Mix Plugins */
require("laravel-mix-purgecss");

mix
    .js('src/js/site.js', './web/dist')
    .postCss('src/css/site.css', './web/dist')

    .setPublicPath('./web/dist')

    .options({
        // Our own set of PostCSS plugins.
        postCss: [
            require('postcss-easy-import')(),
            require('tailwindcss')('./tailwind.js'),
            require('postcss-cssnext')(),
        ],

        // CSSNext already processes our css with Autoprefixer, so we don't
        // need mix to do it twice.
        autoprefixer: false,

        // Since we don't do any image preprocessing and write url's that are
        // relative to the site root, we don't want the css loader to try to
        // follow paths in `url()` functions.
        processCssUrls: false,
    })

    .version()

    .babelConfig({
        plugins: ['@babel/syntax-dynamic-import'],
    })

    .webpackConfig({
        output: {
            // The public path needs to be set to the root of the site so
            // Webpack can locate chunks at runtime.
            publicPath: '/',

            // We'll place all chunks in the `js` folder by default so we don't
            // need to worry about ignoring them in our version control system.
            chunkFilename: 'js/[name].js',
        },
    })

    .purgeCss({
        enabled: mix.inProduction(),
        globs: [
            path.join(__dirname, "/templates/**/*.{html,twig}"),
            path.join(__dirname, "/src/css/**/*.css"),
        ],
        extensions: ["html", "js", "php", "vue", "twig", "scss", "css"],
        whitelistPatterns: [/ls-blur-up-img/],
        whitelistPatternsChildren: [/body/, /ls-blur-up-img/],
    });
