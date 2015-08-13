---
title: Simple static sites
date: 2015-05-13
tags: static sites, middleman, github, contentful, netlify
---

It seems not too long ago I wrote [this post](http://netengine.com.au/blog/blogging-straight-from-prose-io/) about blogging and static site generation, but since then I have come across different types of projects which require a slightly different setup.

In that post I went over a process that used [Middleman](https://middlemanapp.com/), [Github](https://github.com/), [Prose](http://prose.io/) & [Travis CI](https://travis-ci.org/) to build, host, author and deploy a static site. Here I've mixed up the process (and the third-parties) a little bit. I'll still be using _Github_ and _Middleman_, but I'll be swapping out _Prose_ for [Contentful](https://www.contentful.com/) and _Travis CI_ for [Netlify](https://www.netlify.com/).

I've created an [example project](https://github.com/net-engine/simple_static_site_example) which uses the process I go through below.

<a class="button button-large" href="https://github.com/net-engine/simple_static_site_example">View example project</a>

![Middleman, Netlify & Contentful](http://netengine-blog-media.s3.amazonaws.com/simple_static_sites/third-party-logos.png)


### How it works

To start we'll need to create a [Middleman](https://middlemanapp.com/basics/install/) project, and host the repo on [Github](https://github.com/). To start adding content sections, simply [create an account](https://be.contentful.com/register) with _Contentful_ and setup an API access key.

![Contentful](http://netengine-blog-media.s3.amazonaws.com/simple_static_sites/contentful.png)

You as the site creator can setup any kind of content type to match the needs of your website. In the [example project](https://github.com/net-engine/simple_static_site_example) I've simply created 'Pages' and 'Blog Posts', but previously I've also used it for site-wide variables such as social media accounts or boolean values for design purposes (e.g. Toggle hero image on/off).

You can see an overview of a middleman project structure by looking at the [example project](https://github.com/net-engine/simple_static_site_example).

**This is where the magic happens.**

So the real hero of this story is the [contentful_middleman](https://github.com/contentful-labs/contentful_middleman) gem. Once you have created a space and any relevant content types, add the access credentials and space configuration to `config.rb`, e.g.:

    activate :contentful do |f|
      f.access_token  = ENV['CONTENTFUL_ACCESS_TOKEN']
      f.space         = { site: ENV['CONTENTFUL_SPACE_ID'] }
      f.content_types = {
        page:      ENV['CONTENTFUL_PAGE_KEY'],
        blog_post: ENV['CONTENTFUL_BLOG_POST_KEY']
      }
    end

Anyone with access to that _Contentful_ account can author content such as blog posts and upload images as they would any other CMS.

Once it's setup, you can run `bundle exec middleman contentful` locally to populate your project with any added content as individual [YAML](http://yaml.org/) files, matching the [defined Middleman structure](https://middlemanapp.com/advanced/data_files/).


#### Taking it live...

Now to make the site update automatically when a change is made by an author on _Contentful_. This is is where [Netlify](https://www.netlify.com/) comes in.

_Netlify_ is a CI server (and hosting provider, and CDN, amongst other things) specifically built for static site generators. It's easy to setup, simply create an account, create a new site, and link it to the corresponding Github repository.

![Netlify](http://netengine-blog-media.s3.amazonaws.com/simple_static_sites/netlify.png)

Once added, you will need to add the "Build Cmd", which for middleman is `middleman build`. And that's it! After linking the repo it is automatically set up to deploy on pushes to `master`. _Netlify_ hosts the site automatically, but you can also configure your build process to deploy elsewhere.

> This process allows for a developer to build a simple, manageable static site which authors can modify to their heart's content.


### Why?

So, why jump through all these hoops? Well, most content-focused websites are a perfect fit for [static site generators](https://www.staticgen.com/) (such as _Middleman_, my preferred tool for the job). For example, a marketing website for a product/service or a blog which has a few pages and a contact form (see at the end for a [bonus on contact forms](#contact_forms)).

However, more often than not there is a need for a non-technical (in a web development sense) content author to be able to add or update content. This is where a traditional CMS (_Wordpress_, _Drupal_, etc) usually rears its ugly head. My process in the [earlier post](http://netengine.com.au/blog/blogging-straight-from-prose-io/) allowed for this workflow, however there were limits to how extensible it was without getting technical. This process allows for a developer to build a simple, manageable static site which authors can change to their heart's content.

In fact, this process would work well for a web designer to setup simple sites to be administered by their non-technical coworkers or clients. They can reuse this process on different sites and modify the HTML/CSS & Javascript as needed.

<hr id="contact_forms">

### Bonus: Contact Forms

"Contact forms on a static site?", you ask. Yes, it's possible, and easy! There are a few different approaches to this, but they will all require some sort of server. My personal favourite (because I'm already using the service) is to set up a Google Form, populating a spreadsheet of responses from which I can trigger an email or other actions. Recently we even used [Trigger's](https://triggerapp.com) email to task functionality to create tasks directly from form submissions (and turn _Trigger_ into a CRM, but that's another story).

An even simpler solution is a service called [Formspree](https://formspree.io/), which allows you to provide an email address, paste the form HTML in your site and start receiving straight away! I've included a _Formspree_ contact form in the [example project](http://net-engine.github.io/simple_static_site_example/contact/)

<a class="button button-large" href="https://github.com/net-engine/simple_static_site_example">View example project</a>

---

N.B. Both _Contentful_ & _Netlify_ can be used with [other](https://github.com/contentful-labs/contentful-metalsmith) [static site generators](https://www.staticgen.com/).


_Originally published on [netengine.com.au](http://netengine.com.au/blog/simple-static-sites/)_

<link rel="canonical" href="http://netengine.com.au/blog/simple-static-sites/">
