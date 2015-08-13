---
title: Blogging straight from Prose.io
date: 2014-09-11
tags: "prose.io, travis, github, middleman. ruby, bash"
---

...with some help from Travis + Middleman & Github

This is just a quick post coming straight from the great service [Prose.io](http://prose.io/). Prose is a "beatifully simple content authoring environment for CMS-free websites" and is very easy to use.

![Prose screenshot](http://netengine-blog-media.s3.amazonaws.com/prose-io/prose-screen.png)

This website is built with [Middleman](http://middlemanapp.com/) which enables easy development and great blog functionality. It handles the building of a static site and assets, but the deployment of a site can go many different ways.

This site has historically been hosted on [GH Pages](https://pages.github.com/) and is now on [Amazon S3](http://aws.amazon.com/s3/). The deployment process will change slightly with different providers.

#### Prose & Middleman

Most of the documentation you'll find involves setting up *Prose* with [Jekyll](http://jekyllrb.com/), which after having tested personally is a very smooth process and one I'd recommend if you don't have a log yet at all. With the site already being a *Middleman* project, it was not too difficult to integrate it without using any Jekyll special sauce... **HEADS UP:** Non-jekyll projects use a `_prose.yml` rather than within a Jekyll `_config.yml`.


**In `_prose.yml`**

    prose:
      rooturl: 'source/blog'
      media: 'source/assets/images'
      metadata:
        source/blog:
          - name: "title"
            field:
              element: "text"
              label: "Title"
              value: ""
          - name: "author"
            field:
              element: "text"
              label: "Author"
              value: ""
          - name: "tags"
            field:
              element: "multiselect"
              label: "Tags"
		      alterable: true
              options:
                - name: 'Tech'
                  value: 'tech'

                ...


#### Along comes Travis...

If you're using a [User page](https://help.github.com/articles/user-organization-and-project-pages) on *GH Pages* with *Prose* & *Jekyll* then you're already finished!

If you're using another tool (Maybe [Gulp](http://gulpjs.com/)? [We use Gulp](http://netengine.com.au/blog/gulp-and-angular-js-a-tune-up/) pretty much everywhere else, MM is just great for blogs!) then you'll need to either manually deploy those changes committed by Prose or get a service/hook to do this for you. We do this with [Travis](https://travis-ci.org/).

**In `.travis.yml`**

    language: ruby

    rvm:
      - 2.1.2

    branches:
      only:
        - master

    before_script:
      # Anything required by your build process...
      - npm install -g grunt-cli
      - npm install -g bower
      - bower install -f

    script:
      # Place your regular build/deploy chain here...
      - "bundle exec middleman build && bundle exec middleman s3_sync"


**FYI:** Both `.travis.yml` & `_prose.yml` will need to be in the root of your repo.


I found [this gist](https://gist.github.com/thomasgohard/6356707) very helpful to get started on this process. Also [this article](http://docs.travis-ci.com/user/getting-started/) is great if you're new to Travis.

This is far simpler than the alternative of installing Ruby/Git/etc. Now for those who just want to write blog articles, the process can be as simple as:

1. Content writer creates blog article
2. It's on the website (in a few mins after Travis build finishes...)

Adding this integration streamlines the process of publishing content for a non-technical member of the team.


_Originally published on [netengine.com.au](http://netengine.com.au/blog/blogging-straight-from-prose-io/)_


<link rel="canonical" href="http://netengine.com.au/blog/blogging-straight-from-prose-io/">
