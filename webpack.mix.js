let mix = require('laravel-mix');
const CompressionPlugin = require('compression-webpack-plugin');

/* Mix Plugins */
require("laravel-mix-purgecss");

const webpackPlugins = [
  new CompressionPlugin({
      filename: '[path].gz[query]',
      algorithm: 'gzip',
      test: /\.js$|\.css$|\.html$|\.eot?.+$|\.ttf?.+$|\.woff?.+$|\.svg?.+$/,
      threshold: 10240,
      minRatio: 0.8
  })
];

mix
    .js('src/js/site.js', './web/dist/js')
    .extract()
    .postCss('src/css/site.css', './web/dist/css')

    .setPublicPath('./web/dist')

    .webpackConfig({
        plugins: webpackPlugins,
    })

    .options({
        // Our own set of PostCSS plugins.
        postCss: [
            require('postcss-easy-import')(),
            require('tailwindcss'),
            require('postcss-object-fit-images'),
            require('autoprefixer'),
            require('postcss-preset-env')({ stage: 1 }),
            require('cssnano')({preset: 'default'}),
        ],

        // CSSNext already processes our css with Autoprefixer, so we don't
        // need mix to do it twice.
        autoprefixer: false,

        // Since we don't do any image preprocessing and write url's that are
        // relative to the site root, we don't want the css loader to try to
        // follow paths in `url()` functions.
        processCssUrls: false,
    })

    .sourceMaps()

    .version()

    .babelConfig({
        plugins: ['@babel/syntax-dynamic-import'],
    })

    .purgeCss({
        enabled: mix.inProduction(),
        globs: [
            path.join(__dirname, "/templates/**/*.{html,twig}"),
            path.join(__dirname, "/src/css/**/*.css"),
            path.join(__dirname, "/src/js/**/*.vue"),
        ],
        extensions: ["html", "js", "php", "vue", "twig", "scss", "css"],
        whitelistPatterns: [/ls-blur-up-img/],
        whitelistPatternsChildren: [/body/, /ls-blur-up-img/, /form/],
    });
