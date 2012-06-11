# iSysBio


## Overview

**iSysbio** is a iOS application built using Delphi XE2 Firemonkey that can be use to draw node and edge diagrams.

Here is a [video](http://www.youtube.com/watch?v=ebSBG0TEpHQ) demonstrating its basic function.

## Instructions for building

* Follow the [setup instructions](http://docwiki.embarcadero.com/RADStudio/en/FireMonkey_Development_Setup_for_iOS) for building iOS applications with Delphi.
* Run DPR2XCODE on Delphi in Windows. This produces the xcode project files and dependencies.
* Make the xcode folder accessible to the OS X machine, which is used for testing and pushing the application to iOS devices. An easy way to share the xcode project files is through [DropBox](http://www.dropbox.com/).
* Use Xcode on OS X build and run the application, iPad or iPhone simulators may be used.

## Project Files Descriptions

* **uiMain.pas** contains the user interface logic for iSysBio.
* **uNodes.pas** contains the TNode class that is used to create and store nodes.
* **uEdges.pas** contains the TEdge class that is used to create and store edges.