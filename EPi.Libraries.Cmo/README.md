# EPi.Libraries.Favicons

By Jeroen Stemerdink

[![GitHub version](https://badge.fury.io/gh/jstemerdink%2FEPi.Libraries.Cmo.svg)](http://badge.fury.io/gh/jstemerdink%2FEPi.Libraries.Cmo)
[![Platform](https://img.shields.io/badge/platform-.NET 4.5-blue.svg?style=flat)](https://msdn.microsoft.com/en-us/library/w0x726c2%28v=vs.110%29.aspx)
[![Platform](https://img.shields.io/badge/EPiServer-%209.0.0-orange.svg?style=flat)](http://world.episerver.com/cms/)


## Instructions


You still cannot do a clean install of EPiServer CMO. 
You had to create a site in the Deployment Center go through the update process, etc. 
Not a nice way to go, and certainly not every time a customer would like to ue CMO.

So I have put all the files here, including a transformation file for your web.config.

After installing this package, you will need to run the sql script on your EPiServerDB, or a seperate one if you want.
You will also need to update the CMO connectionstring with the correct datasource.

> *Powered by ReSharper*
> [![image](http://resources.jetbrains.com/assets/media/open-graph/jetbrains_250x250.png)](http://jetbrains.com)