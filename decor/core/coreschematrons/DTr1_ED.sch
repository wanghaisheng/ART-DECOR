<?xml version="1.0" encoding="UTF-8"?>
<!--
    DTr1 ED - Encapsulated Data
    Status: draft
-->
<rule abstract="true" id="ED" xmlns="http://purl.oclc.org/dsdl/schematron">
    <extends rule="BIN"/>

    <assert role="error" test="not(@integrityCheck) or @integrityCheckAlgorithm">dtr1-2-ED: integrityCheckAlgorithm required if integrityCheck</assert>
    <assert role="error"
           test="not(hl7:thumbnail) or hl7:thumbnail[not(@nullFlavor and hl7:reference)]">dtr1-3-ED: thumbnails not null and reference</assert>
    <assert role="error" test="not(hl7:thumbnail) or hl7:thumbnail[not(hl7:thumbnail)]">dtr1-4-ED: thumbnails do not have thumbnails</assert>
    <assert role="error"
           test="(@compression and (hl7:reference/@value or (@representation='B64' and text()))) or not(@compression)">dtr1-5-ED: compression only on binary</assert>

    <assert role="error"
           test="not(@value) or (@value and (not(@mediaType) or @mediaType='text/plain'))">dtr1-6-ED: value implies mediaType is text/plain</assert>
    <assert role="error"
           test="count(*[self::hl7:reference or self::hl7:thumbnail][@validTimeLow or @validTimeHigh or @updateMode])=0">dtr1-7-ED: no history or updateMode</assert>
    <assert role="error" test="not(@value or xml) or not(@charset)">dtr1-8-ED: no charset for value or xml</assert>
    <assert role="error" test="not(hl7:translation) or hl7:thumbnail[not(hl7:translation)]">dtr1-9-ED: no nested translations</assert>
    <assert role="error" test="not(@nullFlavor) or (@nullFlavor and not(@mediaType))">dtr1-10-ED: no mediaType if null</assert>
    <assert role="error" test="not(@nullFlavor) or (@nullFlavor and not(@charset))">dtr1-11-ED: no charset if null</assert>
    <assert role="error" test="not(@nullFlavor) or (@nullFlavor and not(@language))">dtr1-12-ED: no language if null</assert>
    <assert role="error" test="not(@nullFlavor) or (@nullFlavor and not(@compression))">dtr1-13-ED: no compression if null</assert>
    <assert role="error" test="not(@nullFlavor) or (@nullFlavor and not(@integrityCheck))">dtr1-14-ED: no integrityCheck if null</assert>
    <assert role="error"
           test="not(@nullFlavor) or (@nullFlavor and not(@integrityCheckAlgorithm))">dtr1-15-ED: no integrityCheckAlgorithm if null</assert>
    <assert role="error"
           test="not(@nullFlavor) or (not(hl7:thumbnail) or hl7:thumbnail/@nullFlavor)">dtr1-16-ED: no thumbnail if null</assert>
    <assert role="error" test="not(@nullFlavor) or (@nullFlavor and not(hl7:translation))">dtr1-17-ED: no translation if null</assert>

</rule>