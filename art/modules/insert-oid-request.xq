xquery version "1.0";
(:
    Copyright (C) 2011-2014 ART-DECOR expert group art-decor.org
    
    Author: Alexander Henket, Kai Heitmann

    This program is free software; you can redistribute it and/or modify it under the terms of the
    GNU Lesser General Public License as published by the Free Software Foundation; either version
    2.1 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU Lesser General Public License for more details.

    The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
:)
import module namespace get = "http://art-decor.org/ns/art-decor-settings" at "art-decor-settings.xqm";
import module namespace f   = "urn:decor:REST:v1" at "../../decor/services/modules/get-message.xquery";
declare namespace xhtml     = "http://www.w3.org/1999/xhtml";

declare function local:parseTelecom($tel as xs:string) as xs:string {
    let $telClean := replace($tel,'\s','')
    return
    if (matches($telClean,'^[A-Za-z]+:')) then (
        $telClean
    ) else if (matches($telClean,'[^@]+@[^\.]+\.\S+')) then (
        concat('mailto:',$telClean)
    ) else if (matches($telClean,'\s*\+?[0-9() -]+')) then (
        concat('tel:',$telClean)
    ) else (
        $telClean
    )
};

let $request    := request:get-data()/oid
let $language   := request:get-parameter('language', $get:strArtLanguage)
    
(:let $request :=
<oid>
    <dotNotation value="1.2.3"/>
    <symbolicName value="symName"/>
    <category code="N"/>
    <status code="pending"/>
    <realm code="NL"/>
    <description language="en-US" mediaType="text/plain" value="Description Text Here">
        <thumbnail value=""/>
    </description>
    <registrationAuthority>
        <code code="PRI"/>
        <scopingOrganization>
            <id value="2.16.840.1.113883.2.4.3.11"/>
            <name>
                <part value="Nictiz"/>
            </name>
            <addr>
                <part value=""/>
            </addr>
            <telecom value=""/>
        </scopingOrganization>
    </registrationAuthority>
    <responsibleAuthority>
        <code code="PRI"/>
        <statusCode code="active"/>
        <validTime>
            <low value="2006-09-18"/>
            <high value=""/>
        </validTime>
        <scopingOrganization>
            <id value="1.2.3"/>
            <name>
                <part value=""/>
            </name>
            <addr>
                <part value=""/>
            </addr>
            <telecom value=""/>
        </scopingOrganization>
    </responsibleAuthority>
</oid>:)
  
