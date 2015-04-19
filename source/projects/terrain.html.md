---
title: Terrain
---

When starting new projects, there comes a choice between using an existing css framework or starting from scratch. Both approaches have their advantages and disadvantages -- despite what some people may think, I've learned **there isn't a right answer**.

<div class="mobile"><iframe src="//terrain.io/" frameborder="0"></iframe></div>

Factors include the intended scale and uniqueness of design of the project. The time and quality difference between fitting an existing solution to meet the needs of the project and just getting started can vary greatly.

[Terrain](http://terrain.io) is a project that follows an approach very similar to other great projects like [Skeleton](http://getskeleton.com) in that it aims to provide a great baseline for new projects. It is meant to be extended, and the few components it does have only inlcluded if required.

The intitial work for the project came from a number of different projects within [NetEngine](http://netengine.com.au) that had their own very specific framework, but where duplication of the same boilerplate occurred every time. Most of the components stemmed from [Trigger](https://triggerapp.com).

<div class="tablet"><iframe src="//www.terrain.io/#interactive" frameborder="0"></iframe></div>

See more about the project at [terrain.io](http://terrain.io)

<style>
  html:before, html:after {
    content: '';
    position: absolute;
    left: 0;
    right: 0;
  }

  html:before {
    top: 0;
    height: 100vh;
    z-index: -1;
    background: url(http://www.terrain.io/images/mountain.jpg) no-repeat top;
    opacity: .1;
  }

  html:after {
    bottom: 0;
    height: 50vh;
    background: -webkit-linear-gradient(hsla(230, 100%, 95%, 0), white);
    background: linear-gradient(hsla(230, 100%, 95%, 0), white);
    z-index: -1;
  }
</style>
