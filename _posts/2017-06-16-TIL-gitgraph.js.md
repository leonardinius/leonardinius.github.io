---
title: "TIL gitgraph.js"
layout: post
tags: [til, git, graph]
permalink: 2017/06/today-i-learned-2017-06_1-gitgraphjs
---

Today I learned a useful release process drawing trick. The best way to ensure I don't forget it about it tomorrow is post-it blog. 
![gitgraph.js render example](/img/posts/2017-06-gitgraphjs.png) 

## Contents 

Given the length, here's a helpful table of contents.

 - [Intent](#intent)
 - [Example: Draw line with process steps](#example-draw-line-with-process-steps)
 - [Example: Detour (split) the process](#example-detour-split-the-process)
 - [Example: Process junction](#example-process-junction)
 - [Full Sketch & Source code](#full-sketch--source-code)
 
## Intent

Today I had the exercise to draw the diagram of release process. Puzzled by this task I searched around that is the best way to draw the thing.
I remembered `git-flow` [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/) diagram, which I find visually appealing.

Using my google-fu I discovered [gitgraph.js](http://gitgraphjs.com/), which visually is similar to style I like. 

So, I decided to use this to scratch 2 itches: 1. draw the thing :) 2. code the thing.

Why _code the thing_ is important here? If I missed something, or would like to reorganize some bits - I now have the option to _refactor_ it. Ok, I can hear you now:   

> Developers like to develop and refactor things

And you are absolutely right, we do! 

## Example: Draw line with process steps

We emulate this with branches and commits.

![Line with process steps](/img/posts/2017-06-example-sketch-1.png)

```javascript
// config - defines the layout of the graph, e.g. vertical or horizontal, colors, fonts etc..
var gitgraph = new GitGraph(config);

// Define the line.
var master = gitgraph.branch({ name: "master", column: 0 });

// Add initial point, as thick blue cicrle with white center.
master.commit({ message: mkLoremIpsum("1.0.0.0-SNAPSHOT"), dotStrokeWidth: 10, dotStrokeColor: "blue", color: "white" });
// add point without message and metadata 
master.commit({ messageDisplay: false });
master.commit({ message: mkLoremIpsum("1.0.1.0-SNAPSHOT") });
```

## Example: Detour (split) the process

We emulate this with extra branches.

![Process detour](/img/posts/2017-06-example-sketch-2.png)

```javascript
var release = gitgraph.branch({ parentBranch: master, name: "v1.2.1.0", column: 1 });
release.commit({ messageDisplay: false });
```

## Example: Process junction

We emulate this this merges.

![Process junxtion](/img/posts/2017-06-example-sketch-3.png)

```javascript
release.commit({ message: mkLoremIpsum("1.2.1.2"), tag: "v1.2.1.2" });
release.merge(master, { dotStrokeWidth: 10, message: mkLoremIpsum("2.0.0.0-SNAPSHOT") });
```

## Full Sketch & Source code

![Example Sketch](/img/posts/2017-06-example-sketch.png)

The sketch source code could is found at [https://gist.github.com/leonardinius/128fa84a13c35e9b0dae1b74ac677815](https://gist.github.com/leonardinius/128fa84a13c35e9b0dae1b74ac677815).

**Voilà**