let $newRequest :=
    <oid>{
        $request/dotNotation,
        $request/symbolicName,
        $request/category,
        $request/status,
        $request/realm,
        $request/description,
        if ($request/registrationAuthority) then (
            <registrationAuthority>{
                $request/registrationAuthority/code,
                if ($request/registrationAuthority/person) then (
                    <person>{
                        $request/registrationAuthority/person/name,
                        $request/registrationAuthority/person/addr,
                        for $tel in $request/registrationAuthority/person/telecom
                        return
                            <telecom value="{local:parseTelecom($tel/@value)}"/>
                    }</person>
                ) else (),
                <scopingOrganization>{
                    if ($request/registrationAuthority/scopingOrganization/id/@value) then (
                        $request/registrationAuthority/scopingOrganization/id
                    ) else (),
                    $request/registrationAuthority/scopingOrganization/name,
                    $request/registrationAuthority/scopingOrganization/addr,
                    for $tel in $request/registrationAuthority/scopingOrganization/telecom
                        return
                            <telecom value="{local:parseTelecom($tel/@value)}"/>
                }</scopingOrganization>
            }</registrationAuthority>
        ) else (),
        
        if ($request/responsibleAuthority) then (
            <responsibleAuthority>{
                $request/responsibleAuthority/code,
                $request/responsibleAuthority/statusCode,
                if ($request/responsibleAuthority/validTime/low/@value) then (
                    <validTime>{
                        <low value="{replace($request/responsibleAuthority/validTime/low/@value,'[T:-]','')}"/>,
                        if ($request/responsibleAuthority/validTime/high/@value!='') then (
                            <high value="{replace($request/responsibleAuthority/validTime/high/@value,'[T:-]','')}"/>
                        ) else ()
                    }</validTime>
                ) else (),
                if ($request/responsibleAuthority/person) then (
                    <person>{
                        $request/responsibleAuthority/person/name,
                        $request/responsibleAuthority/person/addr,
                        for $tel in $request/responsibleAuthority/person/telecom
                        return
                            <telecom value="{local:parseTelecom($tel/@value)}"/>
                    }</person>
                ) else (),
                <scopingOrganization>{
                    if ($request/responsibleAuthority/scopingOrganization/id/@value) then (
                        $request/responsibleAuthority/scopingOrganization/id
                    ) else (),
                    $request/responsibleAuthority/scopingOrganization/name,
                    $request/responsibleAuthority/scopingOrganization/addr,
                    for $tel in $request/responsibleAuthority/scopingOrganization/telecom
                        return
                            <telecom value="{local:parseTelecom($tel/@value)}"/>
                }</scopingOrganization>
            }</responsibleAuthority>
        ) else (),
        
        if ($request/submittingAuthority) then (
             <submittingAuthority>{
                $request/submittingAuthority/code,
                if ($request/submittingAuthority/applicationDate/@value!='') then (
                    <applicationDate value="{replace($request/submittingAuthority/applicationDate/@value,'[T:-]','')}"/>
                ) else (),
                if ($request/submittingAuthority/person) then (
                    <person>{
                        $request/submittingAuthority/person/name,
                        $request/submittingAuthority/person/addr,
                        for $tel in $request/submittingAuthority/person/telecom
                        return
                            <telecom value="{local:parseTelecom($tel/@value)}"/>
                    }</person>
                ) else (),
                <scopingOrganization>{
                    if ($request/submittingAuthority/scopingOrganization/id/@value) then (
                        $request/submittingAuthority/scopingOrganization/id
                    ) else (),
                    $request/submittingAuthority/scopingOrganization/name,
                    $request/submittingAuthority/scopingOrganization/addr,
                    for $tel in $request/submittingAuthority/scopingOrganization/telecom
                        return
                            <telecom value="{local:parseTelecom($tel/@value)}"/>
                }</scopingOrganization>
            }</submittingAuthority>
        ) else (),
        
        $request/additionalProperty,
        
        for $historyAnnotation in $request/historyAnnotation
        return (
            if ($historyAnnotation/annotationDate/@value!='') then (
                <applicationDate value="{replace($historyAnnotation/annotationDate/@value,'[T:-]','')}"/>
            ) else (),
            $historyAnnotation/historyAnnotation/text
        ),
        
        for $reference in $request/reference
        return (
            $reference/reference/ref,
            $reference/reference/type,
            if ($reference/lastVisitedDate/@value!='') then (
                <applicationDate value="{replace($reference/lastVisitedDate/@value,'[T:-]','')}"/>
            ) else ()
        )
    }</oid>

let $id := $request//dotNotation/@value

let $messageSchema := doc(concat($get:strOidsCore,'/iso-13582-sor.xsd'))
let $schemaReport  := validation:jaxv-report($newRequest,$messageSchema)
let $schemaIssues  := 
    for $schemaIssue in $schemaReport//*[@level='Warning' or @level='Error']
        let $location := concat($schemaIssue/@line,':',$schemaIssue/@column)
    return
        <issue type="schema" role="{if ($schemaIssue/@level='Error') then 'error' else ($schemaIssue/@level)}" count="{if ($schemaIssue/@repeat) then $schemaIssue/@repeat else ('1')}">
            <description>{$schemaIssue/text()}</description>
            <location line="{$location}"/>
        </issue>
let $issueReport := <validationReport>{$schemaIssues}</validationReport>

return
    if ($schemaIssues//issue/@role='error') then (
        response:set-status-code(409), response:set-header('Content-Type','text/html; charset=utf-8'), 
        <error><text>{f:getMessage('errorOidValidationError',$language)}</text>{$schemaIssues}</error>
    ) else if (doc(concat($get:strOidsData,'/nictizoids-request.xml'))/*/oid/dotNotation/@value=$id) then (
        response:set-status-code(409), response:set-header('Content-Type','text/html; charset=utf-8'), 
        <error>{f:getMessage('errorOidAlreadyExistsOnRegistry',$language)}</error>
    ) else if (doc(concat($get:strOidsData,'/nictizoids.xml'))/*/oid/dotNotation/@value=$id) then (
        response:set-status-code(409), response:set-header('Content-Type','text/html; charset=utf-8'), 
        <error>{f:getMessage('errorOidAlreadyExistsOnProductionRegistry',$language)}</error>
    ) else (
        response:set-header('Content-Type','text/html; charset=utf-8'), 
        <response>{update insert $newRequest into doc(concat($get:strOidsData,'/nictizoids-request.xml'))/*}</response>
    )