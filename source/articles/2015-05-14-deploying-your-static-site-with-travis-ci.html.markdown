---
title: Deploying your static site with Travis CI
date: 2015-05-14
tags: travis, bash, static sites, middleman, github pages
---

So I know I just wrote [a post](/blog/simple-static-sites) about deploying your sites with [Netlify](https://www.netlify.com/), but this very website uses [Travis CI](https://travis-ci.org/) for continuous deployment. There was just one minor issue that was preventing the CI/CD process running smoothly... Any Pull Requests submitted to `master` were deployed just the same as a commit directly to master.

At first I thought it was an issue with the configuration. _Travis_ allows you to specify branches to run on, e.g.

    branches:
      only:
        - master

    script:
      - 'bundle exec middleman build && bundle exec middleman deploy' # etc.


So, great, it should only run on master. If you push a bunch of commits to say `my_new_feature` branch, no builds from _Travis_. Pull requests are treated a little differently though, when you submit a PR to merge that branch into master, it runs the build no matter what branch it came from.

Now this actually makes sense: test that the new feature branch is A-OK, so that it can be merged into master. The problem is we were running the deploy script on a successful build, so for this website it would, for example, publish a perfectly 'valid' blog post, even if it hadn't been proofread. It was arguably a little too ambitious with the _Continuous_ part of [Continuous Delivery](http://en.wikipedia.org/wiki/Continuous_delivery).

So, we've made some changes to the _Travis_ setup. We've now removed the deploying element from the script, and separated it:

    script:
      - 'npm install -g bower'
      - 'bower install -f'
      - 'bundle exec middleman build'


This tests that everything is OK with the build process, and if it succeeds...

    after_success:
      - './deploy.sh'

Which runs the following in `deploy.sh`

    #!/bin/bash

    if ([ $TRAVIS_BRANCH == "master" ] && [ $TRAVIS_PULL_REQUEST == "false" ])
    then
      bundle exec middleman s3_sync
      echo 'Website published successfully.'
    else
      echo "Build successful, but not publishing!"
    fi

We've moved the deploy script code into a separate bash file to get around syntax errors in YAML (though you can write the same bash inside your `travis.yml`, you just have to escape it).

![Travis build...](http://netengine-blog-media.s3.amazonaws.com/simple_static_sites/travis.png)


<p style="text-align: center; font-size: 1.25em;"><strong>Huzzah!</strong> <img src="http://netengine-blog-media.s3.amazonaws.com/simple_static_sites/fireworks-animated.gif" style="display: inline-block; margin: 1em .5em; height: 3em; vertical-align: middle; box-shadow: none;"></p>


The end process is as follows:

- Any direct commit to `master` runs the build and deploys if successful.
- A Pull Request to be merged to `master` runs the build but doesn’t deploy.
- A merged PR commit runs the build and deploys if successful (acts as normal commit to `master`).

Happy Continuous Delivering :)


_Originally published on [netengine.com.au](http://netengine.com.au/blog/deploying-your-static-site-with-travis-ci/)_

<link rel="canonical" href="http://netengine.com.au/blog/deploying-your-static-site-with-travis-ci/">
