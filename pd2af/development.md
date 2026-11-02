---
layout: hidden
title: Development (working page)
permalink: /pd2af/development/
hidden: true
sitemap: false
---

# Development

State (2 November 2026): our own engine, written in Python, applies the [rules](/pd2af/rules/) in two layers (Process
Description to Activity Flow, then Activity Flow to Boolean rules). Every influence it writes names the rule that made
it, and each rule's option can be switched for one run, so the effect of a choice is seen on real modules. On the
first module it reproduces the hand-made Activity Flow, with the same rules from GraphML, CellDesigner and SBGN-ML
input. After each conversion it checks that no activity is left without the regulation it was kept for, and that no
molecule of the map is lost.

What goes here: The state of the work, what is decided and what is open, and how the rules and the engine are developed. The counterpart of the official Development page.
