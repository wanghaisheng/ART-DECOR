xquery version "1.0";
(:
    Copyright (C) 2011-2014 ART-DECOR expert group art-decor.org
    
    Author: Gerrit Boers

    This program is free software; you can redistribute it and/or modify it under the terms of the
    GNU Lesser General Public License as published by the Free Software Foundation; either version
    2.1 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU Lesser General Public License for more details.

    The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
:)

(:
   Query for deleting lock entries AND deleting newly created concepts
   Input:
   edited dataset 
   Return:
   data-safe=true
:)
import module namespace get ="http://art-decor.org/ns/art-decor-settings" at "art-decor-settings.xqm";

let $dataset := request:get-data()/dataset
let $clear :=
   for $lock in $dataset//conceptLock
   return
   update delete $get:colArtResources//conceptLock[@ref=$lock/@ref][@effectiveDate=$lock/@effectiveDate]
let $deletes :=
   for $concept in $dataset//concept[@statusCode='new']
   return
   update delete $get:colDecorData//concept[@id=$concept/@id][@effectiveDate=$concept/@effectiveDate]
return
<data-safe>true</data-safe>
