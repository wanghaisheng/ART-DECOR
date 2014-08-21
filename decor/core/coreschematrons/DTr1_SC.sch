<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Datatype 1.0 SC - Character String with Code
    Status: draft
-->
<rule abstract="true" id="SC" xmlns="http://purl.oclc.org/dsdl/schematron">
    <extends rule="ST"/>
    
    <!--assert role="error" test="@nullFlavor or @code or (hl7:originalText and not(hl7:originalText/@nullFlavor))">dtr1-1-SC: null or code and/or originalText</assert-->
    <assert role="error" test="@codeSystem or not(@code)">dtr1-2-SC: code requires codeSystem</assert>
    <assert role="error" test="@codeSystem or not(@codeSystemName)">dtr1-3-SC: codeSystemName only if codeSystem</assert>
    <assert role="error" test="@codeSystem or not(@codeSystemVersion)">dtr1-4-SC: codeSystemVersion only if codeSystem</assert>
    <assert role="error" test="@code or not(@displayName)">dtr1-5-SC: displayName only if code</assert>
    <assert role="error" test="not(@nullFlavor) or (@nullFlavor and not(@code))">dtr1-6-SC: no code if null</assert>
    <assert role="error" test="not(@nullFlavor) or (@nullFlavor and not(@displayName))">dtr1-7-SC: no displayName if null</assert>
</rule>