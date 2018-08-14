<p align="center">
<a href="https://www.marbles.be/" target="_blank"><img width="100" height="100" src="http://imgur.com/S5hGxX3.jpg" alt="Marbles"></a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="https://craftcms.com/" target="_blank"><img width="312" height="90" src="https://craftcms.com/craftcms.svg" alt="Craft CMS"></a>
</p>

## About marbles/craft

This is an alternate scaffolding package for Craft 3 CMS projects to Pixel & Tonic's canonical [craftcms/craft](https://github.com/craftcms/craft) package based on [nystudio107/craft](https://github.com/nystudio107/craft).

In addition to setting up a new Craft 3 CMS project, this project sets up:
 
* [Craft 3 Multi-Environment](https://github.com/nystudio107/craft3-multi-environment) as described in the [Multi-Environment Config for Craft CMS](https://nystudio107.com/blog/multi-environment-config-for-craft-cms) article
* [Craft-Scripts](https://github.com/nystudio107/craft-scripts) as described in the [Database & Asset Syncing Between Environments in Craft CMS](https://nystudio107.com/blog/database-asset-syncing-between-environments-in-craft-cms), [Mitigating Disaster via Website Backups](https://nystudio107.com/blog/mitigating-disaster-via-website-backups) & [Hardening Craft CMS Permissions](https://nystudio107.com/blog/hardening-craft-cms-permissions) articles
  
...and sets up some other base scaffolding as described to the following articles:

* [A Better package.json for the Frontend](https://nystudio107.com/blog/a-better-package-json-for-the-frontend)
* Frontend Development Automation using Laravel Mix
* [Implementing Critical CSS on your website](https://nystudio107.com/blog/implementing-critical-css)
* [Enhancing a Craft CMS 3 Website with a Custom Module](https://nystudio107.com/blog/enhancing-a-craft-cms-3-website-with-a-custom-module)

It also installs a few base plugins that we use on every project.

## Assumptions Made

Since this is boilerplate that Marbles uses for projects, it is by definition opinionated, and has a number of assumptions:

* Laravel Mix is used as a the frontend workflow automation tool
* [Vue](https://github.com/vuejs/vue) is used as the frontend JavaScript framework, with [Axios](https://github.com/axios/axios) providing the http client
* [Tailwind CSS](https://tailwindcss.com/docs/what-is-tailwind) is used as the utility-first CSS framework
* Critical CSS is used site-wide
* FontFaceObserver is used for font loading
* Craft-Scripts are used for db/asset synching
* Craft 3 Multi-Environment is used for the Craft 3 multi-environment setup

Obviously you're free to remove whatever components you don't need/want to use.

## Using marbles/craft

This project package works exactly the way Pixel & Tonic's [craftcms/craft](https://github.com/craftcms/craft) package works; you create a new project by first creating & installing the project:

    composer create-project marbles/craft PATH

Make sure that `PATH` is the path to your project, including the name you want for the project, e.g.:

    composer create-project marbles/craft craft3

Then `cd` to your new project directory, and run Craft's `setup` console command to create your `.env` environments and optionally install:

    cd PATH
    ./craft setup

Finally, run the `marbles-setup` command to configure Craft-Scripts & Craft 3 Multi-Environment based on your newly created `.env` settings:

    ./marbles-setup

And last but not least:

*Import the databank found in your project folder (craft.sql)*

That's it, enjoy!

If you ever delete the `vendor` folder or such, just re-run:

    ./marbles-setup

...and it will re-create the symlink to your `.env.sh`; don't worry, it won't stomp on any changes you've made.

Below is the entire intact, unmodified `README.md` from Pixel & Tonic's [craftcms/craft](https://github.com/craftcms/craft):

.....

## About Craft CMS

Craft is a flexible and scalable CMS for creating bespoke digital experiences on the web and beyond.

It features:

- An intuitive Control Panel for administration tasks and content creation.
- A clean-slate approach to content modeling and [front-end development](https://docs.craftcms.com/v3/dev/).
- A built-in Plugin Store with hundreds of free and commercial [plugins](https://plugins.craftcms.com/).
- A robust framework for [module and plugin development](https://docs.craftcms.com/v3/extend/).

Learn more about it at [craftcms.com](https://craftcms.com).

## Tech Specs

Craft is written in PHP (7+), and built on the [Yii 2 framework](https://www.yiiframework.com/). It can connect to MySQL (5.5+) and PostgreSQL (9.5+) for content storage.

## Installation

See the following documentation pages for help installing Craft 3:

- [Server Requirements](https://docs.craftcms.com/v3/requirements.html)
- [Installation Instructions](https://docs.craftcms.com/v3/installation.html)
- [Upgrading from Craft 2](https://docs.craftcms.com/v3/upgrade.html)

## Resources

#### Official Resources
- [Documentation](https://docs.craftcms.com/v3/) – Everything from usage instructions to plugin guides. 
- [Class Reference](https://docs.craftcms.com/api/v3/) – Full API and class reference for plugin and module developers.
- [Demo site](https://demo.craftcms.com/) – Quickly launch a personalized demo of a Craft site.
- [Craft Slack](https://craftcms.com/community#slack) – Join one of the most friendly and helpful Slack groups around.
- [Craft Commerce](https://craftcommerce.com/) – First-party e-commerce platform for Craft.

#### Community Resources
- [CraftQuest](https://craftquest.io/) – Unlimited access to Craft training (and more) from Mijingo.
- [Envato Tuts+](https://webdesign.tutsplus.com/categories/craft-cms/courses) – Video courses.
- [nystudio107 Blog](http://straightupcraft.com/) – Articles about Craft and modern web development.
- [Craft Link List](http://craftlinklist.com/) – Bimonthly newsletter about the Craft ecosystem.
- [Craft CMS Stack Exchange](http://craftcms.stackexchange.com/) – Community-run Q&A for Craft developers.