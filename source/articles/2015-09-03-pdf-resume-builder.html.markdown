---
title: PDF Résumé Builder
date: 2015-09-03 17:34 EDT
tags:
---

After a solid couple of months traveling around Canada it was time to get back on the tools. I wanted to design and build something useful for myself and for others. I've recently been beefing up my personal site a little bit, and I wanted to further automate the process of updating my [résumé](http://rowanhogan.com/resume/) section.

---

Try out the project for yourself at [resumebuilder.rowanhogan.com](http://resumebuilder.rowanhogan.com/).

---

I ended up taking a different direction than I was originally planning just for this site. Initially I was just focused on scraping data and rendering HTML & PDF with [Middleman](http://middlemanapp.com).

The goal of this project is to allow anyone with a [Linkedin](https://www.linkedin.com/) profile to export a simple, beautiful PDF résumé.

Linkedin itself provides this functionality, but it's a little lacking in the design department, and this app allows you to include additional information. This app allows you to add/remove or update items from the pre-filled data, and provides a small level of design control.

After some playing around, the whole thing ended up being two [Sinatra](http://www.sinatrarb.com/) servers and a static [Angular](https://angularjs.org/) app, but this wasn't how it started out.

![Screenshot](http://res.cloudinary.com/rowanhogan/image/upload/v1441327287/pdf-screen_vgdjvi.png)

Initially (in a couple of hours) I had one Sinatra app that was successfully scraping Linkedin data and rendering PDFs – Job done!

I made use of [this great gem](https://github.com/yatish27/linkedin-scraper) and made a few [additions](https://github.com/yatish27/linkedin-scraper/pull/53) [myself](https://github.com/rowanhogan/linkedin-scraper). PDF rendering was handled by [PDFKit](https://github.com/pdfkit/pdfkit).

Hosting the app in production with these dependencies meant a few changes. Heroku was my first choice, but as Heroku IPs were blocked by Linkedin I had to explore alternative hosting options. This meant splitting up the components into smaller pieces:

- A [static app](https://github.com/rowanhogan/resumebuilder) controlling user input / state
- A [server](https://github.com/rowanhogan/scraper_server) on Openshift running the scraper.
- A [server](https://github.com/rowanhogan/pdf_renderer) on Heroku rendering HTML to PDF.

At this stage I just took a username, grabbed the profile data and generated a plain PDF. Next I built a small AngularJS app to allow the user to modify the data and control the design. Unsurprisingly, this is where I spent a great majority of the design & development time.

The code is available [on Github](https://github.com/rowanhogan/resumebuilder). Contributions welcome!
