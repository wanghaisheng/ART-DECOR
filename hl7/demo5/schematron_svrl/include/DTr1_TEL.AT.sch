<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    DTr1 TEL - Telecommunication Address
    Status: draft
-->
<rule xmlns="http://purl.oclc.org/dsdl/schematron"
      abstract="true"
      id="TEL.AT">
    <extends rule="TEL"/>
    
    <let name="urlScheme" value="substring-before(@value,':')"/>
    <assert role="error"
           test="not(@value) or $urlScheme = ('fax', 'file', 'ftp', 'mllp', 'http', 'mailto', 'me', 'modem', 'nfs', 'tel', 'telnet')">dtr1-1-TEL.AT: ungültiges URL-Schema <value-of select="$urlScheme"/>
   </assert>
    <assert role="error"
           test="not(@use) or translate(concat(' ', @use, ' '), '(H|HP|HV|WP|AS|EC|MC|PG) ', '') = ''">dtr1-2-TEL.AT: @use MUSS aus den Werten 'H', 'HP', 'HV', 'WP', 'AS', 'EC', 'MC', 'PG' gewählt werden.</assert>
    
</rule>