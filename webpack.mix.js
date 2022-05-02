/**
 * ===========================
 * Agency Webpack-Mix Config
 * A capable website/webapp config built for the modern web agency.
 * https://github.com/ben-rogerson/agency-webpack-mix-config
 * ===========================
 *
 * Contents
 *
 * 🎚️ Settings
 * 🏠 Templates
 * 🎨 Styles
 * 🎨 Styles: CriticalCSS
 * 🎨 Styles: PostCSS
 * 🎨 Styles: Polyfills
 * 🎨 Styles: Vendor
 * 🎨 Styles: Other
 * 📑 Scripts
 * 📑 Scripts: Polyfills
 * 📑 Scripts: Auto import libraries
 * 📑 Scripts: Linting
 * 🗂️ Static
 * 🚧 Webpack-dev-server
 */

require('dotenv').config()

// 🎚️ Base config
const config = {
  // Dev domain to proxy
  devProxyDomain: process.env.BASE_URL || "http://site.test",
  // Paths to observe for changes then trigger a full page reload
  devWatchPaths: ["templates"],
  // Port to use with webpack-dev-server
  devServerPort: 8080,
  // Build a static site from the src/template files
  buildStaticSite: false,
  // Urls for CriticalCss to look for "above the fold" Css
  criticalCssUrls: [
    // { urlPath: "/", label: "homepage"},
    // { urlPath: "/", label: "index" },
    // { urlPath: "/about", label: "about" },
  ],
  // Folder served to users
  publicFolder: "web",
  // Foldername for built src assets (publicFolder base)
  publicBuildFolder: "/dist",
}

// 🎚️ Imports
const mix = require("laravel-mix")
const path = require("path")
const globby = require("globby")

// 🎚️ Source folders
const source = {
  icons: path.resolve("src/icons"),
  images: path.resolve("src/images"),
  scripts: path.resolve("src/scripts"),
  styles: path.resolve("src/styles"),
  static: path.resolve("src/static"),
  templates: path.resolve("templates"),
}

// 🎚️ Misc
mix.setPublicPath(config.publicFolder)
mix.disableNotifications()
mix.webpackConfig({ 
  resolve: { alias: source },
  stats: {
    children: true
  } 
})
!mix.inProduction() && mix.sourceMaps()

/**
 * 🏠 Templates (for static sites)
 * Convert Twig files to Html
 * https://github.com/ben-rogerson/laravel-mix-twig-to-html
 */
if (config.buildStaticSite && source.templates) {
  require("laravel-mix-twig-to-html")
  mix.twigToHtml({
    files: [
      {
        template: path.resolve(
          __dirname,
          source.templates,
          "**/*.{twig,html}"
        ),
        minify: {
          collapseWhitespace: mix.inProduction(),
          removeComments: mix.inProduction(),
        },
      },
    ],
    fileBase: source.templates,
    twigOptions: {
      data: require(path.join(source.templates, "_data", "data.js")),
    },
  })
}

/**
 * 🎭 Hashing (for non-static sites)
 * Mix has querystring hashing by default, eg: main.css?id=abcd1234
 * This script converts it to filename hashing, eg: main.abcd1234.css
 * https://github.com/JeffreyWay/laravel-mix/issues/1022#issuecomment-379168021
 */

if (mix.inProduction() && !config.buildStaticSite) {
  // Allow versioning in production
  mix.version()
  // Get the manifest filepath for filehash conversion
  const manifestPath = path.join(config.publicFolder, "mix-manifest.json")
  // Run after mix finishes
  mix.then(() => {
    const convertToFileHash = require("laravel-mix-make-file-hash")
    convertToFileHash({
      publicPath: config.publicFolder,
      manifestFilePath: manifestPath,
    })
  })
}

/**
 * 🎨 Styles: Main
 * Uses PostCSS to preproccess 
 */
mix.postCss(
  './src/styles/site.css', path.join(config.publicFolder, config.publicBuildFolder)
)

/**
 * 🎨 Styles: CriticalCSS
 * https://github.com/addyosmani/critical#options
 */
const criticalDomain = config.devProxyDomain
if (criticalDomain && config.criticalCssUrls && config.criticalCssUrls.length) {
  require("laravel-mix-criticalcss")
  mix.criticalCss({
    enabled: true,
    paths: {
      base: criticalDomain,
      templates: '../templates/_critical/',  //Where css files need to be written, all these paths are relative to /public      
      suffix: '_critical.min'
    },
    urls: config.criticalCssUrls,
    //Now using https://github.com/addyosmani/critical v4.0.1
    options: {
      //It's important to note here you should NOT set inline:true, this will break the whole system.
      width: 1200,
      height: 1200,
      penthouse:{
        timeout:1200000
      }
    },
  })
}

