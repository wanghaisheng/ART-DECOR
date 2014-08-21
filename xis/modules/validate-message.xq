xquery version "3.0";
(:
	Copyright (C) 2011-2014 ART-DECOR expert group art-decor.org
	
	Author: Gerrit Boers, Alexander Henket
	
	This program is free software; you can redistribute it and/or modify it under the terms of the
	GNU Lesser General Public License as published by the Free Software Foundation; either version
	2.1 of the License, or (at your option) any later version.
	
	This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
	without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
	See the GNU Lesser General Public License for more details.
	
	The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
:)
import module namespace val  = "http://art-decor.org/ns/validation" at "validation.xqm";
import module namespace get  = "http://art-decor.org/ns/art-decor-settings" at "../../art/modules/art-decor-settings.xqm";

declare namespace request    = "http://exist-db.org/xquery/request";
declare namespace de         = "http://art-decor.org/ns/error";

(: Test account string :)
let $account           := if (request:exists() and string-length(string-join(request:get-parameter('account',()),''))>0) then request:get-parameter('account',())[1] else ()
(: file name :)
let $file              := if (request:exists() and string-length(string-join(request:get-parameter('file',()),''))>0) then request:get-parameter('file',())[1] else ()
let $file              := encode-for-uri($file)
(: xpath to fragment :)
let $xpath             := if (request:exists() and string-length(string-join(request:get-parameter('xpath',()),''))>0) then request:get-parameter('xpath',())[1] else ()
(: Message-id/@root      -- only works for HL7 :)
(:let $root              := normalize-space(request:get-parameter('root',(''))):)
(: Message-id/@extension -- only works for HL7 :)
(:let $extension         := request:get-parameter('extension',('')):)
let $accountPath       := concat($get:strXisAccounts, '/',$account)
let $reportPath        := concat($accountPath, '/reports/')
let $report            := concat($reportPath, $file)

(: Validate if not validated before and if $validationSwitchOff is not true, re-validate if validated with different validation resources :)
let $revalidated       := val:revalidate($account, $file, $xpath)

return
    if (not(doc-available($report))) then
        <validationReport>    
            <error type="schema">
                <issue type="schema" role="error" count="1">
                    <description>Unexpected validation error: no report generated by validate-message</description>
                </issue>
            </error>
        </validationReport>
    else
        doc($report)