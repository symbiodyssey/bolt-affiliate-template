#!/bin/bash
#Script to install the affiliate website template

#Installation of the needed plugins
php app/nut extensions:install bolt/sitemap ^2.2-stable
php app/nut extensions:install bobdenotter/seo ^1.0-stable
php app/nut extensions:install hellonico/minify-html ^0.1-stable
php app/nut extensions:install bolt/robots ^1.0-stable
php app/nut extensions:install bolt/labels ^3.1-stable
php app/nut extensions:install bacboslab/menueditor ^3.2-stable
php app/nut extensions:install bolt/googleanalytics ^2.1-stable
php app/nut extensions:install xiaohutai/bolt-relatedcontentbytags ^3.0-stable

#Installation of the template
php app/nut extensions:install symbiodyssey/affiliatews-theme ^1.5-stable