/**
 * 🎨 Styles: PostCSS
 * Extend Css with plugins
 * https://laravel-mix.com/docs/4.0/css-preprocessors#postcss-plugins
 */
const postCssPlugins = [
  /**
  * 🎨 Styles: Polyfills
  * Postcss preset env lets you use pre-implemented css features
  * See https://cssdb.org/ for supported features
  * https://github.com/csstools/postcss-preset-env#readme
  */
  require('postcss-easy-import')(),
  require('tailwindcss/nesting'),
  require('tailwindcss'),
  // require('postcss-object-fit-images'),
  require('postcss-preset-env')({
    stage: 1,
    autoprefixer: { grid: false },
    features: {
      'focus-within-pseudo-class': false
    }
  }),
]
mix.options({ postCss: postCssPlugins })

/**
* 🎨 Styles: Other
* https://laravel-mix.com/docs/4.0/options
*/
mix.options({
  // postcss-preset-env already processes our css with Autoprefixer, so we don't
  // need mix to do it twice.
  autoprefixer: false,
  // Disable processing css urls for speed
  // https://laravel-mix.com/docs/4.0/css-preprocessors#css-url-rewriting
  processCssUrls: false,
})

/**
* 📑 Scripts: Main
* Script files are transpiled to vanilla JavaScript
* https://laravel-mix.com/docs/4.0/mixjs
*/
const scriptFiles = globby.sync(`${source.scripts}/*.{js,mjs,ts,tsx}`)
scriptFiles.forEach(scriptFile => {
  mix.js(scriptFile, config.publicBuildFolder)
})

/**
* 📑 Scripts: Polyfills
* Automatically add polyfills for target browsers with core-js@3
* See "browserslist" in package.json for your targets
* https://github.com/zloirock/core-js/blob/master/docs/2019-03-19-core-js-3-babel-and-a-look-into-the-future.md
* https://github.com/scottcharlesworth/laravel-mix-polyfill#options
*/
require("laravel-mix-polyfill")
mix.polyfill({
  enabled: mix.inProduction(),
  useBuiltIns: "usage", // Only add a polyfill when a feature is used
  targets: false, // "false" makes the config use browserslist targets in package.json
  corejs: 3,
  debug: false, // "true" to check which polyfills are being used
})

/**
 * 📑 Scripts: Auto import libraries
 * Make JavaScript libraries available without an import
 * https://laravel-mix.com/docs/4.0/autoloading
 */
mix.autoload({
  // jquery: ["$", "jQuery", "window.jQuery"],
})

/**
* 📑 Scripts: Vendor
* Separate the JavaScript code imported from node_modules
* https://laravel-mix.com/docs/4.0/extract
* Without mix.extract you'll see an annoying js error after
* launching the dev server - this should be fixed in webpack 5
*/
mix.extract([]) // Empty params = separate all node_modules
// mix.extract(['jquery']) // Specify packages to add to the vendor file

/**
 * 📑 Scripts: Linting
 */
if (!mix.inProduction()) {
  require("laravel-mix-eslint")
  mix.eslint()
}

/**
 * 🏞 Images
 * Images are copied to the build directory
 */
  // mix.copy('src/static/fonts/icons', './vendor/dolphiq/iconpicker/src/resources-shared/fonts')

/**
 * 🗂️ Static
 * Additional folders with no transform requirements are copied to your build folders
 */
mix.copyDirectory(
  source.static,
  path.join(config.publicFolder, config.publicBuildFolder)
)

/**
 * 🚧 Webpack-dev-server
 * https://webpack.js.org/configuration/dev-server/
 */
mix.webpackConfig({
  devServer: {
  clientLogLevel: "none", // Hide console feedback so eslint can take over
  open: true,
  overlay: true,
  port: config.devServerPort,
  public: `localhost:${config.devServerPort}`,
  host: "0.0.0.0", // Allows access from network
  https: config.devProxyDomain.includes("https://"),
  contentBase: config.devWatchPaths.length
    ? config.devWatchPaths
    : undefined,
  watchContentBase: config.devWatchPaths.length > 0,
  watchOptions: {
    aggregateTimeout: 200,
    poll: 200, // Lower for faster reloads (more cpu intensive)
    ignored: ["storage", "node_modules", "vendor"],
  },
  disableHostCheck: true, // Fixes "Invalid Host header error" on assets
  headers: {
    "Access-Control-Allow-Origin": "*",
  },
  proxy: {
    "**": {
        target: config.devProxyDomain,
        changeOrigin: true,
        secure: false,
    },
  },
  publicPath: "/",
  },
})
mix.options({
  hmrOptions: {
    host: 'localhost',
    port: config.devServerPort
  },
})